$timestamp = $(get-date -f MM-dd-yyyyTHH-mm-ss)

# Backup specific registry keys we are changing
$bkp_dir = "C:\wmgt\bkp\hives-reg\$timestamp"
mkdir -p $bkp_dir 

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
