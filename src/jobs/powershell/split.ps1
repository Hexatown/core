. "$PSScriptRoot\.hexatown.com.ps1"

$filePath = Join-Path $PSScriptRoot "../files"
If (!(test-path $filePath)) {
        New-Item -ItemType Directory -Force -Path $filePath
}




$functions = Get-Command –CommandType Function | where {$_.version -eq $null -and !$_.name.EndsWith(":") -and !$_.name.EndsWith("cd\") -and !$_.name.EndsWith("cd..") -and !$_.name.EndsWith("cd..tests")} 

foreach ($function in $functions)
{

New-MarkdownHelp -Command $function -OutputFolder $filePath
   
$functionCode = @"
function $($function.name) (){
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

   out-file (Join-Path $filePath "$($function.name).ps1" ) -InputObject $functionCode
   out-file (Join-Path $filePath "$($function.name).tests.ps1" ) -InputObject $testCode
}

