#!/bin/bash

# echo "source populate-kubeconfig.sh"
# source populate-kubeconfig.sh

# echo "Getting contexts list"
# contexts=$(kubectl config get-contexts --no-headers -o name)

# emc charts for deletion
charts=("emc-aggregation", "emc-alarms", "emc-appmaster", "emc-correlation", "emc-edr-processing", "emc-input-adapter", "emc-output", "emc-config-node")

# for context in $contexts
# do
#  echo ""
#  echo "current context: $context"

  echo "Configuring alias for minio cluster"
  mc alias set minio ${MINIO_SERVICE} ${MINIO_ACCESS_KEY} ${MINIO_SECRET_KEY}
  if [ $? -ne 0 ]
  then
    echo "Unable to configure minio server, please check logs."
    exit 1
  fi
  echo "Creating ${MINIO_BUCKET_NAME} bucket"
  echo "Executing command mc mb minio/${MINIO_BUCKET_NAME}"
  mc mb minio/${MINIO_BUCKET_NAME} > /dev/null 2>&1
  if [ $? -ne 0 ]
  then
    echo "${MINIO_BUCKET_NAME} bucket already exists"
  else
    echo "${MINIO_BUCKET_NAME} bucket is created"
  fi

  echo "Executing command mc mirror --overwrite /tmp/  minio/${MINIO_BUCKET_NAME}"
  echo "Copying data to ${MINIO_BUCKET_NAME} bucket"
  mc mirror --overwrite /tmp/  minio/${MINIO_BUCKET_NAME}
  echo "Copy operation completed, list ${MINIO_BUCKET_NAME} bucket for data"
# for i in “${charts[@]}”
# do
#   echo "searching for ${i} chart in $context context..."
#   HELM_KUBECONTEXT=$context helm status ${i} -n empirix-cloud &>/dev/null
#   if [ $HELM_KUBECONTEXT -eq 0 ]; then
#     echo "deleting ${i} chart from $context context"
#     $context helm uninstall ${i} -n empirix-cloud
#   else
#     continue
#   fi
# done
# done
echo "Finished execution"
