BeforeAll { 
    . "$PSScriptRoot\Done.ps1"
}

Describe 'Done' {
    It 'Test Done' {
       # $result = Done
        $result | Should -Be "UNKNOWN"
    }
}


