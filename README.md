# What this does
Simple registry suite for actions on windows registry keys:
- backing up keys
- updating keys
- comparing changes to the most recent backups of keys


## Keys impacted for ciphers
"SCHANNEL" = "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL"
"SSL" = "HKLM\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL"
"Wow6432Node" = "HKLM\SOFTWARE\Wow6432Node\Microsoft\.NETFramework" 
"NETFramework" = "HKLM\SOFTWARE\Microsoft\.NETFramework"


# Running script
./reg-bkp.ps1
./reg-diff.ps1


# Testing ciphers
nmap -sV --script ssl-enum-ciphers -p 443 example.com  # See what ciphers your server supports
Get-TlsCipherSuite  # Get your local ciphers
curl.exe -v --tlsv1.1 --ciphers ECDHE-RSA-AES128-GCM-SHA256 "https://example.com"  # Test a combo


# tshark to verify packets
dumpcap -D -M

0x00000300 = sslv3
0x00000301 = tlsv1.0
0x00000302 = tlsv1.1
0x00000303 = tlsv1.2

tshark  -ni "Ethernet" -f "tcp port 443 and host 93.184.216.34" -Y "tls.handshake.type == 1" -T fields -e frame.number -e ip.src -e tls.handshake.version

tshark  -ni "Ethernet" -f "tcp port 443 and host 93.184.216.34" -Y "tls.handshake.type == 1" -T fields -e frame.number -e ip.src -e tls.handshake.version
Capturing on 'Ethernet'
5       10.1.1.105      0x00000302
72      10.1.1.105      0x00000303
139     10.1.1.105      0x00000301


## Deeper packet inspection with a count of 10 
tshark -ni "Ethernet" `                                                                                                 -o "tls.desegment_ssl_records: TRUE" `                                                                                  -f "tcp port 443 and host 93.184.216.34" `                                                                                -V -c 10   




# Even More Stuff

ssl.handshake.version==0x0301

curl.exe -v --sslv3 https://example.com
curl.exe -v --tlsv1.0 https://example.com



 tshark -ni "Ethernet" -T fields -Y tls.handshake.type==2 -e tls.handshake.extensions.supported_version -e tls.handshake.version

https://security.stackexchange.com/questions/142939/determine-ssl-tls-version-using-wireshark

0x0302 is TLS 1.1 and 0x0303 is TLS 1.2.

https://osqa-ask.wireshark.org/questions/37528/decode-ssl-decimal-fields-in-tshark-output
tshark -ni "Ethernet" -Y "ssl.handshake.ciphersuites"

tshark -ni "Ethernet" -Y "ssl.handshake.ciphersuites" -Vx

tshark -ni "Ethernet" -Y "ssl.handshake.ciphersuites" -Vx -c 100
tshark -ni "Ethernet" -Y "ssl.handshake.ciphersuites and ip.dst==93.184.216.34" -Vx

tshark -ni "Ethernet" -f "host 93.184.216.34" -Y "ssl.handshake.ciphersuites and ip.dst==93.184.216.34" -Vx -c 30
only shows 1 packet captured


tshark -ni "Ethernet" `
-o "tls.desegment_ssl_records: TRUE" `
-f "tcp port 443 and host 93.184.216.34" `
-V -c 10



tshark -ni "Ethernet" -f "host 93.184.216.34" `
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
-f "tcp port 443 and host 93.184.216.34" `
-V -x

PS C:\wmgt\tmp> tshark -ni "Ethernet" `
>> -o "tls.desegment_ssl_records: TRUE" `
>> -o "tls.desegment_ssl_application_data: FALSE" `
>> -o "tls.keys_list:11.111.111.111,15000,http,key.pem" `
>> -f "tcp port 443 and host 93.184.216.34" `
>> -V -x -c 10

http://blog.fourthbit.com/2014/12/23/traffic-analysis-of-an-ssl-slash-tls-session/
  Handshake Type Values    dec      hex
   -------------------------------------
   HELLO_REQUEST              0     0x00
   CLIENT_HELLO               1     0x01
   SERVER_HELLO               2     0x02
   CERTIFICATE               11     0x0b
   SERVER_KEY_EXCHANGE       12     0x0c
   CERTIFICATE_REQUEST       13     0x0d
   SERVER_DONE               14     0x0e
   CERTIFICATE_VERIFY        15     0x0f
   CLIENT_KEY_EXCHANGE       16     0x10
   FINISHED                  20     0x14
