$installPath = Join-Path $PSScriptRoot "modules"
if (!(Test-Path ($installPath)) ){
    New-Item -ItemType Directory -Force -Path $installPath
}

# Save-Module -Name Pester   -Path $installPath 
#Save-Module -Name platyPS   -Path $installPath 
Save-Module -Name MarkdownToHTML   -Path $installPath 

