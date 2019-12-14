Simple registry suite for actions on windows registry keys:
- backing up keys
- updating keys
- comparing changes to the most recent backups of keys

./reg-bkp.ps1
./reg-diff.ps1


Keys impacted for ciphers
"SCHANNEL" = "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL"
"SSL" = "HKLM\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL"
"Wow6432Node" = "HKLM\SOFTWARE\Wow6432Node\Microsoft\.NETFramework" 
"NETFramework" = "HKLM\SOFTWARE\Microsoft\.NETFramework"

tshark
dumpcap -D -M

ssl.handshake.version==0x0301

 tshark -ni "Ethernet" -T fields -Y tls.handshake.type==2 -e tls.handshake.extensions.supported_version -e tls.handshake.version

https://security.stackexchange.com/questions/142939/determine-ssl-tls-version-using-wireshark

0x0302 is TLS 1.1 and 0x0303 is TLS 1.2.

https://osqa-ask.wireshark.org/questions/37528/decode-ssl-decimal-fields-in-tshark-output
tshark -ni "Ethernet" -Y "ssl.handshake.ciphersuites"
