BeforeAll { 
    . "$PSScriptRoot\Start-Hexatown.ps1"
}

Describe 'Start-Hexatown' {
    It 'Test Start-Hexatown' {
       # $result = Start-Hexatown
        $result | Should -Be "UNKNOWN"
    }
}


