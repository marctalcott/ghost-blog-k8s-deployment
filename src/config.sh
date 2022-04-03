# config.sh
#!/bin/bash


echo ""
echo "Setting variables."

NAMESPACE="default"
APP_NAME="talcottfarms"
DOMAIN="talcottfarms.com"
PRIMARY_URL="https:\/\/${DOMAIN}"
CLUSTER_ISSUER="letsencrypt-prod-cluster-issuer"

TEMPFOLDER="temp" # we use this folder to put generated files and deploy. Then we delete it.


NAMESPACE="default"
APP_NAME="mysite"
DOMAIN="mysite.com"
PRIMARY_URL="https:\/\/${DOMAIN}"
CLUSTER_ISSUER="letsencrypt-prod-cluster-issuer"

TEMPFOLDER="temp"	# we use this folder to put generated files and deploy. Then we delete it.


# ********** Edit the variables above as needed ****************






#
echo ""
echo "Checking folder so we don't accidentally overwrite."
 
if [ -d "$TEMPFOLDER" ]; then
  # Take action if $DIR exists. #
  echo ""
  echo "ABORTING because /${TEMPFOLDER} exists. Either delete the /${TEMPFOLDER} folder or change the config.sh file."
  echo ""
  exit 1
fi
 

#copy the yaml files in this folder to a temp subfolder
echo ""
echo "Creating folder."
mkdir $TEMPFOLDER

echo ""
echo "Copy files to temp folder."
cp *.yaml $TEMPFOLDER

# You also need to set values in the secrets.yaml
echo ""
echo "Replace variables in the yaml files."
find temp -name '*.yaml' -exec sed -i '.bak' "s/CONFIG_NAMESPACE/${NAMESPACE}/g" {} +
find temp -name '*.yaml' -exec sed -i '.bak' "s/CONFIG_APP_NAME/${APP_NAME}/g" {} +
find temp -name '*.yaml' -exec sed -i '.bak' "s/CONFIG_CLUSTER_ISSUER/${CLUSTER_ISSUER}/g" {} +
find temp -name '*.yaml' -exec sed -i '.bak' "s/CONFIG_DOMAIN/${DOMAIN}/g" {} +
find temp -name '*.yaml' -exec sed -i '.bak' "s/CONFIG_PRIMARY_URL/${PRIMARY_URL}/g" {} +

 
echo ""
echo "Apply files."
kubectl apply -f $TEMPFOLDER

 
# remove temp directory
echo ""
echo "Remove the directory."

rm -r $TEMPFOLDER
 
echo ""
echo "Completed updating Kubernetes."
echo ""
