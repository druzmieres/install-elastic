#!/bin/bash
### Install Java 8 and agree to the license
cd ~
# Requirements
sudo apt -y install aptitude
sudo apt -y install curl
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt update
sudo apt -y install aptitude
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo aptitude -y install oracle-java8-installer

### Download and install Elasticsearch
### Check http://www.elasticsearch.org/download/ for latest version of Elasticsearch and replace wget link
#Only download the file if it doesn't already exist
if [ ! -f elasticsearch-6.0.0.deb ]; then
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.0.0.deb
fi

#Dpkg deb
sudo dpkg -i elasticsearch-6.0.0.deb

# Enable Elastic to start automatically (on bootup)
sudo update-rc.d elasticsearch defaults 95 10

# set JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

_repeat="Y"

while [ $_repeat = "Y" ]
do
	echo -n "Enter path to data directory (leave blank for default): " #(separate multiple locations by comma)
read DPATH
if [ -z "$DPATH" ]; then
    sudo sed -i 's#^path.data: .*$#path.data: /var/lib/elasticsearch#' /etc/elasticsearch/elasticsearch.yml
    echo "Set to the default path"
    _repeat="N"
elif [ ! -e "$DPATH" ]; then
    echo "Path not valid"
    #ask for path again
else
    #(missing) check permissions
    sudo sed -i 's#^path.data: .*$#path.data: '"$DPATH"'#' /etc/elasticsearch/elasticsearch.yml 
    _repeat="N"
fi
done

### Start Elasticsearch
sudo /etc/init.d/elasticsearch start

### Make sure service is running
curl http://localhost:9200

### Should return something like this:
# {
#  "status" : 200,
#  "name" : "Storm",
#  "version" : {
#    "number" : "1.3.1",
#    "build_hash" : "2de6dc5268c32fb49b205233c138d93aaf772015",
#    "build_timestamp" : "2014-07-28T14:45:15Z",
#    "build_snapshot" : false,
#    "lucene_version" : "4.9"
#  },
#  "tagline" : "You Know, for Search"
#}

#Check how to tune memory http://stackoverflow.com/a/18152957/56069
