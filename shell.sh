#!/bin/bash

# Load environment variables from config.env file
if [ -f ./config.env ]; then
    export $(cat ./config.env | xargs)
fi

# Define variables for resource group
RESOURCE_GROUP_NAME="project-6"
LOCATION="canadaeast"

# Log in to Azure using the service principal
az login --service-principal --username $AZURE_APP_ID --password $AZURE_PASSWORD --tenant $AZURE_TENANT

# Check login status
if [ $? -eq 0 ]; then
    echo "Login successful!"

    # Create the resource group
    az group create --name $RESOURCE_GROUP_NAME --location $LOCATION
    
    # Check resource group creation status
    if [ $? -eq 0 ]; then
        echo "Resource group creation successful!"

        # Deploy the ARM template to create the storage account within the resource group
        az deployment group create --resource-group $RESOURCE_GROUP_NAME --template-file storage_account.json --parameters @parameters.json
        
        # Check deployment status
        if [ $? -eq 0 ]; then
            echo "Storage account creation successful!"
        else
            echo "Storage account creation failed!"
        fi
    else
        echo "Resource group creation failed!"
    fi
else
    echo "Login failed!"
fi