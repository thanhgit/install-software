# Private Certificate Authority

## How to install commandline
- ### Install wget
```bash
sudo yum install wget -y
```
- ### Install `step`
```bash
wget -O step.tar.gz https://dl.step.sm/gh-release/cli/docs-ca-install/v0.17.5/step_linux_0.17.5_amd64.tar.gz --no-check-certificate
tar -xf step.tar.gz
sudo mv step_0.17.5/bin/step /usr/bin
```
```bash
rm -rf step_0.17.5/
rm -f step.tar.gz
```
- ### Install `step-ca`
```bash
wget -O step-ca.tar.gz https://dl.step.sm/gh-release/certificates/docs-ca-install/v0.17.4/step-ca_linux_0.17.4_amd64.tar.gz
tar -xf step-ca.tar.gz
sudo cp step-ca_0.17.4/bin/step-ca /usr/bin
```
```bash
rm -f step-ca.tar.gz
rm -rf step-ca_0.17.4/
```

- ### Install cogsign
```bash
wget https://github.com/sigstore/cosign/releases/download/v1.3.0/cosign-linux-amd64
chmod 700 cosign-linux-amd64
mv cosign-linux-amd64 cosign
sudo mv cosign /usr/bin/
```

## Step by step
- ### Pull image
```bash
docker pull smallstep/step-ca
```
- ### Create a volume will hold your CA configuration, keys, and database
    - ### Generate password protected private keys for your CA to sign certificates
    - ### Generate a root and intermediate signing certificate for your CA
    - ### Create a JSON configuration file for step-ca
```bash
docker run -it -v step:/home/step smallstep/step-ca step ca init
```
```text
there is no ca.json config file; please run step ca init, or provide config parameters via DOCKER_STEPCA_INIT_ vars
✔ Deployment Type: Standalone
What would you like to name your new PKI?
✔ (e.g. Smallstep): LocalCA
What DNS names or IP addresses would you like to add to your new CA?
✔ (e.g. ca.smallstep.com[,1.1.1.1,etc.]): ca.teqhackathon.xyz
What IP and port will your new CA bind to?
✔ (e.g. :443 or 127.0.0.1:443): :9000
What would you like to name the CA's first provisioner?
✔ (e.g. you@smallstep.com): admin
Choose a password for your CA keys and first provisioner.
✔ [leave empty and we'll generate one]:

Generating root certificate... done!
Generating intermediate certificate... done!

✔ Root certificate: /home/step/certs/root_ca.crt
✔ Root private key: /home/step/secrets/root_ca_key
✔ Root fingerprint: 9e39d6cdfa9eda0ffaff124c3dc27fe50432607e9a166c196b0e1508da048bac
✔ Intermediate certificate: /home/step/certs/intermediate_ca.crt
✔ Intermediate private key: /home/step/secrets/intermediate_ca_key
✔ Database folder: /home/step/db
✔ Default configuration: /home/step/config/defaults.json
✔ Certificate Authority configuration: /home/step/config/ca.json
```
- ### Decrypt the CA's private signing key
```bash
step-ca $(step path)/config/ca.json
```

- ### Save password in docker
```bash
docker run -it -v step:/home/step smallstep/step-ca sh
```
```bash
echo <your password here> > /home/step/secrets/password
```

## Setting Up a Development Environment
- ### Get CA_FINGERPRINT
```bash
export CA_FINGERPRINT=$(docker run --rm -v step:/home/step smallstep/step-ca step certificate fingerprint /home/step/certs/root_ca.crt)
```
OR
```bash
step certificate fingerprint $(step path)/certs/root_ca.crt
```
- ### To configure step to access your CA from a new machine
```bash
step ca bootstrap --ca-url https://ca.teqhackathon.xyz:9000 --fingerprint "${CA_FINGERPRINT}" --install
```
- ### Establish system-wide trust of your CA
```bash
step certificate install $(step path)/certs/root_ca.crt
```

- ### How to create certificate for domain
```bash
step ca certificate util4dev.local srv.crt srv.key
```

- ### How to get root certificate
```bash
step ca root root.crt
```

- ### How to use `curl` with certiciate
```bash
curl --cacert root.crt https://util4dev.local/hi
```

- ### How to inspect certificates
```bash
step certificate inspect --bundle srv.crt
```

- ### How to set certpath in curl
```bash
vi ~/.curlrc
```
```text
capath=/etc/ssl/certs/
cacert=/etc/ssl/certs/ca-certificates.crt
```

### Change expire time
- ### Change configuration in `/home/step/config/ca.json` at authority.claims.defaultTLSCertDuration
```json
{
	"root": "/home/step/certs/root_ca.crt",
	"federatedRoots": null,
	"crt": "/home/step/certs/intermediate_ca.crt",
	"key": "/home/step/secrets/intermediate_ca_key",
	"address": ":9000",
	"insecureAddress": "",
	"dnsNames": [
		"ca.teqhackathon.xyz"
	],
	"logger": {
		"format": "text"
	},
	"db": {
		"type": "badgerv2",
		"dataSource": "/home/step/db",
		"badgerFileLoadingMode": ""
	},
	"authority": {
		"claims": {
      			"minTLSCertDuration": "5m",
      			"maxTLSCertDuration": "1680h",
      			"defaultTLSCertDuration": "1680h",
      			"disableRenewal": false,
      			"minHostSSHCertDuration": "5m",
      			"maxHostSSHCertDuration": "1680h",
      			"defaultHostSSHCertDuration": "720h",
      			"minUserSSHCertDuration": "5m",
      			"maxUserSSHCertDuration": "24h",
      			"defaultUserSSHCertDuration": "16h"
    		},
		"provisioners": [
			{
				"type": "JWK",
				"name": "admin",
				"key": {
					"use": "sig",
					"kty": "EC",
					"kid": "31QWbSyDFGPki0ZbSlcCumRLpwRrRBhleg6aWYQsdYg",
					"crv": "P-256",
					"alg": "ES256",
					"x": "kvKyMbXF9mzIMrcRrVpnjSgSqMbtRgbYEhVwMF35OMY",
					"y": "CmGo9hs2Zoc4AVDC554IY3Z59SIxFL9FMQMMdUSbYqo"
				},
				"encryptedKey": "xxx"
			}
		]
	},
	"tls": {
		"cipherSuites": [
			"TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256",
			"TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256"
		],
		"minVersion": 1.2,
		"maxVersion": 1.3,
		"renegotiation": false
	}
}
```
- ### Apply configuration
```bash
docker stop ca-container-name
docker start ca-container-name
```

## Ref
- https://hub.docker.com/r/smallstep/step-ca
- https://reposhub.com/go/security/smallstep-certificates.html
- https://smallstep.com/blog/private-acme-server/
- https://smallstep.com/docs/step-ca/getting-started
- https://github.com/smallstep/certificates/blob/master/docs/docker.md
- https://newbedev.com/default-ca-cert-bundle-location
