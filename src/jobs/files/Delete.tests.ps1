BeforeAll { 
    . "$PSScriptRoot\Delete.ps1"
}

Describe 'Delete' {
    It 'Test Delete' {
       # $result = Delete
        $result | Should -Be "UNKNOWN"
    }
}


