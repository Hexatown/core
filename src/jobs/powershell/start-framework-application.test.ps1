. "$PSScriptRoot\.hexatown.com.ps1"
## *************************************************
## Start Framework in a Application Context
## *************************************************
$hexatown = Start-HexatownApp $MyInvocation 


Stop-Hexatown $hexatown