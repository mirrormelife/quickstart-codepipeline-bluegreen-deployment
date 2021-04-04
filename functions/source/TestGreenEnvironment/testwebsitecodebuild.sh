#!/bin/sh -e

echo $GreenEnvName
cname=$(aws elasticbeanstalk describe-environments --environment-names ${GreenEnvName} --region $AWS_REGION --query Environments[0].CNAME --output text)
echo $cname
if [ $cname ]
  then
      echo $( curl -LIk https://$cname )
      status=$( curl -LIk https://$cname -o /dev/null -w '%{http_code}\n' -s )
  echo $status
  echo $GreenEnvName
  if [ ${status} = "200" ]
      then exit 0
  else
    exit 1
  fi
else
    exit 1
fi
