# web-camera
Tools to use a smartphone camera (or other video sources) as a webcam in linux.

## Dependencies
You need to have `mkcert` install and run `mkcert --install` to install the root certificate on your system.

## Easy setup for local network

To guess the local ip and run the server on it use:
``` bash
./web-camera -i $(ip route show | head -n 2 | tail -n 1 | cut -d" " -f9)
```