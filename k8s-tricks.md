# Kubernetes tricks

### Debug k8s
```bash
kubectl run -it debug --image=nicolaka/netshoot
```
```bash
kubectl run --rm -it debug --image=nicolaka/netshoot
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
