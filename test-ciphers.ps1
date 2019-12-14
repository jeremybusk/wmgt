# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$r = invoke-webrequest "https://pyrofex.io"
$r.BaseResponse | findstr ProtocolVersion

# ./curl.exe -v --tlsv1.1 https://google.com | select -first 10

# ./app/curl/curl.exe -v --tlsv1.1 https://google.com
# curl.exe -v --tlsv1.1 https://google.com
# nmap -sV --script ssl-enum-ciphers -p 443 <host>
# nmap -sV --script ssl-enum-ciphers -p 3389 <host>
