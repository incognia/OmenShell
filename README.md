# OmenShell | Manage multiple servers through SSH

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/license-GPLv3-blue)](https://www.gnu.org/licenses/gpl-3.0.html) Rodrigo Ernesto Álvarez Aguilera | [Mail](mailto:incogniaqgmail.com) | [LinkedIn](https://www.linkedin.com/in/rodrigo-alvarez-aguilera/) | [Blog](https://incognia.wordpress.com/about)

## Requirements

You need a valid user on the remote system with passwordless access via SSH key.

## Configuration

Edit the `omen.host` file to add the remote servers you want to manage.

## Installation

From a Linux terminal type the following commands:
```bash
cd
git clone https://github.com/incognia/OmenShell
cd OmenShell
./install.sh
```

## Usage
```
omen -[option]
      [-d] Show information about the file system
      [-f] Display amount of free and used memory in each system
      [-h] Show the system's host name
      [-l] Show a listing of last logged in users
      [-n] Show network and DNS configuration
      [-s] Test internet bandwidth using speedtest.net
      [-t] Display Linux processes
      [-u] Tell how long each system has been running
```

#### Example

The `omen` command with flag `-u`:
```bash
omen -u
```
Output:
```bash
=======================================================[ Server IP address ]====
                                           ┏━┓┏━┓╺┓  ╺┓ ╺┓ ┏━┓ ╻ ╻┏━┓ ╺┓ ┏━┓┏━┓
                                           ┏━┛┃┃┃ ┃   ┃  ┃ ┣━┓ ┗━┫┃┃┃  ┃ ╺━┫┣━┫
                                           ┗━╸┗━┛╺┻╸╹╺┻╸╺┻╸┗━┛╹  ╹┗━┛╹╺┻╸┗━┛┗━┛
 00:42:57 up 8 days, 14:29,  0 users,  load average: 1.78, 1.74, 1.64
=======================================================[ Server IP address ]====
                                           ┏━┓┏━┓╺┓  ╺┓ ╺┓ ┏━┓ ╻ ╻┏━┓ ╺┓ ╻ ╻╺┓ 
                                           ┏━┛┃┃┃ ┃   ┃  ┃ ┣━┓ ┗━┫┃┃┃  ┃ ┗━┫ ┃ 
                                           ┗━╸┗━┛╺┻╸╹╺┻╸╺┻╸┗━┛╹  ╹┗━┛╹╺┻╸  ╹╺┻╸
 00:42:58 up 1 day, 12:37,  0 users,  load average: 0.00, 0.00, 0.00
===================================================[ OmenShell by incognia ]====
```