BeforeAll { 
    . "$PSScriptRoot\GraphAPI.ps1"
}

Describe 'GraphAPI' {
    It 'Test GraphAPI' {
       # $result = GraphAPI
        $result | Should -Be "UNKNOWN"
    }
}


