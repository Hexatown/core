function Serve {


param(
$hexatown,
$minutes = 30,
$callBacks = @{}
)

try
{

    $StartDate=(GET-DATE)
    $StartDateMinute=(GET-DATE)
    $TotalMinutes = 0
    $requestListName = "Hexatown Requests"
    

    
    
    write-host "Serve process will run for $minutes minutes"
    $done = $false
    do
    {
        
    $filter = "fields/Processed ne 1"
    $items = SharePointReadThrottleableQuery  $hexatown ("/Lists/$requestListName/items/?`$expand=fields&`$filter=$filter&`$orderby=id")

    foreach ($item in $items)
    {
        $request = RemoveStandardSharePointProperties $item.fields
        write-host $item.id $path $method $payload.title $requestor  
        $parsedRequest = (GetPayload $request)
        $payLoad = $parsedRequest[0]
        if ($null-ne $parsedRequest[1]){
            $ResponseCode = 400
            $responseData = $parsedRequest[1]
            $responseJSON = $responseData | convertto-json -Depth 10
            # $responseCSV = $responseData | ConvertTo-Csv -Delimiter "|" | Convertto-Json 

        }
        else {        
        $requestor = $item.createdBy.user
        $errorMessage =$null
        $response=$null
        
        try
        {
        
            $path = $request.Path
            $method = $request.Method
            if ($ENV:APICAPTURE){
            if (!(test-path "$PSScriptRoot/../../apis$path/$method.ps1")){
                EnsurePath "$PSScriptRoot/../../apis$path"
                $scriptText = @"
param (`$hexatown,`$request,`$requestor)
&`"`$PSScriptRoot\..\..\actions\***THE SCRIPT TO USE***.ps1" `
`$hexatown `

"@        

    $requestFields = $payload | Get-Member -MemberType  NoteProperty | Select Name
    foreach ($field in $requestFields)
    {
        $scriptText += "`$request.'$($field.Name)'`` `n"
    }
    
            Out-File "$PSScriptRoot/../../apis$path/$method.ps1" -InputObject  $scriptText 
            
            }
            
            }
          
            if (!(test-path "$PSScriptRoot/../../apis$path/$method.ps1")) {
                $responseData = "apis$path/$method not found"
                $ResponseCode = 401
            }else
            {

                if (!(test-path "$PSScriptRoot/../../apis$path/$method.sample.json")) {
                    $requestProperties = $payload | Get-Member -MemberType  NoteProperty | Select Name, Definition
                    ConvertTo-Json -InputObject $requestProperties  -Depth 10 | Out-File "$PSScriptRoot/../../apis$path/$method.sample.json" 

                }
                if (!(test-path "$PSScriptRoot/../../apis$path/$method.fields.json")) {

                    $requestFields = $payload | Get-Member -MemberType  NoteProperty | Select Name
                    ConvertTo-Json -InputObject $requestFields  -Depth 10 | Out-File "$PSScriptRoot/../../apis$path/$method.fields.json" 
                }

                $responseData = & "$PSScriptRoot/../../apis/$path/$method.ps1" $hexatown $payload $requestor
                
                
                $ResponseCode = 200
                
            }        
        
        }
        catch 
        {
            $responseData  = $psitem.Exception.Message
            $ResponseCode = 500
        }
        finally {
            $responseJSON = $responseData | convertto-json -Depth 10
            #$responseCSV = $responseData | ConvertTo-Csv -Delimiter "|" | Convertto-Json 
        }
        if ($null -eq $responseData){
            
            $responseJSON = ""
            $responseCSV = ""
        }
        }

     
$body = @{fields = @{
                      Processed = $true
                      Responsecode = $ResponseCode
                      Response = $responseJSON
                      #ResponseCSV = $responseCSV 
                     } 
} | ConvertTo-Json

        PatchSharePointListItem $hexatown.token $hexatown.site $requestListName $item.id $body | Out-Null
        Write-Host "Response code" $responseCode
    }

        Start-Sleep -Seconds 1
        $elapsed =  New-TimeSpan -Start $StartDate -End (GET-DATE)

        $elapsedMinute =  New-TimeSpan -Start $StartDateMinute -End (GET-DATE)

        if ($elapsedMinute.TotalMinutes -ge 1){
            $TotalMinutes++
            Write-host "One minute passed, $TotalMinutes total minutes " -ForegroundColor Gray
            
            $StartDateMinute=(GET-DATE)
        }


        if ($elapsed.TotalMinutes -gt $minutes){
            Write-host "Processes time of $minutes passed" -ForegroundColor Yellow
            $done = $true
        }
    }
    until ($done)

}
catch 
{
    Write-Host "ERROR" $_ -ForegroundColor Red
}



}
