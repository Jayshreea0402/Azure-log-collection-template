param (
    $SubscriptionId = "5807cfb0-41a6-4da6-b920-71d934d4a2af" ,
    $EventhubNamespace = "motadataEventhubNamespace",
    $FunctionAppName = "motadata-functionapp",
    $ResourceGroupLocation = "westus2",
    $ResourceGroupName = "motadata-rg",
    $EventhubName = "motadataEventhub",
    $FunctionName = "motadata-function",
    $DiagnosticSettingName = "motadata-activity-logs-diagnostic-setting",
)

Set-AzContext -SubscriptionId $SubscriptionId

#Download python code for function app 
$code = (New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/DataDog/datadog-serverless-functions/master/azure/activity_logs_monitoring/index.js")
