BeforeAll { 
    . "$PSScriptRoot\GraphAPIAll.ps1"
}

Describe 'GraphAPIAll' {
    It 'Test GraphAPIAll' {
       # $result = GraphAPIAll
        $result | Should -Be "UNKNOWN"
    }
}


