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

tshark -ni "Ethernet" -Y "ssl.handshake.ciphersuites" -Vx

tshark -ni "Ethernet" -Y "ssl.handshake.ciphersuites" -Vx -c 100
tshark -ni "Ethernet" -Y "ssl.handshake.ciphersuites and ip.dst==52.119.8.72" -Vx

tshark -ni "Ethernet" -f "host 52.119.8.72" -Y "ssl.handshake.ciphersuites and ip.dst==52.119.8.72" -Vx -c 30
only shows 1 packet captured


tshark -ni "Ethernet" `
-o "tls.desegment_ssl_records: TRUE" `
-f "tcp port 443 and host 52.119.8.72" `
-V -c 10



tshark -ni "Ethernet" -f "host 52.119.8.72" `
-o "ssl.desegment_ssl_records: TRUE" `
-o "ssl.desegment_ssl_application_data: TRUE" `
-o "ssl.keys_list:11.111.111.111,15000,http,key.pem" `
-o "tls.debug_file:tlsdebug.log" `
-f "tcp port 443" `
-R "ssl" `
-V -x


tshark -ni "Ethernet" `
-o "tls.desegment_ssl_records: TRUE" `
-o "tls.desegment_ssl_application_data: TRUE" `
-o "tls.keys_list:11.111.111.111,15000,http,key.pem" `
-f "tcp port 443 and host 52.119.8.72" `
-V -x

PS C:\wmgt\tmp> tshark -ni "Ethernet" `
>> -o "tls.desegment_ssl_records: TRUE" `
>> -o "tls.desegment_ssl_application_data: FALSE" `
>> -o "tls.keys_list:11.111.111.111,15000,http,key.pem" `
>> -f "tcp port 443 and host 52.119.8.72" `
>> -V -x -c 10
