<# @HEXATOWN/MOVER 
 Copyright (C) 2020 Niels Gregers Johansen, All Rights reserved.

#>


[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


function DotEnvConfigure($debug, $path) {

    $loop = $true

    $package = loadFromJSON $path "/../../../package"


    
    $environmentPath = $env:HEXATOWNHOME
    if ($null -eq $environmentPath ) {
        $environmentPath = ([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonApplicationData)) 
    }
    $path = "$environmentPath/hexatown.com/$($package.name)"
 
 
    EnsurePath "$environmentPath/hexatown.com"
    if (!(test-path "$environmentPath/hexatown.com/$($package.name)") ) {
        EnsurePath "$environmentPath/hexatown.com/$($package.name)"
        Start-Process "$environmentPath/hexatown.com/$($package.name)"
    }
    
    

    do {
        $filename = "$path\.env"
        if ($debug) {
            write-output "Checking $filename"
        }
        if (Test-Path $filename) {
            if ($debug) {
                write-output "Using $filename"
            }
            $lines = Get-Content $filename
             
            foreach ($line in $lines) {
                    
                $nameValuePair = $line.split("=")
                if ($nameValuePair[0] -ne "") {
                    if ($debug) {
                        write-host "Setting >$($nameValuePair[0])<"
                    }
                    $value = $nameValuePair[1]
                    
                    for ($i = 2; $i -lt $nameValuePair.Count; $i++) {
                        $value += "="
                        $value += $nameValuePair[$i]
                    }

                    if ($debug) {
                        write-host "To >$value<"
                    }    
                    [System.Environment]::SetEnvironmentVariable($nameValuePair[0], $value)
                }
            }
    
            $loop = $false
        }
        else {
            $lastBackslash = $path.LastIndexOf("\")
            if ($lastBackslash -lt 4) {
                $loop = $false
                if ($debug) {
                    write-output "Didn't find any .env file  "
                }
            }
            else {
                $path = $path.Substring(0, $lastBackslash)
            }
        }
    
    } while ($loop)
    
}
    

function GetAccessToken($client_id, $client_secret, $client_domain) {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Content-Type", "application/x-www-form-urlencoded")
    $body = "grant_type=client_credentials&client_id=$client_id&client_secret=$client_secret&scope=https%3A//graph.microsoft.com/.default"
    
    $response = Invoke-RestMethod "https://login.microsoftonline.com/$client_domain/oauth2/v2.0/token" -Method 'POST' -Headers $headers -body $body
    return $response.access_token
    
}
function ConnectExchange($username, $secret) {
    write-output "Connecting to Exchange Online"
    $code = ConvertTo-SecureString $secret -AsPlainText -Force
    $psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $code)
    
    
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $psCred -Authentication Basic -AllowRedirection
    Import-PSSession $Session -DisableNameChecking 
    return $Session
    
}
    
function CreateAlias($name) {
    return $name.ToLower().Replace(" ", "-").Replace(" ", "-").Replace(" ", "-").Replace(" ", "-").Replace(" ", "-").Replace(" ", "-")
}

function EnsurePath($path) {

    If (!(test-path $path)) {
        New-Item -ItemType Directory -Force -Path $path
    }
}

function RealErrorCount() {
    $c = 0
    foreach ($e in $Error) {
        $m = $e.ToString()
        if (!$m.Contains("__Invoke-ReadLineForEditorServices")) {
            $c++
        }
    }
    return $c 
}
function LastError() {
    $m = ""
    foreach ($e in $Error) {
        $m += ($e.ToString().substring(0, 200) + "`n")

    }
    return $m    
}

function isMember($members, $roomSmtpAddress) {
    $found = $false
    foreach ($member in $members) {
        if ($members.PrimarySmtpAddress -eq $roomSmtpAddress) {
            $found = $true
        }
    }
    return $found
}


function LogToSharePoint($token, $site , $title, $status, $system, $subSystem, $reference, $Quantity, $details) {
    $myHeaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $myHeaders.Add("Content-Type", "application/json")
    $myHeaders.Add("Accept", "application/json")
    $myHeaders.Add("Authorization", "Bearer $token" )
    $hostName = $env:COMPUTERNAME
    $details = $details -replace """", "\"""
    $body = "{
        `n    `"fields`": {
        `n        `"Title`": `"$title`",
        `n        `"Host`": `"$hostName`",
        `n        `"Status`": `"$status`",
        `n        `"System`": `"$system`",
        `n        `"SubSystem`": `"$subSystem`",
        `n        `"SystemReference`":`"$reference`",
        `n        `"Quantity`": $Quantity,
        `n        `"Details`": `"$details`"
        `n    }
        `n}"

    # write-output $body 
    #    Out-File -FilePath "$PSScriptRoot\error.json" -InputObject $body
    $url = ($site + '/Lists/Log/items/')
  
    $dummy = Invoke-RestMethod $url -Method 'POST' -Headers $myHeaders -Body $body 
    # return $null -eq $dummy
}

function LogChange($hexatown , $title, $area, $method , $reference) {
    LogToSharePoint $hexatown.token $hexatown.site $title "OK" $area $method $reference 0 "."
}

function ReportErrors($token, $site) {
    if ($Error.Count -gt 0) {
        $errorMessages = ""
        foreach ($errorMessage in $Error) {
            if (($null -ne $errorMessage.InvocationInfo) -and ($errorMessage.InvocationInfo.ScriptLineNumber)) {
                $errorMessages += ("Line: " + $errorMessage.InvocationInfo.ScriptLineNumber + " "  )    
            }

            $errorMessages += $errorMessage.ToString() 
            $errorMessages += "`n"

        }

        LogToSharePoint $token $site "Error in PowerShell" "Error" "PowerShell"  $MyInvocation.MyCommand $null 0 $errorMessages
    }



    function ConnectExchange($username, $secret) {
        $code = ConvertTo-SecureString $secret -AsPlainText -Force
        $psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $code)
    
    
        $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $psCred -Authentication Basic -AllowRedirection
        Import-PSSession $Session -DisableNameChecking 
        return $Session
    
    }
    
}


function FindSiteByUrl($token, $siteUrl) {
    $Xheaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $Xheaders.Add("Content-Type", "application/json")
    $Xheaders.Add("Prefer", "apiversion=2.1") ## Not compatibel when reading items from SharePointed fields 
    $Xheaders.Add("Authorization", "Bearer $token" )

    $url = 'https://graph.microsoft.com/v1.0/sites/?$top=1'
    $topItems = Invoke-RestMethod $url -Method 'GET' -Headers $Xheaders 
    if ($topItems.Length -eq 0) {
        Write-Warning "Cannot read sites from Office Graph - sure permissions are right?"
        exit
    }
    $siteUrl = $siteUrl.replace("sharepoint.com/", "sharepoint.com:/")
    $siteUrl = $siteUrl.replace("https://", "")

    $Zheaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $Zheaders.Add("Content-Type", "application/json")
    $Zheaders.Add("Authorization", "Bearer $token" )
    

    $url = 'https://graph.microsoft.com/v1.0/sites/' + $siteUrl 

    $site = Invoke-RestMethod $url -Method 'GET' -Headers $Zheaders 
   

    return  ( "https://graph.microsoft.com/v1.0/sites/" + $site.id)
}

function GraphAPI($hexatown, $method, $url, $body) {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Content-Type", "application/json")
    $headers.Add("Accept", "application/json")
    $headers.Add("Authorization", "Bearer $($hexatown.token)" )
    
    
    $errorCount = $error.Count
    $result = Invoke-RestMethod ($url) -Method $method -Headers $headers -Body $body
    if ($errorCount -ne $error.Count) {
        Write-Error $url
    }

    return $result

}
<#
.description
Read from Graph and follow @odata.nextLink
.changes
v1.03 Removed -Body from Invoke-RestMethod
#>
function GraphAPIAll($hexatown, $method, $url) {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Content-Type", "application/json")
    $headers.Add("Accept", "application/json")
    $headers.Add("Authorization", "Bearer $($hexatown.token)" )
    
    $errorCount = $error.Count
    $result = Invoke-RestMethod ($url) -Method $method -Headers $headers 
    if ($errorCount -ne $error.Count) {
        Write-Error $url
    }


    $data = $result.value
    $counter = 0
    while ($result.'@odata.nextLink') {
        Write-Progress -Activity "Reading from GraphAPIAll $path" -Status "$counter Items Read" 

        if ($hexatown.verbose) {
            write-output "GraphAPIAll $($result.'@odata.nextLink')"
        }
        $result = Invoke-RestMethod ($result.'@odata.nextLink') -Method 'GET' -Headers $headers 
        $data += $result.value
        $counter += $result.value.Count
        
    }

    return $data

}


function SharePointRead($hexatown, $path) {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Content-Type", "application/json")
    $headers.Add("Accept", "application/json")
    $headers.Add("Authorization", "Bearer $($hexatown.token)" )
    $url = $hexatown.site + $path
    $errorCount = $error.Count
    $result = Invoke-RestMethod ($url) -Method 'GET' -Headers $headers 
    if ($errorCount -ne $error.Count) {
        Write-Error $url
    }

    $data = $result.value
    $counter = 0
    while ($result.'@odata.nextLink') {
        Write-Progress -Activity "Reading from SharePoint $path" -Status "$counter Items Read" 

        if ($hexatown.verbose) {
            write-output "SharePointRead $($result.'@odata.nextLink')"
        }
        $result = Invoke-RestMethod ($result.'@odata.nextLink') -Method 'GET' -Headers $headers 
        $data += $result.value
        $counter += $result.value.Count
        
    }

    return $data
}



<#
 https://stackoverflow.com/questions/49169917/microsoft-graph-honornonindexedquerieswarningmayfailrandomly-error-when-filterin  
 Prefer: allowthrottleablequeries
#>
function SharePointReadThrottleableQuery  ($hexatown, $path) {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Content-Type", "application/json")
    $headers.Add("Accept", "application/json")
    $headers.Add("Prefer", "allowthrottleablequeries")
    $headers.Add("Authorization", "Bearer $($hexatown.token)" )
    $url = $hexatown.site + $path
    $errorCount = $error.Count
    $result = Invoke-RestMethod ($url) -Method 'GET' -Headers $headers 
    if ($errorCount -ne $error.Count) {
        Write-Error $url
    }

    $data = $result.value
    $counter = 0
    while ($result.'@odata.nextLink') {
        Write-Progress -Activity "Reading from SharePoint $path" -Status "$counter Items Read" 

        if ($hexatown.verbose) {
            write-output "SharePointRead $($result.'@odata.nextLink')"
        }
        $result = Invoke-RestMethod ($result.'@odata.nextLink') -Method 'GET' -Headers $headers 
        $data += $result.value
        $counter += $result.value.Count
        
    }

    return $data
}


function PatchSharePointListItem($token, $site, $listName, $listItemId, $body ) {
    # https://stackoverflow.com/questions/49238355/whats-the-post-body-to-create-multichoice-fields-in-sharepoint-online-using-gra
    $myHeaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $myHeaders.Add("Content-Type", "application/json; charset=utf-8")
    $myHeaders.Add("Accept", "application/json")
    $myHeaders.Add("Authorization", "Bearer $token" )
    $hostName = $env:COMPUTERNAME
    $details = $details -replace """", "\"""
        
    # write-output $body 
    #    Out-File -FilePath "$PSScriptRoot\error.json" -InputObject $body
    $url = ($site + "/Lists/$listName/items/$listItemId")
    # write-output $url
    return Invoke-RestMethod $url -Method 'PATCH' -Headers $myHeaders -Body ([System.Text.Encoding]::UTF8.GetBytes($body) )
    # return $null -eq $dummy
}

function DeleteSharePointListItem($token, $site, $listName, $listItemId ) {
    # https://stackoverflow.com/questions/49238355/whats-the-post-body-to-create-multichoice-fields-in-sharepoint-online-using-gra
    $myHeaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $myHeaders.Add("Content-Type", "application/json")
    $myHeaders.Add("Accept", "application/json")
    $myHeaders.Add("Authorization", "Bearer $token" )
    $hostName = $env:COMPUTERNAME
    $details = $details -replace """", "\"""
        
    # write-output $body 
    #    Out-File -FilePath "$PSScriptRoot\error.json" -InputObject $body
    $url = ($site + "/Lists/$listName/items/$listItemId")
    # write-output $url
    return Invoke-RestMethod $url -Method 'DELETE' -Headers $myHeaders 
    # return $null -eq $dummy
}
       
function PostSharePointListItem($token, $site, $listName, $body ) {
    # https://stackoverflow.com/questions/49238355/whats-the-post-body-to-create-multichoice-fields-in-sharepoint-online-using-gra
    $myHeaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $myHeaders.Add("Content-Type", "application/json; charset=utf-8")
    $myHeaders.Add("Accept", "application/json")
    $myHeaders.Add("Authorization", "Bearer $token" )
    
    $url = ($site + "/Lists/$listName/items")
    $result = Invoke-RestMethod $url -Method 'POST' -Headers $myHeaders -Body ([System.Text.Encoding]::UTF8.GetBytes($body) )
    return $result
    # write-output "."
    # return $null -eq $dummy
}

        
function SharePointLookup($hexatown, $path) {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Content-Type", "application/json")
    $headers.Add("Accept", "application/json")
    $headers.Add("Authorization", "Bearer $($hexatown.token)" )
    $url = $hexatown.site + $path
    if ($hexatown.verbose) {
        write-output "SharePointLookup $url"
    }
    $result = Invoke-RestMethod ($url) -Method 'GET' -Headers $headers 
    return $result

}
function loadFromJSON($directory, $file) {
    
    $data = Get-Content "$directory\$file.json" -Encoding UTF8 | Out-String | ConvertFrom-Json
    if ("System.Object[]" -ne $data.GetType()) {
        $data = @($data)
    }
    
    return $data
}

function downloadLists($hexatown, $schema, $lists) {
    $counter = 0
    
    foreach ($list in $lists) {
        

        Write-Progress -Activity "Downloading  $($lists.Count) list from SharePoint" -Status "$counter Read" -CurrentOperation "Lists $list"
        $listName = $schema | Select -ExpandProperty $list.Name
        $items = (SharePointRead  $hexatown ('/Lists/' + $listName + '/items?$expand=fields'))

        $itemFields = @()

        foreach ($item in $items) {
            if ($item.fields) {
                $itemFields += $item.fields
            }
            # $lookup.Add("$($list.Name):$($item.id)",$item)
        }


        $counter += $items.Count
        ConvertTo-Json -InputObject $itemFields  -Depth 10 | Out-File "$($hexatown.datapath)\$($list.Name).sharepoint.json" 
    }
    Write-Progress -Completed  -Activity "done"
}


function getList($hexatown, $listName) {

    Write-Progress -Activity "Downloading  $listName from SharePoint" 
   
    $items = (SharePointRead  $hexatown ('/Lists/' + $listName + '/items?$expand=fields'))

    $itemFields = @()

    foreach ($item in $items) {
        if ($item.fields) {
            $itemFields += $item.fields
        }
    }

    return $itemFields 
}

function loadLists($hexatown, $schema, $lists) {
    $lookup = @{}
    foreach ($list in $lists) {
        
        $items = loadFromJSON $hexatown.datapath "$($list.Name).sharepoint" 

        write-output "$($list.Name) $($items.Count) items"
        foreach ($item in $items) {
            $lookup.Add("$($list.Name)__$($item.id)", $item)
        }

    }
    return $lookup
}


function Init ($invocation, $requireExchange) {
    $scriptName = $invocation.MyCommand.Name
    $path = Split-Path $invocation.MyCommand.Path
    DotEnvConfigure $false $path

    if ($null -eq $env:DEVELOP) {
        $WarningPreference = 'SilentlyContinue'
        $DebugPreference = 'SilentlyContinue'
        $ProgressPreference = 'SilentlyContinue'
        $VerbosePreference = 'SilentlyContinue'
    }

    $package = loadFromJSON $path "/../../../package"
    $srcPath = (Resolve-Path ($path + "\..\..\..")).Path
    
    
    $environmentPath = $env:HEXATOWNHOME
    if ($null -eq $environmentPath ) {
        $environmentPath = ([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonApplicationData)) 
    }
    

    $homePath = (Resolve-Path ("$environmentPath/hexatown.com/$($package.name)"))

    $PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
   
    $tenantDomain = $ENV:AADDOMAIN
    if ($null -eq $tenantDomain) {
        Write-Error 'Missing domain suffix - is $env:AADDOMAIN defined?'
        exit
    }

    
    EnsurePath "$homePath\logs"

    $logPath = "$homePath\logs\$tenantDomain"
    EnsurePath $logPath

    $metadataPath = "$srcPath\.metadata"
    EnsurePath $metadataPath


    $timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd-hh-mm-ss")
 
    Start-Transcript -Path "$logPath\$scriptName-$timestamp.log" | Out-Null

    EnsurePath "$homePath\data"

    $dataPath = "$homePath\data" #TODO: Make data path tenant aware
    $dataPath = "$datapath\$tenantDomain" #TODO: Make data path tenant aware
    EnsurePath $dataPath


    $Error.Clear() 
 

    $dev = $env:DEBUG
    $token = GetAccessToken $env:APPCLIENT_ID $env:APPCLIENT_SECRET $env:APPCLIENT_DOMAIN
    $site = FindSiteByUrl $token $env:SITEURL
    if ($env:HEXATOWNURL) {
        $hexatownsite = FindSiteByUrl $token $env:HEXATOWNURL
    }
    
    
    if ($null -eq $site) {
        Write-Warning "Not able for find site - is \$env:SITEURL defined?"
        exit
    }


    $schema = loadFromJSON $path ".schema"

    $hexatown = @{
        $logPath     = "$logPath\$tenantDomain"
        domain       = $tenantDomain
        IsDev        = $dev
        site         = $site
        datapath     = $dataPath
        metadatapath = $metadataPath
        logpath      = $logPath
        token        = $token
        verbose      = $env:VERBOSE
        session      = $session
        siteUrl      = $env:SITEURL
        appId        = $env:APPCLIENT_ID
        appSecret    = $env:APPCLIENT_SECRET 
        appDomain    = $env:APPCLIENT_DOMAIN
        hexatown     = $hexatownsite
        schema       = $schema
    }


    if ($requireExchange) {
        $errorCount = (RealErrorCount)
        $session = ConnectExchange $env:AADUSER $env:AADPASSWORD
        if ($errorCount -ne (RealErrorCount)) {
            Write-Warning "Cannot connect to Exchange"
            Done $hexatown
            exit
        }

    }
    return $hexatown

}
    

function Done($hexatown) {

    Write-Progress -Completed  -Activity "done"
    if (!$hexatown.IsDev) {
        write-output "Closing sessions"
        get-pssession | Remove-PSSession
    }

    ReportErrors $hexatown.token $hexatown.site
    Stop-Transcript
}


function ShowState ($text) {
    write-output $text ## for transcript log
    Write-Progress -Activity $text
    
}


function CreateDictionary($hexatown, $dataset, $key) {
    $lookupGroups = @{}

    $indexColumn = "Title"
    if ($null -ne $key) {
        $indexColumn = $key
    
    }
        
    $items = loadFromJSON $hexatown.datapath $dataset


    foreach ($item in $items) {
        if (   $null -ne $item.$indexColumn -and !$lookupGroups.ContainsKey($item.$indexColumn) ) {
            $lookupGroups.Add($item.$indexColumn, $item)
        }
    }

    return $lookupGroups
}

function run($script) {
    write-output "Running $script"
    & "$PSScriptRoot\$script.ps1"
}

function getHash($text) {
    
    $stringAsStream = [System.IO.MemoryStream]::new()
    $writer = [System.IO.StreamWriter]::new($stringAsStream)
    $writer.write($text)
    $writer.Flush()
    $stringAsStream.Position = 0
    return (Get-FileHash -InputStream $stringAsStream | Select-Object Hash).Hash
}


function getReference($dictionary, $key) {
    if ($null -eq $key) {
        return $null
    }
    return $dictionary.$key
}

function loadCrossRef($dataset, $key) {
    if ($null -eq $key) {
        return $null
    }
    return  $dataset.$key
}

function getProperty($bags, $name, $defaultValue) {

    if ($null -eq $bags.$name) {
        if ($null -eq $defaultValue ) {
            Write-Error "Missing property value for $name"
            Done $hexatown
            Exit
        }
        return $defaultValue
    }

    return $bags.$name.Value
   
}



function RemoveUnwantedProperties($item, $wantedFields) {
    $fieldsToKeep = @{}
    foreach ($wantedField in $wantedFields) {
        $fieldsToKeep.Add($wantedField, $wantedField  )
    }

    $fields = $item | Get-Member -MemberType NoteProperty | select Name

    

    foreach ($field in $fields) {
        if (!$fieldsToKeep.ContainsKey($field.Name)) {
            $item.PSObject.Properties.Remove($field.Name)
        }
    }

    return $item
}

function RemoveStandardSharePointProperties($item) {

    $fields = @("@odata.etag", 
        #"id", << This field shall not be removed !        
        "ContentType",
        "Modified",
        "Created",
        "AuthorLookupId",
        "AppAuthorLookupId",
        "EditorLookupId",
        "AppEditorLookupId",
        "_UIVersionString",
        "Attachments",
        "Edit",
        "LinkTitleNoMenu",
        "LinkTitle",
        "ItemChildCount",
        "FolderChildCount",
        "_ComplianceFlags",
        "_ComplianceTag",
        "_ComplianceTagWrittenTime",
        "_ComplianceTagUserId")

    foreach ($field in $fields) {
        $item.PSObject.Properties.Remove($field)
    }
    return $item

}

function CreateSlaveDictionary($hexatown, $dataset, $fields) {
    $lookupGroups = @{}
        
    $items = loadFromJSON $hexatown.datapath $dataset


    foreach ($item in $items) {
        if (   $null -ne $item.Title -and !$lookupGroups.ContainsKey($item.Title) ) {
            $cleanedItem = RemoveUnwantedProperties $item $fields
            $lookupGroups.Add($item.Title, $cleanedItem)
        }
    }

    return $lookupGroups
}

function CreateMasterDictionary($hexatown, $dataset, $fields) {
    $lookupGroups = @{}
        
    $items = loadFromJSON $hexatown.datapath $dataset


    foreach ($item in $items) {
        if (   $null -ne $item.Title -and !$lookupGroups.ContainsKey($item.Title) ) {
            $cleanedItem = RemoveStandardSharePointProperties $item $fields
            # $cleanedItem = RemoveStandardSharePointProperties cleanedItem
            if ($null -ne $item.Title) {
                $lookupGroups.Add($item.Title, $cleanedItem)
            }
        }
    }

    return $lookupGroups
}

function buildDelta($hexatown, $table, $fields) {
    ShowState "Building delta for $table" 
    $masterItems = CreateMasterDictionary $hexatown "$table.sharepoint"
    $slaveItems = CreateSlaveDictionary $hexatown "$table.slave" $fields
    $delta = buildDelta2 $masterItems $slaveItems $fields

    ConvertTo-Json -InputObject $delta  -Depth 10 | Out-File "$($hexatown.datapath)\$table.delta.json" 

}

function buildDelta2($masterItems, $slaveItems, $fields) {
    ShowState "Building delta" 
    

    $delta = @{
        newItems     = @()
        deletedItems = @()
        changedItems = @()
    }

    foreach ($masterItemKey in $masterItems.keys) {
        if (!$slaveItems.containsKey($masterItemKey)) {
            $delta.newItems += RemoveStandardSharePointProperties $masterItems[$masterItemKey]
        }
    }
    
    foreach ($slaveItemKey in $slaveItems.keys) {
        if (!$masterItems.containsKey($slaveItemKey)) {
            $delta.deletedItems += $slaveItems[$slaveItemKey]
        }
    }

    foreach ($masterItemKey in $masterItems.keys) {

        if ($slaveItems.containsKey($masterItemKey)) {
            $masterItem = RemoveStandardSharePointProperties $masterItems[$masterItemKey]
            $slaveItem = $slaveItems[$masterItemKey]

            $changes = @()
            $hasChanges = $false


            foreach ($field in $fields) {
                $masterField = $masterItem.$field | ConvertTo-Json -Depth 10
                $slaveField = $slaveItem.$field | ConvertTo-Json -Depth 10

                if ($masterField -ne $slaveField ) {
                
                    $hasChanges = $true
                    $changes += ${
                    field  = $field
                    master =  $masterField 
                    slave =  $slaveField
                } | ConvertTo-Json
                }
            }


            if ($hasChanges ) {
                           

                $delta.changedItems += @{
                    slave  = $slaveItem
                    master = $masterItem
                }
            }
            
            
        }
    }
 
    

    return $delta

}




function getListCount($hexatown, $listName, $filter) {

    Write-Progress -Activity "Counting $listName from SharePoint" 

    $items = (SharePointReadThrottleableQuery  $hexatown ('/Lists/' + $listName + '/items/?$expand=fields&' + $filter))
    
    return $items.Count
}



function DomainFromEmail($email) {
    if ($null -eq $email) {
        return ""
    }
    $at = $email.indexOf("@");
    if ($at -gt 0) {
        return $email.Substring($at + 1)
    }
    else {
        return ""
    
    }
    
}

function RefreshSharePointList ($hexatown ) {
    $schema = loadFromJSON $PSScriptRoot ".schema"
    $lists = $schema.lists | Get-Member -MemberType  NoteProperty | select Name 

    ShowState "Refreshing copy of SharePoint lists" 
    downloadLists $hexatown $schema.lists  $lists
}

function Initialize-Hexatown-Lists($hexatown) {
    return RefreshSharePointList $hexatown
}


# https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.1 
function Send-Hexatown-Mail($hexatown, $from, $to, $subject, $messageBody) {
    $body = @{
        message = @{
            subject      = $subject
            body         = @{
                contentType = "Text"
                content     = $messageBody
            }
            toRecipients = @(
                @{
                    emailAddress = @{
                        address = $to
                    }
                }
          
            )
        }
    } | ConvertTo-Json -Depth 10
    
    
    GraphAPI $hexatown POST "https://graph.microsoft.com/v1.0/users/$from/sendMail" $body
    
}
    


function Compare-Hexatown-Lists($hexatown, $map) {
    ShowState "Loading Master" | Out-Null
    $masters = CreateDictionary $hexatown "$($map.list).master" 
    ShowState "Loading Slave" | Out-Null
    $slave = CreateDictionary $hexatown "$($map.list).slave" 
        
    $delta = buildDelta2  $slave  $masters $map.fields
        
    return $delta
        
}


function Sync-Hexatown-List($hexatown, $listname, $delta) {
    ShowState "Syncronzing List $listname" | Out-Null
    foreach ($item in $delta.newItems) {
        
        $body = @{fields = $item } | ConvertTo-Json
        DeleteSharePointListItem $hexatown.token $hexatown.site $listname  $item.Id
    }
    
    foreach ($item in $delta.deletedItems) {
        $item.PSObject.Properties.Remove("Id")
        $body = @{fields = $item } | ConvertTo-Json
        PostSharePointListItem $hexatown.token $hexatown.site $listname $body
    }
    
    foreach ($item in $delta.changedItems) {
        $id = $item.master.Id
        $item.slave.PSObject.Properties.Remove("Id")
        $body = @{fields = $item.slave } | ConvertTo-Json
        PatchSharePointListItem $hexatown.token $hexatown.site $listname $id $body
    }
}

function Update-Hexatown-ComparisonSource($hexatown,$map,$source){
$inputData = loadFromJSON $hexatown.datapath $map.$source.file
$sourceMap = $map.$source

$counter = 0
$result = @()
foreach ($input in $inputData) { 
    $percent = [int]($counter / $inputData.Count * 100)
    Write-Progress -Activity "Reading $($sourceMap.file)" -Status "$counter Read" -PercentComplete $percent
        $item = @{}
        $item.Title = $input.($sourceMap.primaryKey)
        $item.Id    = $input.($sourceMap.id)
        
        foreach ($field in $sourceMap.fields) {

        
                $split = $field.from.Split(".")
                if ($split.Count -gt 1){
                $array = @()
                    foreach ($value in $input.($split[0])) {
                        $element = $value.($split[1])
                        $array += $element
                    }

                $item.($field.to) = $array
                }
                else{
                $item.($field.to) = $input.($field.from)
                }
                if ($field.typename){
                    $item.($field.typename) =$field.typevalue
                }
        }
        
        $result +=  $item
        $counter ++
}
ConvertTo-Json -InputObject $result   -Depth 10 | Out-File "$($hexatown.datapath)\$($map.list).$source.json" 

}

    
