BeforeAll { 
    . "$PSScriptRoot\Serve.ps1"
}

Describe 'Serve' {
    It 'Test Serve' {
       # $result = Serve
        $result | Should -Be "UNKNOWN"
    }
}


