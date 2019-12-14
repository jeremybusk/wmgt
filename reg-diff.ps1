$bkp_dir = "C:\wmgt\bkp\reg"
cd $bkp_dir 
$file1 = get-childitem -filter "*2019*" | sort LastWriteTime -Descending |select name | select  -Last 1 
$folder1 = Get-ChildItem -filter "*2019*" -Path $dir |
         Sort-Object CreationTime -Descending |
	 select name |
         Select-Object -Skip 0 |
         Select-Object -First 1 |
	 foreach { $_.Name }

$folder2 = Get-ChildItem -filter "*2019*" -Path $dir |
         Sort-Object CreationTime -Descending |
	 select name |
         Select-Object -Skip 1 |
         Select-Object -First 1 |
	 foreach { $_.Name }

write-output "Compare latest backup folder $folder1 with $folder2."

$reg_keys = @{
    "SCHANNEL" = "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL"
    "SSL" = "HKLM\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL"
    "Wow6432Node" = "HKLM\SOFTWARE\Wow6432Node\Microsoft\.NETFramework" 
    "NETFramework" = "HKLM\SOFTWARE\Microsoft\.NETFramework"
}
foreach ($reg_key in $reg_keys.GetEnumerator()) {
    # Write-Host "Comparing reg key $($reg_key.name): $($reg_key.value).reg"
    # reg export $($reg_key.value) $bkp_dir/$($reg_key.name).reg /y
    $file1 = "$bkp_dir\$folder1\$($reg_key.name).reg"
    $file2 = "$bkp_dir\$folder2\$($reg_key.name).reg"
    Write-Host "Comparing"
    Write-Host "$file1"
    Write-Host "$file2"
    Write-Host "===================================="
    compare-object (get-content $file1) (get-content $file2)
}

cd ../../
# cd C:\wmgt

exit

# Diff all hives
$hives = @("hkcr", "hkcu", "hklm", "hku", "hkcc")
foreach ($hive in $hives) {
    write-output $hive
    $file1 = "$bkp_dir\$folder1\$hive.reg"
    $file2 = "$bkp_dir\$folder2\$hive.reg"
    compare-object (get-content $file1) (get-content $file2)
}




exit
# Trash
file1 = "$bkp_dir\$folder1
file2 = "$bkp_dir\$folder1\hkcr.reg
compare-object (get-content 1) (get-content 2)
# cd X:\regbkp
cd C:\wmgt
# compare-object (get-content 1) (get-content 2)
#
# reg export HKCR $bkp_dir/hkcr.reg /y                                                                                    # reg export HKCU $bkp_dir\$timestamp-HKCU.Reg /y                                                                       reg export HKCU $bkp_dir\hkcu.reg /y                                                                                                                                                                                                            reg export HKLM $bkp_dir\hklm.reg /y                                                                                                                                                                                                            reg export HKU $bkp_dir\hku.reg /y                                                                                                                                                                                                              reg export HKCC $bkp_dir\hkcc.reg /y      
#
# $file2 = get-childitem -filter "*2019*" | sort LastWriteTime -Descending |select name | select  -Last 2 
# $file1 = get-childitem -filter "*2019*" | sort LastWriteTime -Descending |select name | foreach { $_.Name }  | select -First 1
# $file2 = get-childitem -filter "*2019*" | sort LastWriteTime -Descending |select name | foreach { $_.Name }  | select -Skip 1 | First 1
