. "$PSScriptRoot\.hexatown.com.ps1"

$context = Init $MyInvocation  $false

RefreshSharePointList $context

Done $context