$installPath = Join-Path $PSScriptRoot "modules"

Import-Module -Name "$installPath\Pester" -DisableNameChecking
Import-Module -Name "$installPath\platyPS" -DisableNameChecking
