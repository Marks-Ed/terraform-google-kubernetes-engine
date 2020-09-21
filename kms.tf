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
  database_encryption_key_name     = "tf-gke-${substr(var.name, 0, min(15, length(var.name)))}-${random_string.database_kms_suffix.result}"
  database_encryption_key_location = local.region
  database_encryption_key_resource = var.create_database_encryption_key ? google_kms_crypto_key.database_encryption_key[0].self_link : ""
  database_encryption_key          = var.create_database_encryption_key ? google_kms_crypto_key.database_encryption_key[0].self_link : var.database_encryption.key_name
}

resource "random_string" "database_kms_suffix" {
  upper   = false
  lower   = true
  special = false
  length  = 4
}

resource "google_kms_key_ring" "keyring" {
  count    = var.create_database_encryption_key ? 1 : 0
  name     = local.database_encryption_key_name
  location = local.database_encryption_key_location
}

resource "google_kms_crypto_key" "database_encryption_key" {
  count           = var.create_database_encryption_key ? 1 : 0
  name            = local.database_encryption_key_name
  key_ring        = google_kms_key_ring.keyring[0].id
  rotation_period = var.database_encryption_key_rotation_period

  labels = var.kms_labels

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key_iam_member" "database_encryption_key_encrypter_decrypter" {
  count         = var.create_database_encryption_key ? 1 : 0
  crypto_key_id = google_kms_crypto_key.database_encryption_key[0].id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.project.number}@container-engine-robot.iam.gserviceaccount.com"
}
