BeforeAll { 
    . "$PSScriptRoot\Read.ps1"
}

Describe 'Read' {
    It 'Test Read' {
       # $result = Read
        $result | Should -Be "UNKNOWN"
    }
}


