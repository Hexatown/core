BeforeAll { 
    . "$PSScriptRoot\more.ps1"
}

Describe 'more' {
    It 'Test more' {
       # $result = more
        $result | Should -Be "UNKNOWN"
    }
}


