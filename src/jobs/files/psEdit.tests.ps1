BeforeAll { 
    . "$PSScriptRoot\psEdit.ps1"
}

Describe 'psEdit' {
    It 'Test psEdit' {
       # $result = psEdit
        $result | Should -Be "UNKNOWN"
    }
}


