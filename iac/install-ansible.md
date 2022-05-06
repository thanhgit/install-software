# Ansible
- ### It automates software provisioning, configuration management, and application deployment
- ### It communicates over normal SSH channels in order to retrieve information from remote machines, issue commands, and copy files
- ### Ansible keeps track of all of the servers that it knows about through a `/etc/ansible/hosts` file

## `Configuration management`
- ### It allows you to track items in your infrastructure and keep a track of what they do
### Benefits
- ### `Saving Time`: reduce the time required to manage updates, changes, and repetitive tasks across multiple environments and networks
- ### `Improving Availability` resolve issues faster as it will allow you identity, troubleshoot and implement solutions to problems which could arise
- ### `Lowering Your Risk` reduce downtime and lower the chance of mistakes
- ### `Improve Control` It will allow you to promote best practices across your environments and ensure consistency

## Install ansible
- ### Install centos 7
```bash
yum install -y epel-release
yum install -y ansible
```
- ### Using /usr/bin/python for backward compatibility with prior Ansible releases
```bash
sudo apt-get update -y
sudo apt-get install python3 python3-pip git libffi-dev libssl-dev -y
pip3 install ansible
ansible --version
```

- ### Configuration
    - Ref: https://docs.ansible.com/ansible/latest/installation_guide/intro_configuration.html#explanation-of-values-by-section
    - ### Ansible will first look for variables specified as environment variables and use them before any other variables.
    ```bash
    export ANSIBLE_ENVIRONMENT_VARIABLES
    ```
    - ### Usually specified in the user’s home directory
    ```bash
    cat > ~/.ansible.cfg <<EOF
    [defaults]
    deprecation_warnings=False
    EOF
    ```
    - ### the current directory where ansible is being run from
    ```bash
    cat > ansible.cfg <<EOF
    [defaults]
    deprecation_warnings=False
    EOF
    ```
    - ### The system Ansible configurations created when the application is installed
    ```bash
    cat > /etc/ansible/ansible.cfg <<EOF
    [defaults]
    deprecation_warnings=False
    EOF
    ```

## Inventory file
```bash
cat > hosts <<EOF
[mylaptop]
localhost

[webserver]
127.0.0.1
EOF
```

- ### Validate and obtain information about your Ansible inventory
```bash
ansible-inventory -i hosts --list
```
---
```json
{
    "_meta": {
        "hostvars": {}
    }, 
    "all": {
        "children": [
            "mylaptop", 
            "ungrouped", 
            "webserver"
        ]
    }, 
    "mylaptop": {
        "hosts": [
            "localhost"
        ]
    }, 
    "webserver": {
        "hosts": [
            "127.0.0.1"
        ]
    }
}
```

- ### Execute all catalog
```bash
ansible all -i hosts -m shell -a "echo Ansible hello world"
```
---
```text
localhost | CHANGED | rc=0 >>
Ansible hello world
127.0.0.1 | CHANGED | rc=0 >>
Ansible hello world
```
- ### Execution specific catalog
```bash
ansible -i hosts webserver -m shell -a "echo Ansible hello world"
```
---
```text
127.0.0.1 | CHANGED | rc=0 >>
Ansible hello world
```

## Quickly test
```bash
ssh-copy-id localhost
ansible all -i "localhost," -m shell -a 'echo Ansible is fun'
```
```text
localhost | CHANGED | rc=0 >>
Ansible is fun
```

## Configure servers in `/etc/ansible/hosts`
```bash
cat <<EOF > /etc/ansible/hosts
[ci]
host1 ansible_ssh_host=192.168.1.2
host2 ansible_ssh_host=192.168.1.4

[auth]
host3 ansible_ssh_host=192.168.1.6
EOF

mkdir -p /etc/ansible/group_vars/

cat <<EOF /etc/ansible/group_vars/ci
---
ansible_ssh_user: root
EOF

cat <<EOF > /etc/ansible/group_vars/auth
---
ansible_ssh_user: admin
EOF

cat <<EOF > /etc/ansible/group_vars/all
---
ansible_ssh_user: root
EOF
```

## Execute command
- ### Test ping
```bash
ansible -m ping all
```
---
```bash
host1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
host2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
```
- ### Other test ping
```bash
ansible -m ping ci
ansible -m ping auth
```

- ### Shell command
```bash
ansible -m shell -a 'free -m' host1:host2
```
---
```text
host2 | CHANGED | rc=0 >>
              total        used        free      shared  buff/cache   available
Mem:           5301         834        2280         289        2186        3891
Swap:          3275           0        3275
host1 | CHANGED | rc=0 >>
              total        used        free      shared  buff/cache   available
Mem:           9837        4650        1123          97        4064        4785
Swap:          2047           0        2047
```

## Running Ansible Modules
- ### `Ping`
```bash
ansible -i hosts mylaptop -m ping
```
---
```text
localhost | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
```
- ### `Setup` is useful to gather data on your system and then perform specific changes dependent on the information gathered
```bash
ansible mylaptop -i hosts -m setup
```

