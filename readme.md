## Packer

A quick spike of using Packer to build an image which runs a docker Docker on boot.

## Commands

After copying and modifying the example env file:
```
cp .env.json.example .env.json
vim .env.json
```

Validation:

```
packer validate packer/template.json
```

Building with variables:

```
packer build -var-file=.env.json packer/template.json
```

## Resources

- https://learn.hashicorp.com/tutorials/packer/getting-started-build-image
