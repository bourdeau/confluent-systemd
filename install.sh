#!/usr/bin/env bash

SYSTEMDPATH=/etc/systemd/system
CONFLUENTOPTPATH=/opt/confluent-systemd

# Check if the service already exist and reload daemon if it does
function disableServices() {
    if [ -f "$SYSTEMDPATH/zookeeper.service" ]; then
        sudo systemctl disable zookeeper.service
    fi
    if [ -f "$SYSTEMDPATH/kafka.service" ]; then
        sudo systemctl disable zookeeper.service
    fi
    if [ -f "$SYSTEMDPATH/kafkarest.service" ]; then
        sudo systemctl disable zookeeper.service
    fi

    sudo systemctl daemon-reload
}

# Creating /opt/confluent-systemd directory
function deleteFolder() {
    if [ -d "$CONFLUENTOPTPATH" ];
    then
        sudo rm -rf $CONFLUENTOPTPATH/*
    else
        sudo mkdir $CONFLUENTOPTPATH
    fi
}

# Copy services files
function copyFiles() {
    sudo cp zookeeper.service kafka.service kafkarest.service $CONFLUENTOPTPATH
}

# Enable services
function enableServices() {
    sudo systemctl enable $CONFLUENTOPTPATH/zookeeper.service
    sudo systemctl enable $CONFLUENTOPTPATH/kafka.service
    sudo systemctl enable $CONFLUENTOPTPATH/kafkarest.service

    sudo systemctl daemon-reload
}

# Check services statuses
function checkStatuses() {
    sudo systemctl stop zookeeper.service
    sudo systemctl start zookeeper.service
    sudo systemctl status zookeeper.service

    sudo systemctl stop kafka.service
    sudo systemctl start kafka.service
    sudo systemctl status kafka.service

    sudo systemctl stop kafkarest.service
    sudo systemctl start kafkarest.service
    sudo systemctl status kafkarest.service

}

# Main
disableServices
deleteFolder
copyFiles
enableServices
checkStatuses
