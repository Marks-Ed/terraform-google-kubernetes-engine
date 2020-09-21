/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_ids" {
  type        = list(string)
  description = "The GCP projects to use for integration tests"
}

variable "region" {
  description = "The GCP region to create and test resources in"
  default     = "us-central1"
}

variable "zones" {
  type        = list(string)
  description = "The GCP zones to create and test resources in, for applicable tests"
  default     = ["us-central1-a", "us-central1-b", "us-central1-c"]
}

variable "compute_engine_service_accounts" {
  type        = list(string)
  description = "The email addresses of the service account to associate with the GKE cluster"
}

variable "registry_project_id" {
  description = "Project to use for granting access to the GCR registry, if requested"
}

variable "database_encryption" {
  description = "Enable Application-layer Secrets Encryption. If key_name is empty, kms key will be created. Format is the same as described in provider documentation: https://www.terraform.io/docs/providers/google/r/container_cluster.html#database_encryption"
}

variable "create_database_encryption_key" {
  description = "Defines if a Cloud KMS Key should be created to encrypt secrets."
}
