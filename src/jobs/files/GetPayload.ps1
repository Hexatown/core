function GetPayload {
param($request)


try
{
     $payload = ConvertFrom-Json -InputObject $request.Request    
}

catch 
{
    $errorMessage = $psitem.Exception.Message
    $payload = @{}
}
return $payload,$errorMessage


}
