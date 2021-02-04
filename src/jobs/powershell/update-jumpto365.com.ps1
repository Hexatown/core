. "$PSScriptRoot\.hexatown.com.ps1"                # Load the Hexatown framework
. "$PSScriptRoot\api.ps1"                          # Load the Hexatown framework

$hexatown = Start-Hexatown  $myInvocation          # Start the framework

$webflow = HEXA api webflow login                  # Load API and sign in
$site = HEXA $webflow first sites                  # Set a Site reference

$collections = HEXA $webflow $site list collections # Load all collections 
<#
Each $collections {                                # For Each item in the collection
    write-host $item.name                          # Show the name 
}                                                  # End Each
#> 
$collectionName = "Hexatown Framework Commands"

$collection = $collections |                       # Find a collection 
Where-Object { $_.name -eq  $collectionName }          # named "Hexatown Framework Commands"

$items = HEXA $webflow $collection list items       # Read all items
write-host $items.items.Count "Records"
$items | ConvertTo-Json -Depth 10 | out-file -FilePath (Join-Path "$($hexatown.datapath)" "$collectionName.json")

Stop-Hexatown $hexatown                            # Stop the framework       