- ### `Git`
```bash
mkdir /tmp/markdown-cheatsheet/
ansible mylaptop -i hosts -m git -a "repo='https://github.com/vincesesto/markdown-cheatsheet.git' dest='/tmp/markdown-cheatsheet/'"
```
---
```text
localhost | CHANGED => {
    "after": "ecfb900a44a84dcd0d798ad3b0c98ea838ea5668", 
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "before": null, 
    "changed": true
}
```
- ### `Shell`
```bash
ansible mylaptop -i hosts -m shell -a "ls -l /tmp/"
```
---
```text
localhost | CHANGED | rc=0 >>
total 56
drwxrwxr-x 3 thanhuit thanhuit 4096 Thg 9  25 00:13 markdown-cheatsheet
...
```
- ### `Apt (or Yum)` with `present` & `absent`
```bash
ansible -i hosts mylaptop -m apt -a "name=apache2 state=present"
```
---
```text
myserver | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "cache_update_time": 1632534320, 
    "cache_updated": false, 
    "changed": true, 
    "stderr": "", 
    "stderr_lines": [], 
    "stdout": "Reading package lists...\nBuilding dependency tree...\r\n", 
    "stdout_lines": [
        "Reading package lists...", 
        ...
    ]
}
```
```bash
ansible -i hosts mylaptop -m apt -a "name=apache2 state=absent"
```
---
```text
myserver | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": true, 
    "stderr": "", 
    "stderr_lines": [], 
    "stdout": "Reading package lists...\nBuilding dependency tree...\r\n", 
    "stdout_lines": [
        "Reading package lists...", 
        ...
    ]
}
```

- ### `Service` can be used to perform a start, restart, or stop on services
    - ### `ansible -i hosts mylaptop -m service -a "name=apache2 state=started"`
    - ### `ansible -i hosts mylaptop -m service -a "name=apache2 state=stopped"`
    - ### `ansible -i hosts mylaptop -m service -a "name=apache2 state=restarted"`

- ### `get_url`
```bash
ansible -i hosts mylaptop -m get_url -a "url=http://localhost dest=/tmp/"
```
---
```text
myserver | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "dest": "/tmp/", 
    "elapsed": 0, 
    "gid": 0, 
    "group": "root", 
    "mode": "01777", 
    "msg": "Request failed: <urlopen error [Errno 111] Connection refused>", 
    "owner": "root", 
    "size": 548864, 
    "state": "directory", 
    "uid": 0, 
    "url": "http://localhost"
}
```

- ### `file` create a directory or file on an environment
```bash
ansible mylaptop -i hosts -m file -a "path=/tmp/another_test owner=root group=root state=directory"
```

- ### `user` control the state of the account on the system as being absent or present to determine if it is created or removed
```bash
ansible -i hosts mylaptop -m user -a "name=jsmith comment='Jane Smith' state=present"
```

- ### `find` find different files and directories that are available on the host system. It allows you to specify a path, age of the file, and the type of file and even search for files of a specific size
```bash
ansible mylaptop -i hosts -m find -a "path=/var/log/ age=1w file_type=directory"
```

## Note
- ### Using sshpass
```bash
sudo apt-get install sshpass -y
```
## Playbooks
- ### Playbooks are a way of using Ansible in a scripted form instead of running commands on the command line
- ### A playbook is a set of steps or tasks that need to be taken for a system to get to a certain end state
### For example
```bash
cat > test.yml <<EOF
---
- name: Test playbooks
  hosts: localhost

  tasks:
  - name: Run our original Ansible command
    debug: msg="Ansible is fun"
  - name: We also need to test connectivity
    ping:
EOF
```
```yaml
---
- hosts: localhost
  tasks:
    - name: Run our original Ansible command
      debug: msg="Ansible is fun"
    - name: We also need to test connectivity
      ping:
```
- ### Run
```bash
ansible-playbook test.yml -i "localhost,"
```
```text
PLAY [Test playbooks] ************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************
ok: [localhost]

TASK [Run our original Ansible command] ******************************************************************************************************
ok: [localhost] => {
    "msg": "Ansible is fun"
}

TASK [We also need to test connectivity] *****************************************************************************************************
ok: [localhost]

PLAY RECAP ***********************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```

### Each playbook includes a set of plays, which map a group of hosts to a specific role
- ### YAML File Names End with .yml
- ### Syntax Starts with Three Dashes `---`
- ### Whitespace Denotes Structure. `Note`: Make sure you never use a tab character as indentation
- ### A Comment Uses the Hash Symbol `#`
- ### List Members Use a Leading Hyphen `-`
- ### Dictionaries Are Represented As a `"Key: Value"`
```yaml
---
vince:
  full_name: Seward Nguyen
  job: devops engineer
  comment: Ansible is Fun!
```
- ### Span Multiple Lines with a Pipe `|`
```yaml
env: |-
  DB_HOST= "database.host.com"
  DB_DATABASE= "testdb"
  DB_USERNAME= "dbadmin"
  SUDO= "root"
```
- ### Using `>` symbol will ignore any new lines
```yaml
motd: >
  Welcome to your new system
  where everything from this
  message should be on the
  same line
```

- ### For example
    - ### A host will be mapped to a web server role
    - ### The roles are represented by a list of tasks
    - ### These specific tasks act like a recipe, using our Ansible modules to then our system to a specific state.

- ### If `apache2` is installed
```text
host1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "cache_update_time": 1631990716, 
    "cache_updated": false, 
    "changed": false
}
```

- ### Ensure apache is installed and up to date
```yaml
tasks:
  - name: Ensure apache is installed and up to date
    apt: name=apache2 state=latest
```

- ### View log
```bash
ansible-playbook -i hosts webserver-playbook.yml -vvv
```