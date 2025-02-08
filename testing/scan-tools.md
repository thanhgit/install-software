# Scan tools

#### `Nova`
- #### Install
```bash
curl -L "https://github.com/FairwindsOps/nova/releases/download/3.11.2/nova_3.11.2_linux_amd64.tar.gz" > nova.tar.gz
tar -xvf nova.tar.gz
sudo mv nova /usr/local/bin/
````
- #### Find helm
```bash
nova find --helm --format table
```
```text
Release Name                   Chart Name                     Namespace            HelmVersion    Installed    Latest                      Old      Deprecated
============                   ==========                     =========            ===========    =========    ======                      ===      ==========
crossplane                     crossplane                     crossplane-system    3              1.18.2       1.20.0-rc.0.6.gd1587b448    true     false    
kyverno-policies               kyverno-policies               kyverno              3              3.3.3        3.3.3                       false    false    
kyverno                        kyverno                        kyverno              3              3.3.5        3.3.5                       false    false    
policy-reporter                policy-reporter                policy-reporter      3              3.0.0        3.0.0                       false    false    
trivy-operator-polr-adapter    trivy-operator-polr-adapter    trivy-adapter        3              0.10.0       0.10.0                      false    false    
trivy-operator                 trivy-operator                 trivy-system         3              0.25.0       0.26.0                      true     false    
```
