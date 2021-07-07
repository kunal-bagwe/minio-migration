!# /bin/bash
date=`date -R`
s3_key='AKIAIOSFODNN7EXAMPLE'
s3_secret='wJalrXUtnFEMIK7MDENGbPxRfiCYEXAMPLEKEY'
#content_type="application/octet-stream"
#resource="/${bucket}/${file}"
#_signature="PUT\n\n${content_type}\n${date}\n${resource}"
#signature=`echo -en ${_signature} | openssl sha1 -hmac ${s3_secret} -binary | base64`

# curl -v -X PUT -T demo.txt -H "Host: 10.93.1.146:9000" -H "Date: ${date}" -H "Content-Type: ${content_type}" -H "Authorization:AWS ${s3_key}:${signature}" http://10.93.1.146:9000$resource



host=$1
# access_key=$2
# secret_key=$3
bucket_name=$2

res=./mc --version
echo $res
if [[ $res -eq 0 ]]
then
  echo "mc client cli is installed"
else
  wget https://dl.min.io/client/mc/release/linux-amd64/mc > /dev/null
  chmod +x mc
fi
echo "Configuring alias for minio cluster"
./mc alias set myminio http://${host} AKIAIOSFODNN7EXAMPLE wJalrXUtnFEMIK7MDENGbPxRfiCYEXAMPLEKEY
echo "Copying the objects to bucket"
#if [[ -d "demo" ]]
#then
#  ./mc cp --recursive demo/ myminio/${bucket_name}/demo/
#else
#  ./mc cp --recursive demo myminio/${bucket_name}/
#fi

dir=$(find . -type d -name "*")
for d in $dir
do
  dir_name=$(echo $d | sed "s/^./${PWD##*/}/g")
  echo $dir_name
  file_name=$(find $d -type f -name "*")
#  for f in $file_name
#  do
#  echo ${f:2}
#  done
done
