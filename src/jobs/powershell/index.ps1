. "$PSScriptRoot\.hexatown.com.ps1"

## *************************************************
## Start Framework in a Delegated Context
## *************************************************
$hexatown = Start-Hexatown $MyInvocation 


Stop-Hexatown $hexatown


## *************************************************
## Start Framework in a Application Context
## *************************************************
$hexatown = Start-Hexatown $MyInvocation 


Stop-Hexatown $hexatown