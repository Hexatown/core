BeforeAll { 
    . "$PSScriptRoot\run.ps1"
}

Describe 'run' {
    It 'Test run' {
       # $result = run
        $result | Should -Be "UNKNOWN"
    }
}


