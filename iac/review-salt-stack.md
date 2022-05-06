# Salt stack is a very powerful automation framework
- ## Salt is designed to allow users to explicitly target and issue commands to multiple machines directly
- ## Salt is based around the idea of a Master, which controls one or more Minions 

## It's capability consists of:
- ### Using remote execution
- ### Using SLS file to provisioning software
- ### Using states for configuration management
- ### Using grains, pillars, and template

## Use case to specify targets
- ### With subnet `salt -S 192.168.0.0/24 test.ping`
- ### With wildcards `salt '*' test.ping`
- ### Using perl regular expression `salt -E '^[m|M]in.[e|o|u]n$' test.ping` or `salt --pcre '^[m|M]in.[e|o|u]n$' test.ping`
- ### With servers list `salt -L web1,web2,db1,proxy1 test.ping`
- ### With grain get information from the OS to CPU architecture to custom information
  - `salt -G 'os:Ubuntu' test.ping`
  - `salt -G 'os_family:Debian' test.ping`
  - `salt -G 'ip_interfaces:eth0:192.168.11.38'`
  - `salt -G 'ipv6:::1' test.ping`
- ### With grain PCRE `salt --grain-pcre 'os:red(hat|flag)' test.ping`
- ### With pillar `salt -I 'my_var:my_val' test.ping`
- ### With combound targets allow users to specify multiple targets types in single command
  - ![image](https://user-images.githubusercontent.com/21302811/123361329-0f663080-d599-11eb-8bc0-ac8ab183f791.png)
  - `salt -C 'G@os:Ubuntu and I@role:web and S@192.168.100.0/24' test.ping`
  - `salt -C 'min* or *ion' test.ping`
  - `salt -C 'web* or *qa,G@os:Arch' test.ping`
- ### Nodegroup are used internally in Salt. Node groups must be defined as a list of targets (using compound syntax) in the Salt Master's configuration before you use command line
```text
nodegroups:
  webdev: 'I@role:web,G@cluster:dev'
  webqa: 'I@role:web,G@cluster:qa'
  webprod: 'I@role:web,G@cluster:prod'
```
  - Execute with `salt -N webdev test.ping`

#  SLS file trees
- ### `/srv/salt/` is used for Salt states
- ### `/srv/pillar/` use a different format but the same directory structure

## For example `/srv/salt/top.sls`
```text
base:
  '*':
    - common
    - vim
  qa:
    '*_qa':
      - jenkins
  web:
    'web_*':
      - apache2
```
- ### Explain: There are 3 envs: `base`, `qa`, `web`
  - Base env will execute `common`, `vim` states accross all minion
  - QA env will execute `jenkins` states across all minion whose ID ends with `_qa`
  - Web env will execution `apache2` states across all minion whose ID starts with `web_`

## Organizing the SLS dirrectories
- ### Way 1: `apache2.sls`
- ### Way 2: `apache2/init.sls`
