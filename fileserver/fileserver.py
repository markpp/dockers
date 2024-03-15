import http.server
import socketserver
import socket
import os
import argparse

# Create a simple HTTP server to serve the files in the specified directory
def get_local_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(('10.255.255.255', 1))  # Connect to a known address to determine the local IP
    local_ip = s.getsockname()[0]
    s.close()
    return local_ip
    
# python3 fileserver.py --directory
if __name__ == '__main__':

    # Parse the command-line arguments
    parser = argparse.ArgumentParser(description="Serve files in a directory over HTTP")
    parser.add_argument("--directory", default='.', help="the directory to serve")
    parser.add_argument("--port", default=8000, help="the port to use (default: 8000)", type=int)
    args = parser.parse_args()

    # Change to the specified directory
    os.chdir(args.directory)
    
    local_ip = get_local_ip()
    print("local_ip ", local_ip)

    # Create a simple HTTP server
    Handler = http.server.SimpleHTTPRequestHandler
    httpd = socketserver.TCPServer((local_ip, args.port), Handler)

    # Print a message with the server address
    print(f"Serving files at http://{local_ip}:{args.port}/")

    # Start the server
    httpd.serve_forever()

