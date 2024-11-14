#!/bin/bash

# Function to display script help
show_help() {
  echo "Usage: $0 [OPTIONS]"
  echo "OPTIONS:"
  echo "  -i, --interface <interface>   Name of the network interface (Default: can0)"
  echo "  -b, --bitrate <bitrate>       Bitrate of the interface (Default: 1000000)"
  echo "  -d, --down                    Disconnect the interface"
  echo "  -h, --help                    Display this help and exit"
  exit 0
}

# Default values for the arguments
interface="can0"
bitrate="1000000"
disconnect=false

# Process arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -i|--interface)
      interface="$2"
      shift
      shift
      ;;
    -b|--bitrate)
      bitrate="$2"
      shift
      shift
      ;;
    -d|--down)
      disconnect=true
      shift
      ;;
    -h|--help)
      show_help
      ;;
    *)
      echo "Unknown argument: $1"
      show_help
      ;;
  esac
done

# Connect or disconnect the interface
if [ "$disconnect" = true ]; then
  sudo ip link set $interface down
else
  sudo ip link set $interface up type can bitrate $bitrate
fi
