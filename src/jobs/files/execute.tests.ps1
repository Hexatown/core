BeforeAll { 
    . "$PSScriptRoot\execute.ps1"
}

Describe 'execute' {
    It 'Test execute' {
       # $result = execute
        $result | Should -Be "UNKNOWN"
    }
}


