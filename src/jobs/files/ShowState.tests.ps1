BeforeAll { 
    . "$PSScriptRoot\ShowState.ps1"
}

Describe 'ShowState' {
    It 'Test ShowState' {
       # $result = ShowState
        $result | Should -Be "UNKNOWN"
    }
}


