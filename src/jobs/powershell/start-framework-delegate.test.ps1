. "$PSScriptRoot\.hexatown.com.ps1"

## *************************************************
## Start Framework in a Delegated Context
## *************************************************
$hexatown = Start-Hexatown $MyInvocation "Team.ReadBasic.All Calendars.Read "
write-host ""
write-host "Calendars"
GraphAPIAll $hexatown get "https://graph.microsoft.com/v1.0/me/calendars" | select name | write-host
write-host ""
Stop-Hexatown $hexatown


