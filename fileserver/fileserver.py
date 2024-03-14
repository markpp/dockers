import http.server
import socketserver
import os
import argparse

# Create a simple HTTP server to serve the files in the specified directory

if __name__ == '__main__':

    # Parse the command-line arguments
    parser = argparse.ArgumentParser(description="Serve files in a directory over HTTP")
    parser.add_argument("directory", help="the directory to serve")
    parser.add_argument("--port", default=8000, help="the port to use (default: 8000)", type=int)
    args = parser.parse_args()

    # Change to the specified directory
    os.chdir(args.directory)

    # Create a simple HTTP server
    Handler = http.server.SimpleHTTPRequestHandler
    httpd = socketserver.TCPServer(("127.0.0.1", args.port), Handler)

    # Print a message with the server address
    print(f"Serving files at http://127.0.0.1:{args.port}/")

    # Start the server
    httpd.serve_forever()

