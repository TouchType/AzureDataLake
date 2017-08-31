workflow adlsAccessSet {
    
       param([string[]]$adlspaths)
    
       foreach -parallel ($path in $adlspaths){
    
        "$path"
        pwd
        # InlineScript
        # {
        # .\Set-AdlsAccess.ps1 -Account analyticstelemetry -Path /app-telemetry/parquet_flat/$Using:path/ -EntityId 609efa91-4471-4a8f-b421-fce5286fba17 -EntityType Group -SetAclEntry -Permissions ReadExecute
        # }
        } 
    }

#$paths = "Clarity_20150312","Cloud_Telemetry_production","Emoji_iOS_beta","Emoji_iOS_market", "Hexy_prod", "SwiftKey_Android_beta", "SwiftKey_Android_beta_20150422", "SwiftKey_Android_beta_RS0.9", "SwiftKey_Android_emoji", "SwiftKey_Android_emoji_beta", "SwiftKey_Android_nn", "SwiftKey_Android_prod", "SwiftKey_Android_prod_20150422", "SwiftKey_Android_shakespeare", "SwiftKey_Android_touch_data", "SwiftKey_iOS_beta", "SwiftKey_iOS_prod", "deblois-android-release"
$paths = "Clarity_20150312","Cloud_Telemetry_production"

adlsAccessSet  -adlspaths $paths


#az dls fs list -n analyticstelemetry --path /app-telemetry/parquet_flat --output json | jq '.[].pathSuffix' -r
#Samples/PowerShell/ADLSUser/Set-AdlsAccess.ps1 -Account analyticstelemetry -Path /app-telemetry/parquet_flat/SwiftKey_Android_prod/ -EntityId 609efa91-4471-4a8f-b421-fce5286fba17 -EntityType Group -SetAclEntry -Permissions ReadExecute