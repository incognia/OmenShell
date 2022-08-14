#!/bin/bash
#   OmenShell - Manage multiple servers through SSH in one go
#
#   Copyright © 2022, Rodrigo Ernesto Alvarez Aguilera <incognia@gmail.com>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Version 0.1 - August 13, 2022
#   Author: Rodrigo Ernesto Alvarez Aguilera
#
#   Tested under Ubuntu 20.04.4 LTS using GNU bash version 5.0.17
#

while getopts 'dfhlnstu' OPTION; do
  case "$OPTION" in
    d)
      omenshell 'df -h | grep -e Usado -e sda -e mapper'
      ;;
    f)
      omenshell 'free -ht'
      ;;
    h)
      omenshell 'hostnamectl | grep -e hostname -e System -e Kernel'
      ;;
    l)
      omenshell 'last -a | sort -k1,1 -u'
      ;;
    n)
      omenshell 'echo -e "::[Network configuration]::\n" &&
      ip a | grep -e eth -e enp -e eno &&
      echo -e "\n::[Default gateway]::\n" &&
      ip -4 route show default &&
      echo -e "\n::[DNS configuration]::\n" &&
      cat /etc/resolv.conf | grep -e search -e nameserver'
      ;;
    s)
      omenshell 'speedtest'
      ;;
    t)
      omenshell 'top -n 1 -b | head -20'
      ;;
    u)
      omenshell 'uptime'
      ;;
    ?)
      echo "script usage: 
      [-d] Show information about the file system
      [-f] Display amount of free and used memory in each system
      [-h] Show the system's host name
      [-l] Show a listing of last logged in users
      [-n] Show network and DNS configuration
      [-s] Test internet bandwidth using speedtest.net
      [-t] Display Linux processes
      [-u] Tell how long each system has been running"
      >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"