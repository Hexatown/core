BeforeAll { 
    . "$PSScriptRoot\oss.ps1"
}

Describe 'oss' {
    It 'Test oss' {
       # $result = oss
        $result | Should -Be "UNKNOWN"
    }
}


