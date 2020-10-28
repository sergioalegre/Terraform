Basado https://miquelmariano.github.io/2020/01/15/instalacion-ansible-awx-docker-centos7/

- sudo apt-add-repository ppa:ansible/ansible
- apt-get update
- sudo apt-get install ansible -y
- ansible --version
- cd /tmp
- LATEST_AWX=$(curl -s https://api.github.com/repos/ansible/awx/tags |egrep name |head -1 |awk '{print $2}' |tr -d '"|,')
- curl -L -o ansible-awx-$LATEST_AWX.tar.gz https://github.com/ansible/awx/archive/$LATEST_AWX.tar.gz
- tar xvfz ansible-awx-$LATEST_AWX.tar.gz
- rm -f ansible-awx-$LATEST_AWX.tar.gz
- cd awx-$LATEST_AWX/installer
- apt install python-pip
- pip install docker-compose
- apt install python-docker
- apt install python3-pip
- pip3 install docker
- pip3 install docker-compose
- ansible-playbook -i inventory install.yml
- docker ps


<br><br>
Las credenciales por defecto son: admin-password
