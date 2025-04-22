#!/bin/bash

export version="2.3.8"
pwd_path=$(pwd)

export SEATUNNEL_HOME="$pwd_path/apache-seatunnel-${version}"

install() {
    echo "Installing Seatunnel version $version..."
    wget "https://archive.apache.org/dist/seatunnel/${version}/apache-seatunnel-${version}-bin.tar.gz"
    
    # it will extract to the $SEATUNNEL_HOME directory
    tar -xzvf "apache-seatunnel-${version}-bin.tar.gz"
    # rm "apache-seatunnel-${version}-bin.tar.gz"
    echo "Seatunnel version $version installed successfully."
}

start() {
    echo "Starting Seatunnel version $version..."
    
    # Start The SeaTunnel Engine Server Node
    # It can be started with the -d parameter through the daemon mode
    mkdir -p $SEATUNNEL_HOME/logs
    $SEATUNNEL_HOME/bin/seatunnel-cluster.sh -d
    echo "Seatunnel version $version started successfully."
    echo "Log file: $SEATUNNEL_HOME/logs/seatunnel-engine-server.log"
}

stop() {
    echo "Stopping Seatunnel version $version..."
    
    # Stop The SeaTunnel Engine Server Node
    $SEATUNNEL_HOME/bin/stop-seatunnel-cluster.sh
    echo "Seatunnel version $version stopped successfully."
}

run() {
    echo "Running Seatunnel version $version..."
    # get config file path by --config
    config_path="$1"
    absolute_path=$(realpath "$pwd_path/$config_path")
    echo "Config file path: $absolute_path"
    
    if [ ! -f "$config_path" ]; then
        echo "Config file not found: $config_path"
        exit 1
    fi
    $SEATUNNEL_HOME/bin/seatunnel.sh --config $absolute_path
}

# get command by arguments
command="$1"

# check command
if [ "$command" = "install" ]; then
    install
    elif [ "$command" = "start" ]; then
    start
    elif [ "$command" = "stop" ]; then
    stop
    elif [ "$command" = "run" ]; then
    run "$2"
else
    echo "Invalid command: $command"
    echo "Usage: $0 {install|start|stop|run <config_file>}"
    echo "Example: $0 run ./jobs/v2.batch.config.template"
    exit 1
fi