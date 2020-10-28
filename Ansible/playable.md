Basado en https://hub.docker.com/r/mmumshad/ansible-playable/

Playable is an Ansible Playbook generator UI developed in MEAN stack using Yeoman angular-fullstack-generator and built using Docker. The tool may be used by an individual or a team to

Generate Ansible Playbooks
Easily Search and import roles from Galaxy or Github
Execute and Test Playbooks (Not available in the publicly hosted version)
Develop custom modules and test them
All the above while enforcing Ansible Best Practices


- <b>docker run -p 80:8080 mmumshad/ansible-playable</b>
- <b>docker run -p 80:8080 -v /data/db:/data/db -v /opt/ansible-projects:/opt/ansible-projects mmumshad/ansible-playable</b>
