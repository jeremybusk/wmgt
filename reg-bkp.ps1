$timestamp = $(get-date -f MM-dd-yyyyTHH-mm-ss)

# Backup specific registry keys we are changing
$bkp_dir = "C:\wmgt\bkp\reg\$timestamp"
mkdir -p $bkp_dir 
$reg_keys = @{
    "SCHANNEL" = "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL"
    "SSL" = "HKLM\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL"
    "Wow6432Node" = "HKLM\SOFTWARE\Wow6432Node\Microsoft\.NETFramework" 
    "NETFramework" = "HKLM\SOFTWARE\Microsoft\.NETFramework"
}
foreach ($reg_key in $reg_keys.GetEnumerator()) {
    Write-Host "$($reg_key.name): $($reg_key.value).reg"
    reg export $($reg_key.value) $bkp_dir/$($reg_key.name).reg /y
}

exit
# Backup entire hives
write-output "Backup Entire Hives"
$bkp_dir = "C:\wmgt\bkp\reg-hives\$timestamp"
mkdir -p $bkp_dir 
$hives = @{
    "HKCR" = "hkcr"
    "HKCU" = "hkcu"
    "HKLM" = "hklm"
    "HKU" = "hku"
    "HKCC" = "hkcc"
}

foreach ($hive in $hives.GetEnumerator()) {
    Write-Host "$($hive.name): $($hive.value).reg"
    reg export $($hive.name) $bkp_dir/$($hive.value).reg /y
}

cd C:\wmgt






exit
# trash
$reg_paths = @{}
$reg_paths.Add("SCHANNEL", "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL")
$reg_paths.Add("SSL", "HKLM\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL")
$reg_paths.Add("Wow6432Node", "HKLM\SOFTWARE\Wow6432Node\Microsoft\.NETFramework")
$reg_paths.Add("NETFramework", "HKLM\SOFTWARE\Microsoft\.NETFramework")
foreach($key in $reg_paths.keys){
    Write-output $key
    $value = $reg_paths[$key]
    Write-output $value 
    reg export $value $bkp_dir\$key.reg
}

# reg export HKCR $bkp_dir/hkcr.reg /y
# reg export HKCU $bkp_dir\hkcu.reg /y
# reg export HKLM $bkp_dir\hklm.reg /y
# reg export HKU $bkp_dir\hku.reg /y
# reg export HKCC $bkp_dir\hkcc.reg /y
