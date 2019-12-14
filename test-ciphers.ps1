# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$r = invoke-webrequest "https://pyrofex.io"
$r.BaseResponse | findstr ProtocolVersion
