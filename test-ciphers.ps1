$r = invoke-webrequest "https://pyrofex.io"
$r.BaseResponse | findstr ProtocolVersion
