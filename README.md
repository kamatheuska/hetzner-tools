
# Hetzner Tools
🛠️ A collection of utilities for managing Hetzner Cloud infrastructure.

## Overview
This project provides helpful scripts and utilities for managing Hetzner Cloud resources. Mostly for personal use, but decided to publish it, because why not :) 

Main idea is to keep it bash pure, to be easily runned on a linux machine

## Dependencies
Make sure you have the following tools installed:


    hcloud - Hetzner Cloud CLI (docs)
    make - Build automation tool
    curl - Command line tool for transferring data
    jq - Command-line JSON processor

## Tools

1. Firewall IP Updater

- Automatically detects your current public IP address
- Updates Hetzner Cloud firewall rules with the new IP
- Maintains SSH access from dynamic IP addresses
- Simple one-command execution

## TODO

- [] add logger level
