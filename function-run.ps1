# Function App deployment settings
$resourceGroupName = "motadata-rg"
$functionAppName = "motadata-functionapp"
$functionAppDeploymentFile = "/home/jayshree/activity-log-collection/function-app.json"
$pythonCodeFile = "/home/jayshree/activity-log-collection/__init__.py"
$location = "eastus"

# # Deploy Function App
az functionapp create --resource-group $resourceGroupName --name $functionAppName --deployment-`config $functionAppDeploymentFile

# # Upload Python code file to Function App
az functionapp deployment source config-zip --resource-group $resourceGroupName --name $functionAppName --src $pythonCodeFile

# Create a new Function App
#New-AzFunctionApp -ResourceGroupName $resourceGroupName -Name $functionAppName -Location $location -Runtime "python"

# Publish the Python code to the Function App
#Publish-AzFunctionApp -ResourceGroupName $resourceGroupName -Name $functionAppName -ArchivePath $pythonCodeFile
