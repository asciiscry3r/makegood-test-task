# makegood-test-task

TTGL ^_^

# requirements

terraform

aws ec2 and awscli

godaddy dns and time for shift name servers

# install

Create IAM terraform user with access to ec2 and some iam function,
Create instance role with ability to create dns record.
Set your variables in terraform/main.tf and:

```
terraform apply
```

CC-BY-NC-ND-4.0

