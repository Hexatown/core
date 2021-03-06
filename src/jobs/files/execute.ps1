function execute {
param($hexatown, $list, $script)

    $schema = loadFromJSON $PSScriptRoot ".schema"
    $filter = "fields/Processed ne 1"
    $items = SharePointReadThrottleableQuery  $hexatown ('/Lists/' + $schema.lists.$list + '/items/?$expand=fields&$filter=' + $filter)

    foreach ($item in $items)
    {
        $request = RemoveStandardSharePointProperties $item.fields
        $errorMessage =$null
        $response=$null
        try
        {
            $response = Invoke-Command -ScriptBlock $script | convertto-json 
            $ResponseCode = 200
        }
        catch 
        {
            $response  =   $psitem.Exception.Message
            $ResponseCode = 500
        }
        
     

$body = @{fields = @{
                      Processed = $true
                      ResponseCode = $ResponseCode
     #                 Error = $errorMessage
                      Response = $response 
                     } 
} | ConvertTo-Json
        PatchSharePointListItem $hexatown.token $hexatown.site $schema.lists.$list $item.id $body | Out-Null
    }

}
