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

// This file was automatically generated from a template in ./autogen/main

locals {
  service_account_list = compact(
    concat(
      google_service_account.cluster_service_account.*.email,
      ["dummy"],
    ),
  )
  database_encryption_key_name = lookup(var.database_encryption, "key_name", "tf-gke-${substr(var.name, 0, min(15, length(var.name)))}-${random_string.database_kms_suffix.result}")
  database_encryption_key_location = var.region == null ? join("-", slice(split("-", var.zone), 0, 2)) : var.region
}

resource "random_string" "database_kms_suffix" {
  upper   = false
  lower   = true
  special = false
  length  = 4
}

resource "google_kms_key_ring" "keyring" {
  count    = var.create_database_encryption_key
  name     = var.keyring_name
  location = var.database_encryption_key_location
}

resource "google_kms_crypto_key" "database_encryption_key" {
  count           = var.create_database_encryption_key
  name            = local.database_encryption_key_name
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = var.databse_encryption_key_rotation_period

  labels = local.labels

  lifecycle {
    prevent_destroy = true
  }
}