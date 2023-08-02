project              = "eng-handbook-359108"
region               = "europe-central2"
availability_zones   = ["europe-central2-a", "europe-central2-b"]
private_subnet_cidr  = "10.0.1.0/24"
public_subnet_cidr   = "10.0.2.0/24"
frontend_image       = "europe-central2-docker.pkg.dev/eng-handbook-359108/test-website/frontend:v1"
backend_image        = "europe-central2-docker.pkg.dev/eng-handbook-359108/test-website/backend:v1"
cos_image            = "projects/cos-cloud/global/images/cos-stable-105-17412-156-4"