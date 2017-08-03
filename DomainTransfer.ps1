<#
 .SYNOPSIS
    Transfer a domain name to Azure

 .DESCRIPTION
    Transfer a domain name from another registrar to Azure with authorization code
#>

param (
    [Parameter(Mandatory=$true)]
    #The domain name to transfer.
    [string]$domainName,
        
    [Parameter(Mandatory=$true)]
    #The domain name to transfer.
    [string]$domainTransferCode,
        
    [Parameter(Mandatory=$true)]
    #The resource group name where the resource will be added.
    [string]$resourcegroupName,
    
    [Parameter(Mandatory=$true)]
    #The ip address you're running this script from.
    [string]$ipAddress,

    [Parameter(Mandatory=$false)]
    #The subscription id where the domain will be transfered.
    [string]$subscriptionId
        
)

$ErrorActionPreference = "Stop"
$ResourceLocation = "Global"
$agreedAtDateTime = Get-Date -format u

# Login to Azure and select subscription
Write-Output "Logging in"
Login-AzureRmAccount

if($subscriptionId)
{
    # Let the user select the subscription
    Write-Output "Selecting subscription '$subscriptionId'";
    Select-AzureRmSubscription -SubscriptionId $subscriptionId;
}

# Register the Microsoft Domains resource provider for the subscription
Write-Output "Register the Microsoft Domains resource provider for the subscription"
Register-AzureRmResourceProvider -ProviderNamespace Microsoft.DomainRegistration

$resourceProperties = @{
    'Consent' = @{
        'AgreementKeys' = @("DNPA","DNTA");
        'AgreedBy' = $ipAddress;
        'AgreedAt' = $agreedAtDateTime;
    };
    'authCode' = $domainTransferCode;
    'Privacy' = 'true';
    'autoRenew' = 'true';
}

New-AzureRmResource -ResourceName $domainName -Location $resourceLocation -ResourceType Microsoft.DomainRegistration/domains -ResourceGroupName $resourcegroupName -Properties $resourceProperties -ApiVersion 2015-02-01 -Verbose