provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "cv_bucket" {
  name     = var.bucket_name
  location = var.region

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

}

data "google_iam_policy" "cv_viewer" {
  binding {
    role = "roles/storage.objectViewer"
    members = [
      "allUsers",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "policy" {
  bucket      = google_storage_bucket.cv_bucket.id
  policy_data = data.google_iam_policy.cv_viewer.policy_data
}

resource "google_storage_bucket_object" "index" {
  name   = "index.html"
  source = "cv/index.html"
  bucket = google_storage_bucket.cv_bucket.id
}

resource "google_storage_bucket_object" "not_found" {
  name   = "404.html"
  source = "cv/404.html"
  bucket = google_storage_bucket.cv_bucket.id
}
