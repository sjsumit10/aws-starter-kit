# EKS Setup

## Install requirements

`pip install -r requirements.txt`

`brew install awscli`

`brew install eksctl`

## Prepare .env file

Create env-name.env file and fill values of all variables

Sample file generate.env is present in  root of repo

## Create/update cluster -->

`bash setup.sh env_name create cluster`

`bash setup.sh env_name update cluster`


## Create/update nodegroups -->

`bash setup.sh env_name create nodegroup`

`bash setup.sh env_name update nodegroup`