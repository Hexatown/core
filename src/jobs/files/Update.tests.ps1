BeforeAll { 
    . "$PSScriptRoot\Update.ps1"
}

Describe 'Update' {
    It 'Test Update' {
       # $result = Update
        $result | Should -Be "UNKNOWN"
    }
}


