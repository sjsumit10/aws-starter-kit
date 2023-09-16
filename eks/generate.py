import os
import sys
import yaml
from jinja2 import Environment, StrictUndefined


def render_template(content, variables):
    output = Environment(undefined=StrictUndefined).from_string(content).render(**variables)
    return output


def populateEnvVariables():
    with open('eks-cluster-base.yaml') as f:
        content = f.read()

    output = render_template(content, os.environ.copy())
    return output


if __name__== "__main__":
    final_yaml = yaml.safe_load(populateEnvVariables())
    output = yaml.dump(final_yaml, sort_keys=False)
    # Save to path
    path = '{0}/eks-cluster.yml'.format(os.environ['CLUSTER_ENV'])
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w') as nf:
        nf.write(output)
    print(output)
