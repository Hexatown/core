function GraphAPI {
param($hexatown, $method, $url, $body, $ignoreError)

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Content-Type", "application/json")
    $headers.Add("Accept", "application/json")
    $headers.Add("Authorization", "Bearer $($hexatown.token)" )
    
    
    $errorCount = $error.Count
    $CurrentErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'SilentlyContinue'
    $result = Invoke-RestMethod ($url) -Method $method -Headers $headers -Body $body 
    
    $ErrorActionPreference = $CurrentErrorActionPreference
    if (!$ignoreError -and $errorCount -ne $error.Count) {
        Write-Error $url
    }

    return $result


}
