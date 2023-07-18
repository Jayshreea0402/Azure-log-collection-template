param (
    $SubscriptionId = "5807cfb0-41a6-4da6-b920-71d934d4a2af" ,
    $EventhubNamespace = "motadataEventhubNamespace",
    $FunctionAppName = "motadata-functionapp",
    $ResourceGroupLocation = "westus2",
    $ResourceGroupName = "motadata-rg",
    $EventhubName = "motadataEventhub",
    $FunctionName = "motadata-function",
    $DiagnosticSettingName = "motadata-activity-logs-diagnostic-setting"
)

Set-AzContext -SubscriptionId $SubscriptionId

#Download python code for function app 
$code = (New-Object System.Net.WebClient).DownloadString("https://github.com/Jayshreea0402/motadata/blob/main/__init__.py")
#New resource group
New-AzResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation


$deploymentArgs = @{
    TemplateUri       = "https://github.com/Jayshreea0402/motadata/blob/main/eventHub.json"
    ResourceGroupName = $ResourceGroupName
    functionCode      = $code
    location          = $ResourceGroupLocation
    eventHubName      = $EventhubName
    functionName      = $FunctionName
}

$deploymentArgs = @{
    TemplateUri       = "https://github.com/Jayshreea0402/motadata/blob/main/function-app.json"
    ResourceGroupName = $ResourceGroupName
    functionCode      = $code
    location          = $ResourceGroupLocation
    eventHubName      = $EventhubName
    functionName      = $FunctionName
}
{
 New-AzDeployment `
        -TemplateUri "https://github.com/Jayshreea0402/motadata/blob/main/diagnostic-setting.json" `
        -eventHubNamespace $EventhubNamespace `
        -eventHubName $EventhubName `
        -settingName $DiagnosticSettingName `
        -resourceGroup $ResourceGroupName `
        -Location $ResourceGroupLocation `
        -Verbose `
        -ErrorAction Stop
}
