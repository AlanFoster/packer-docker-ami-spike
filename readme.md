## Packer

A quick spike of using Packer to build an image which runs a docker Docker on boot.

## Virtualbox

### Commands

After copying and modifying the example env file:
```
cp .env.json.example .env.json
vim .env.json
```

Validation:

```
packer validate packer/template-virtualbox.json
```

Building with variables:

```
packer build packer/template-virtualbox.json
```

Once finished the created ova can be found in `output-virtualbox-iso`.

## AMI

### Commands

After copying and modifying the example env file:
```
cp .env.json.example .env.json
vim .env.json
```

Validation:

```
packer validate packer/template-ami.json
```

Building with variables:

```
packer build -var-file=.env.json packer/template-ami.json
```

Once finished the name of the AMI will be logged:

```
==> Wait completed after 7 minutes 55 seconds

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:
us-east-1: ami-0a6f11683b647ffe7
```

You can use this AMI to create a new ec2 instance and SSH in with the `ubuntu` username.

### Exporting AMI as VMDK

Following the steps from https://docs.aws.amazon.com/vm-import/latest/userguide/vmexport_image.html to create the required IAM role.

Create the AMI role:

```
aws iam create-role --role-name vmimport --assume-role-policy-document "file://$(pwd)/packer/aws/trust-policy.json"
```

Create the AMI policy:

```
aws iam put-role-policy --role-name vmimport --policy-name vmimport --policy-document "file://$(pwd)/packer/aws/role-policy.json"
```

Create a bucket:

```
aws s3api create-bucket --bucket packer-example-export-bucket --region us-east-1
```

Exporting VMDK:

```
aws ec2 export-image --image-id ami-0a6f11683b647ffe7 --disk-image-format VMDK --s3-export-location S3Bucket=packer-example-export-bucket,S3Prefix=exports/
```

Once finished the export will appear in the created exports bucket.
