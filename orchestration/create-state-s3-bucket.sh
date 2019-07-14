#!/usr/bin/env bash

#ToDo Parameterise input to create-state-s3-bucket.sh better than sroucing another file.
source env.sh

if ! aws s3api head-bucket --bucket "$S3_BUCKET" 2>/dev/null ; then
  echo "Bucket ${S3_BUCKET} is not exited"
  echo "creating bucket ..."
  aws s3api create-bucket --bucket "${S3_BUCKET}" --region ${AWS_REGION} --create-bucket-configuration LocationConstraint=${AWS_REGION}
  aws s3api put-bucket-versioning --bucket "${S3_BUCKET}" --versioning-configuration Status=Enabled
  aws s3api wait bucket-exists --bucket "${S3_BUCKET}"
  echo "Bucket ${S3_BUCKET} is created"
fi


