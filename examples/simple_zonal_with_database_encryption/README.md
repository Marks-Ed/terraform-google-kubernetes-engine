# Simple Zonal Cluster

This example illustrates how to create a simple cluster in a single zone with database encryption.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_name\_suffix | A suffix to append to the default cluster name | string | `""` | no |
| compute\_engine\_service\_account | Service account to associate to the nodes in the cluster | string | n/a | yes |
| create\_database\_encryption\_key | Defines if a Cloud KMS Key should be created to encrypt secrets. | string | n/a | yes |
| database\_encryption | Enable Application-layer Secrets Encryption. If key_name is empty, kms key will be created. Format is the same as described in provider documentation: https://www.terraform.io/docs/providers/google/r/container_cluster.html#database_encryption | string | n/a | yes |
| ip\_range\_pods | The secondary ip range to use for pods | string | n/a | yes |
| ip\_range\_services | The secondary ip range to use for services | string | n/a | yes |
| network | The VPC network to host the cluster in | string | n/a | yes |
| project\_id | The project ID to host the cluster in | string | n/a | yes |
| region | The region to host the cluster in | string | n/a | yes |
| subnetwork | The subnetwork to host the cluster in | string | n/a | yes |
| zones | The zone to host the cluster in (required if is a zonal cluster) | list(string) | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ca\_certificate |  |
| client\_token |  |
| cluster\_name | Cluster name |
| database\_encryption\_key | The self_link of the kms crypto key used to encrypt secrets |
| ip\_range\_pods | The secondary IP range used for pods |
| ip\_range\_services | The secondary IP range used for services |
| kubernetes\_endpoint |  |
| location |  |
| master\_kubernetes\_version | The master Kubernetes version |
| network |  |
| project\_id |  |
| region |  |
| service\_account | The default service account used for running nodes. |
| subnetwork |  |
| zones | List of zones in which the cluster resides |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
