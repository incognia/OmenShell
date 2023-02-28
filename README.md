# OmenShell | Manage multiple servers through SSH

[![License: GPLv3](https://img.shields.io/badge/License-GPLv3-steelblue)](https://www.gnu.org/licenses/gpl-3.0.html) ![Ubuntu](https://img.shields.io/badge/Ubuntu-v22.04.2_LTS-e9500e.svg) ![Bash](https://img.shields.io/badge/Bash-v5.1.16-232c34.svg)

## Requirements

You need a valid user on the remote system with passwordless access via SSH key.

## Configuration

Edit the `omen.host` file to add the remote servers you want to manage. After the installation this file can be located in the `~/bin` directory.

## Installation

From a Linux terminal type the following commands:
```bash
cd
git clone https://github.com/incognia/OmenShell
cd OmenShell
./install.sh
```
### Dependencies

The option `-s` requires the Speedtest CLI by Ookla to test the internet bandwith. You need to execute the following commands to install it:

```bash
sudo apt-get install curl
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest
speedtest --accept-license
```

## Usage
```
omen [-option]
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

CC 2023 | Rodrigo Ernesto Álvarez Aguilera | [Mail](mailto:incogniaqgmail.com) | [LinkedIn](https://www.linkedin.com/in/rodrigo-alvarez-aguilera/) | [Blog](https://incognia.wordpress.com/about)