BeforeAll { 
    . "$PSScriptRoot\Stop-Hexatown.ps1"
}

Describe 'Stop-Hexatown' {
    It 'Test Stop-Hexatown' {
       # $result = Stop-Hexatown
        $result | Should -Be "UNKNOWN"
    }
}


