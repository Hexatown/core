. "$PSScriptRoot\.hexatown.com.ps1"
. "$PSScriptRoot\..\..\connectors\MarkdownToHTML\index.ps1"
. "$PSScriptRoot\..\..\connectors\platyPS\index.ps1"

$docPath = Join-Path $PSScriptRoot "../../../docs"
$filePath = Join-Path $PSScriptRoot "../files"
If (!(test-path $filePath)) {
        New-Item -ItemType Directory -Force -Path $filePath
}




$functions = Get-Command -CommandType Function | where {$_.version -eq $null -and !$_.name.EndsWith(":") -and !$_.name.EndsWith("cd\") -and !$_.name.EndsWith("cd..") -and !$_.name.EndsWith("cd..tests")} 

foreach ($function in $functions)
{

New-MarkdownHelp -Command $function -OutputFolder $docPath
   
$functionCode = @"
function $($function.name) {
$($function.Definition)
}
"@

$testCode = @"
BeforeAll { 
    . `"`$PSScriptRoot\$($function.name).ps1`"
}

Describe '$($function.name)' {
    It 'Test $($function.name)' {
       # `$result = $($function.name)
        `$result | Should -Be `"UNKNOWN`"
    }
}


"@

#if (!(test-path (Join-Path $filePath "$($function.name).ps1" ) )){
    out-file (Join-Path $filePath "$($function.name).ps1" ) -InputObject $functionCode
#}
if (!(test-path (Join-Path $filePath "$($function.name).tests.ps1" ) )){
    out-file (Join-Path $filePath "$($function.name).tests.ps1" ) -InputObject $testCode
}
   
}

