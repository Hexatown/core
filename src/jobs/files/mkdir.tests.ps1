BeforeAll { 
    . "$PSScriptRoot\mkdir.ps1"
}

Describe 'mkdir' {
    It 'Test mkdir' {
       # $result = mkdir
        $result | Should -Be "UNKNOWN"
    }
}


