#!/bin/bash
#   OmenShell - Manage multiple servers through SSH in one go
#
#   Copyright © 2023, Rodrigo Ernesto Alvarez Aguilera <incognia@gmail.com>
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
#   Version 0.3 - July 11, 2023
#   Author: Rodrigo Ernesto Alvarez Aguilera
#
#   Tested under Ubuntu 22.04.2 LTS using GNU bash version 5.1.16
#

while getopts 'dfhlnstuv' OPTION; do
  case "$OPTION" in
    d)
      omenshell 'df -h | grep -e Usado -e sda -e mapper'
      ;;
    f)
      omenshell 'free -ht'
      ;;
    h)
      omenshell 'hostnamectl | grep -e hostname -e System -e Kernel -e Vendor -e Virt -e Chassis'
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
    p)
      omenshell "sudo -S init 0"
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
    v)
      echo -e "OmenShell version 0.3\nCopyright (C) 2023 Rodrigo Ernesto Álvarez Aguilera"
      echo -e "License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>\n"
      echo -e "This is free software; you are free to change and redistribute it."
      echo -e "There is NO WARRANTY, to the extent permitted by law."
      ;;
    ?)
      echo "script usage:
      [-d] Show information about the remote file system
      [-f] Display amount of free and used memory in each remote system
      [-h] Show the remote system's host name
      [-l] Show a listing of last logged in users
      [-n] Show network and DNS configuration
      [-p] Shutdown ALL servers. Use with caution!
      [-s] Test internet bandwidth using speedtest.net
      [-t] Display Linux processes
      [-u] Tell how long each remote system has been running
      [-v] Show OmenShell version and License"
      >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"