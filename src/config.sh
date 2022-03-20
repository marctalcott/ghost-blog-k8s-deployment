# config.sh
#!/bin/bash


echo ""
echo "Setting variables."

# ********** Edit the variables below as needed for your website and domain ****************

NAMESPACE="default"                      # Leave this as 'default' unless you know why you are changing it
APP_NAME="mysite"                        # I suggest using your domain name without the .com so you can easily identify the app.
DOMAIN="mysite.com"                      # Set to your domain name
PRIMARY_URL="https:\/\/${DOMAIN}"        # You probably don't want to change this one. This defines your URL.

TLS_CRT="yourBase64EncodedSSLCert"       # Your base64 encoded SSL Cert. 
TLS_KEY="yourBase64EncodedSSLPrivKey"    # Your base64 encoded Private Key for the SSL Cert.

TEMPFOLDER="temp"	                       # Don't change this. We use this folder to put generated files and deploy. Then we delete it.


# ********** Edit the variables above as needed ****************



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
find temp -name '*.yaml' -exec sed -i '.bak' "s/CONFIG_TLS_CRT/${TLS_CRT}/g" {} +
find temp -name '*.yaml' -exec sed -i '.bak' "s/CONFIG_TLS_KEY/${TLS_KEY}/g" {} +
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
