BeforeAll { 
    . "$PSScriptRoot\List.ps1"
}

Describe 'List' {
    It 'Test List' {
       # $result = List
        $result | Should -Be "UNKNOWN"
    }
}


