. "$PSScriptRoot\.hexatown.com.ps1"

## *************************************************
## Start Framework in a Application Context with Exchange
## *************************************************
$hexatown = Start-HexatownAppWithExchange $MyInvocation 


Stop-Hexatown $hexatown