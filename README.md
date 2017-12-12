# install-elastic
This is a script to install and run Elasticsearch on Ubuntu 16.04.3 LTS

To run it, execute:<br>
```
$ chmod +x install-elastic requirements
$ ./install-elastic
```
The script will ask for the (absolute) data path, IP, port and amount of RAM to use.<br>

The script also installs Cerebro (http://github.com/lmenezes/cerebro) and runs it. Cerebro is only run as a script and not as a service (I plan to fix this soon).
