param(
    $tenantid,
    $sp_username,
    $sp_app_id,
    $sp_password

)

workflow adlsAccessSet {
    
       param(
           [string[]]$adlspaths,
           [string]$tenantid,
           [string]$sp_username,
           [string]$sp_app_id,
           [string]$sp_password

        )
    
       foreach -parallel ($path in $adlspaths){
        "$path"
        InlineScript
        {
            "$path"
            $userName =$Using:sp_username
            $password = ConvertTo-SecureString $Using:sp_password -AsPlainText -Force
            $credential = New-Object System.Management.Automation.PSCredential($userName, $password)
            Login-AzureRmAccount -Credential $credential -ServicePrincipal –TenantId $Using:tenantid
            # C:\Users\skadmin\agent\_work\1\s\Samples\PowerShell\ADLSUser\Set-AdlsAccess.ps1 -Account analyticstelemetry -Path /app-telemetry/parquet_flat/SwiftKey_Android_prod/ -EntityId 609efa91-4471-4a8f-b421-fce5286fba17 -EntityType Group -SetAclEntry -Permissions ReadExecute
            # .\Set-AdlsAccess.ps1 -Account analyticstelemetry -Path /app-telemetry/parquet_flat/$Using:path/ -EntityId 609efa91-4471-4a8f-b421-fce5286fba17 -EntityType Group -SetAclEntry -Permissions ReadExecute
        }
        } 
    }

#$paths = "Clarity_20150312","Cloud_Telemetry_production","Emoji_iOS_beta","Emoji_iOS_market", "Hexy_prod", "SwiftKey_Android_beta", "SwiftKey_Android_beta_20150422", "SwiftKey_Android_beta_RS0.9", "SwiftKey_Android_emoji", "SwiftKey_Android_emoji_beta", "SwiftKey_Android_nn", "SwiftKey_Android_prod", "SwiftKey_Android_prod_20150422", "SwiftKey_Android_shakespeare", "SwiftKey_Android_touch_data", "SwiftKey_iOS_beta", "SwiftKey_iOS_prod", "deblois-android-release"
$paths = "Clarity_20150312"
adlsAccessSet  -adlspaths $paths -sp_username $sp_username -sp_app_id $sp_app_id -sp_password $sp_password -tenantid $tenantid


#az dls fs list -n analyticstelemetry --path /app-telemetry/parquet_flat --output json | jq '.[].pathSuffix' -r
#Samples/PowerShell/ADLSUser/Set-AdlsAccess.ps1 -Account analyticstelemetry -Path /app-telemetry/parquet_flat/SwiftKey_Android_prod/ -EntityId 609efa91-4471-4a8f-b421-fce5286fba17 -EntityType Group -SetAclEntry -Permissions ReadExecute