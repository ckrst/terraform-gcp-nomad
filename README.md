# terraform-gcp-nomad


Build Image

```
dev.hcl

project_id=""
zone="us-central1-a"
builder_sa=""

```
```
packer build -var-file="dev.hcl" nomad.pkr.hcl


