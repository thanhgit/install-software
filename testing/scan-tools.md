# Scan tools

#### `Polaris scoring`
- #### Install
```bash
helm repo add fairwinds-stable https://charts.fairwinds.com/stable
helm upgrade --install polaris fairwinds-stable/polaris --namespace polaris --create-namespace
```
- #### Port-fowarding
```bash
kubectl port-forward --namespace polaris svc/polaris-dashboard 8080:80
```

#### `rbac-lookup`
- #### Install
```bash
wget https://github.com/FairwindsOps/rbac-lookup/releases/download/v0.10.2/rbac-lookup_0.10.2_Linux_x86_64.tar.gz
tar -xvf rbac-lookup_0.10.2_Linux_x86_64.tar.gz
sudo mv rbac-lookup /usr/local/bin/
```
- #### View all roles
```bash
rbac-lookup
```
- #### View all user, group, serviceaccount
```bash
rbac-lookup --kind user --output wide
```
```bash
rbac-lookup --kind group --output wide
```
```bash
rbac-lookup --kind serviceaccount --output wide
```
- #### View a specific role
```bash
rbac-lookup crossplane
```

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
- #### Find containers
```bash
nova find --containers --format table
```
```text
Container Name                                  Current Version    Old     Latest      Latest Minor     Latest Patch
==============                                  ===============    ===     ======      =============    =============
registry.k8s.io/coredns/coredns                 v1.11.1            true    v1.12.0     v1.12.0          v1.11.4     
registry.k8s.io/etcd                            3.5.15-0           true    3.5.17-0    3.5.15-0         3.5.15-0    
mirror.gcr.io/aquasec/trivy-operator            0.23.0             true    0.24.0      0.23.0           0.23.1      
xpkg.upbound.io/upbound/provider-kubernetes     v0.16.0            true    v0.16.2     v0.16.0          v0.16.2     
registry.k8s.io/kube-scheduler                  v1.31.0            true    v1.32.1     v1.32.1          v1.31.5     
registry.k8s.io/kube-controller-manager         v1.31.0            true    v1.32.1     v1.32.1          v1.31.5     
registry.k8s.io/kube-proxy                      v1.31.0            true    v1.32.1     v1.32.1          v1.31.5     
registry.k8s.io/kube-apiserver                  v1.31.0            true    v1.32.1     v1.32.1          v1.31.5     
ghcr.io/kyverno/policy-reporter/trivy-plugin    0.3.1              true    0.4.1       0.3.1            0.3.1       
ghcr.io/aquasecurity/trivy                      0.58.2             true    0.59.1      0.58.2           0.58.2      
```
