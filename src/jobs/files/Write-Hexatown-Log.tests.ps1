BeforeAll { 
    . "$PSScriptRoot\Write-Hexatown-Log.ps1"
}

Describe 'Write-Hexatown-Log' {
    It 'Test Write-Hexatown-Log' {
       # $result = Write-Hexatown-Log
        $result | Should -Be "UNKNOWN"
    }
}


