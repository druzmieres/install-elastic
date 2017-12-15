# install-elastic
These are scripts to install and run Elasticsearch and Cerebro 0.7.2 (github.com/lmenezes/cerebro) on Ubuntu 16.04.3 LTS as services. The scripts allow these applications to automatically run on bootup.

To run them, execute:<br>
```
$ chmod +x requirements install-elastic install-cerebro
$ ./requirements
$ ./install-elastic
$ ./install-cerebro
```
The Elasticsearch script will ask for the (absolute) data path, IP, port and amount of RAM to use.<br>
The Cerebro script asks for IP and port.
