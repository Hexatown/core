BeforeAll { 
    . "$PSScriptRoot\LogChange.ps1"
}

Describe 'LogChange' {
    It 'Test LogChange' {
       # $result = LogChange
        $result | Should -Be "UNKNOWN"
    }
}


