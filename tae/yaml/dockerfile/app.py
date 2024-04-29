from flask import Flask, request

app = Flask(__name__)

@app.route('/')
def index():
    # 클라이언트의 IP 주소 가져오기
    client_ip = request.remote_addr

    # 시스템의 호스트 네임 가져오기
    import socket
    host_name = socket.gethostname()
    host_ip = socket.gethostbyname(host_name)

    return f'접속자 IP: {client_ip}<br>시스템 호스트 네임: {host_name}<br>시스템 IP: {host_ip}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)

