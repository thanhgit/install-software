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
