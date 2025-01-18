#!/bin/bash 

source /home/azureuser/config.env


echo "Logging into Azure with created Service Principal" 

az login --service-principal -u $AZURE_APP_ID -P $AZURE_PASSWORD --tenant $AZURE_TENANT 


if [ $? -ne 0 ]; then 
   echo "Oops Azure login failed.." 
    exit 1 
fi 
echo "Yayy, Azure login successful" 

 

echo "Deploying ARM template to create storage account"

 
if [$? -ne 0 ]; then 
  echo "Deployment failed" 
  exit 1 
fi 

echo "Storage account deployed successfully!" 
az deployment group create --resource-group NCPLproject --template-file storage_account.json 