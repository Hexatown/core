BeforeAll { 
    . "$PSScriptRoot\Init.ps1"
}

Describe 'Init' {
    It 'Test Init' {
       # $result = Init
        $result | Should -Be "UNKNOWN"
    }
}


