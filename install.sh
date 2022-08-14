#!/bin/bash

mkdir -p ~/bin
cp omen.sh ~/bin/omen
cp omenshell.sh ~/bin/omenshell
cp omen.host ~/bin/omen.host

sudo apt-get update
sudo apt-get install -y figlet

sudo cp future.tlf /usr/share/figlet/
sudo chown root:root /usr/share/figlet/future.tlf

ls -alh /usr/share/figlet/f*