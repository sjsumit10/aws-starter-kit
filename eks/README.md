# EKS Setup

## Install requirements

`pip install -r requirements.txt`

`brew install awscli`

`brew install eksctl`

## Prepare .env file

Create env-name.env file and fill values of all variables

Sample file generate.env is present in  root of repo

## Create cluster -->

`bash setup.sh env_name cluster`

## Create nodegroups -->

`bash setup.sh env_name nodegroup`