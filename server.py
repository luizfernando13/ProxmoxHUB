import http.server
import socketserver
import json
import os

PORT = 80
CONFIG_FILE = 'config.json'
# Variável na memória para guardar o clipboard (reseta se reiniciar o serviço)
GLOBAL_CLIPBOARD = {"text": ""}

class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # Rota da API de Clipboard
        if self.path == '/api/clipboard':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps(GLOBAL_CLIPBOARD).encode())
            return

        # Resto do site
        self.send_response(200)
        self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
        self.send_header("Pragma", "no-cache")
        self.send_header("Expires", "0")
        super().do_GET()

    def do_POST(self):
        length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(length)

        if self.path == '/api/save':
            try:
                data = json.loads(post_data)
                with open(CONFIG_FILE, 'w', encoding='utf-8') as f:
                    json.dump(data, f, indent=4)
                self.respond_ok()
            except Exception as e:
                self.respond_error(str(e))

        elif self.path == '/api/clipboard':
            try:
                data = json.loads(post_data)
                GLOBAL_CLIPBOARD['text'] = data.get('text', '')
                self.respond_ok()
            except Exception as e:
                self.respond_error(str(e))
        else:
            self.send_response(404)
            self.end_headers()

    def respond_ok(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        self.wfile.write(b'{"status": "success"}')

    def respond_error(self, msg):
        self.send_response(500)
        self.end_headers()
        self.wfile.write(msg.encode())

# Cria config se não existir
if not os.path.exists(CONFIG_FILE):
    with open(CONFIG_FILE, 'w') as f:
        json.dump([], f)

print(f"Hub rodando na porta {PORT}")
with socketserver.TCPServer(("", PORT), Handler) as httpd:
    httpd.serve_forever()
