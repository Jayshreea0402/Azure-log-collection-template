# Import the required Azure modules
Import-Module Az.Accounts
Import-Module Az.EventHub

# Variables for Azure subscription, resource group, Event Hub namespace, and Event Hub
$subscriptionId = "5807cfb0-41a6-4da6-b920-71d934d4a2af"
$resourceGroupName = "motadata-rg"
$eventHubNamespace = "motadataEventhubNamespace"
$eventHubName = "motadataEventhub"
$location = "eastus"
$authorizationRuleName = "SasPolicy-motadata"
$StartTime = Get-Date
$DiagnosticSettingName = "datadog-activity-logs-diagnostic-setting"
# Authenticate to your Azure account
Connect-AzAccount
# Set the target Azure subscription
Set-AzContext -SubscriptionId $subscriptionId

#Create Resource group 
New-AzResourceGroup -Name $resourceGroupName -Location $location
# Create an Event Hub namespace
$namespace = New-AzEventHubNamespace -ResourceGroupName $resourceGroupName -Name $eventHubNamespace -Location $location
# Create an Event Hub
$eventHub = New-AzEventHub -ResourceGroupName $resourceGroupName -NamespaceName $eventHubNamespace -Name $eventHubName -PartitionCount 1

# Get the primary connection string of the Event Hub namespace
$namespaceConnectionString = (Get-AzEventHubNamespace -ResourceGroupName $resourceGroupName -NamespaceName $eventHubNamespace).PrimaryConnectionString

# Create a SAS policy for the Event Hub
$sasPolicy = New-AzEventHubAuthorizationRule -ResourceGroupName $resourceGroupName -NamespaceName $eventHubNamespace `
    -EventHubName $eventHubName -Name $authorizationRuleName -Rights @("Listen", "Send")

# Get the Event Hub namespace connection string
$eventHubNamespaceConnectionString = (Get-AzEventHubNamespace -ResourceGroupName $resourceGroupName -NamespaceName $eventHubNamespace).PrimaryConnectionString


Write-Host "Event Hub namespace created: $eventHubNamespace"
Write-Host "Event Hub created: $eventHubName"
Write-Host "SAS token created: $($sasToken.PrimaryConnectionString)"
Write-Host "SAS token expiry date: $expiryDate"

# New-AzDeployment -TemplateUri "/subscriptions/5807cfb0-41a6-4da6-b920-71d934d4a2af/resourceGroups/motadata-rg/providers/Microsoft.Resources/templateSpecs/diagnostic-activity-log" `
#     -Location $location `
#     -TemplateParameterObject @{
#         "eventHubNamespace" = $eventHubNamespace
#         "eventHubName" = $eventHubName
#         "settingName" = $DiagnosticSettingName
#         "resourceGroupName" = $resourceGroupName
#     }
