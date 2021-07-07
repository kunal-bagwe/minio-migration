#!/bin/bash
bucket='sample'
date=`date -R`
s3_key='AKIAIOSFODNN7EXAMPLE'
s3_secret='wJalrXUtnFEMIK7MDENGbPxRfiCYEXAMPLEKEY'
#content_type="application/octet-stream"
#resource="/${bucket}/${file}"
#_signature="PUT\n\n${content_type}\n${date}\n${resource}"
#signature=`echo -en ${_signature} | openssl sha1 -hmac ${s3_secret} -binary | base64`

# curl -v -X PUT -T demo.txt -H "Host: 10.93.2.5:9000" -H "Date: ${date}" -H "Content-Type: ${content_type}" -H "Authorization:AWS ${s3_key}:${signature}" http://10.93.2.5:9000$resource

echo "source populate-kubeconfig.sh"
source populate-kubeconfig.sh

echo "Getting contexts list"
contexts=$(kubectl config get-contexts --no-headers -o name)



host=10.93.2.5:9000
# access_key=$2
# secret_key=$3
bucket_name=sample

echo "Configuring alias for minio cluster"
mc alias set myminio http://${host} AKIAIOSFODNN7EXAMPLE wJalrXUtnFEMIK7MDENGbPxRfiCYEXAMPLEKEY
echo "Copying the objects to bucket"
#if [[ -d "demo" ]]
#then
#  ./mc cp --recursive demo/ myminio/${bucket_name}/demo/
#else
#  ./mc cp --recursive demo myminio/${bucket_name}/
#fi

dir=$(find . -type d -name "*")
echo $dir
for d in $dir
do
  dir_name=$(echo $d | sed "s/^./${PWD##*/}/g")
  echo $dir_name
  echo "Copying to minio bucket"
  mc cp --recursive ${d} myminio/${bucket_name}/
  file_name=$(find $d -type f -name "*")
#  for f in $file_name
#  do
#  echo ${f:2}
#  done
done
