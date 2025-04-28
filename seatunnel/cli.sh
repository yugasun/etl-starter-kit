#!/bin/bash

export version="2.3.10"
pwd_path=$(pwd)

export SEATUNNEL_HOME="$pwd_path/apache-seatunnel-${version}"

# md5 of the archive
expected_md5="7c25b64d70a86796e92158b12a4b259d"
archive_name="apache-seatunnel-${version}-bin.tar.gz"

install() {
    echo "Installing SeaTunnel version $version..."

    if [ -f "$archive_name" ]; then
        echo "Found existing $archive_name in current directory."
        current_md5=$(md5sum "$archive_name" | awk '{print $1}')
        if [ "$current_md5" = "$expected_md5" ]; then
            echo "MD5 matches expected ($expected_md5). Skipping download."
        else
            echo "Warning: existing file MD5 is $current_md5, but expected is $expected_md5."
            read -p "Do you want to use the existing file anyway? [y/N]: " answer
            case "$answer" in
                [Yy]* ) echo "Proceeding with existing file despite MD5 mismatch." ;;
                * )
                    echo "Re-downloading $archive_name..."
                    rm -f "$archive_name"
                    wget "https://archive.apache.org/dist/seatunnel/${version}/${archive_name}"
                    ;;
            esac
        fi
    else
        echo "No existing $archive_name found. Downloading..."
        wget "https://archive.apache.org/dist/seatunnel/${version}/${archive_name}"
    fi

    # unpack the archive
    tar -xzvf "$archive_name"
    echo "SeaTunnel version $version installed successfully in $SEATUNNEL_HOME."
}

start() {
    if ! command -v java >/dev/null 2>&1; then
        echo "Error: Java is not installed or not in PATH. Please install Java before starting SeaTunnel."
        exit 1
    fi
    echo "Starting SeaTunnel version $version..."
        
    # Start The SeaTunnel Engine Server Node
    # It can be started with the -d parameter through the daemon mode
    mkdir -p "$SEATUNNEL_HOME/logs"
    "$SEATUNNEL_HOME/bin/seatunnel-cluster.sh" -d
    echo "SeaTunnel version $version started successfully."
    echo "Log file: $SEATUNNEL_HOME/logs/seatunnel-engine-server.log"
}

stop() {
    echo "Stopping SeaTunnel version $version..."

    # Stop The SeaTunnel Engine Server Node
    "$SEATUNNEL_HOME/bin/stop-seatunnel-cluster.sh"
    echo "SeaTunnel version $version stopped successfully."
}

run() {
    echo "Running SeaTunnel version $version..."
    # get config file path by --config
    config_path="$1"
    absolute_path=$(realpath "$pwd_path/$config_path")
    echo "Config file path: $absolute_path"

    if [ ! -f "$config_path" ]; then
        echo "Config file not found: $config_path"
        exit 1
    fi
    "$SEATUNNEL_HOME/bin/seatunnel.sh" --config "$absolute_path"
}

command="$1"

case "$command" in
    install) install ;;
    start)   start ;;
    stop)    stop ;;
    run)     run "$2" ;;
    *)
        echo "Invalid command: $command"
        echo "Usage: $0 {install|start|stop|run <config_file>}"
        echo "Example: $0 run ./jobs/v2.batch.config.template"
        exit 1
        ;;
esac
