# Kubernetes tricks

### Debug k8s
```bash
kubectl run -it debug --image=nicolaka/netshoot
```
```bash
kubectl run --rm -it debug --image=nicolaka/netshoot
```

### Set up Corefile
```bash
kubectl edit cm coredns
```
```yaml
data:
  Corefile: |
    .:53 {
        errors
        health {
            lameduck 5s
        }
        ready
        kubernetes cluster.local in-addr.arpa ip6.arpa {
          pods insecure
          fallthrough in-addr.arpa ip6.arpa
          ttl 30
        }
        prometheus :9153
        forward . /etc/resolv.conf {
          prefer_udp
        }
        cache 5

        loop
        reload
        loadbalance
    }
kind: ConfigMap
```

## Create config file
```bash
server=https://192.168.1.64:6443
name=create-ns-token-psnrb
```
```bash
ca=$(kubectl get secret/$name -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret/$name -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret/$name -o jsonpath='{.data.namespace}' | base64 --decode)

echo "
apiVersion: v1
kind: Config
clusters:
- name: default-cluster
  cluster:
    certificate-authority-data: ${ca}
    server: ${server}
contexts:
- name: default-context
  context:
    cluster: default-cluster
    namespace: default
    user: default-user
current-context: default-context
users:
- name: default-user
  user:
    token: ${token}
" > sa.kubeconfig
```
- ### Swith config
```bash
export KUBECONFIG=$PWD/sa.kubeconfig
```
- ### Clean
```bash
unset KUBECONFIG
```
