#!/bin/bash

# Lab 1 - Cleanup Script
# Removes all files and directories created by the setup script
# Authors: Marwa M. El-Azab, Omar M. El-Azab

LAB_DIR="linux_lab1"

confirm_cleanup() {
    read -p "Are you sure you want to delete the entire lab environment at $LAB_DIR? [y/n] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cleanup cancelled."
        exit 1
    fi
}

check_directory() {
    if [ ! -d "$LAB_DIR" ]; then
        echo "Error: Lab directory $LAB_DIR not found."
        echo "Either the environment wasn't set up or was already cleaned up."
        exit 1
    fi
}

remove_lab_env() {
    echo "Removing lab environment..."
    rm -rf "$LAB_DIR"
    
    if [ $? -eq 0 ]; then
        echo "Successfully cleaned up lab environment."
    else
        echo "Error: Failed to remove lab environment." >&2
        exit 1
    fi
}

main() {
    echo "=== Linux Lab 1 Cleanup ==="
    check_directory
    confirm_cleanup
    remove_lab_env
}

main