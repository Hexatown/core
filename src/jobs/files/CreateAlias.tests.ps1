BeforeAll { 
    . "$PSScriptRoot\CreateAlias.ps1"
}

Describe 'CreateAlias' {
    It 'Test CreateAlias' {
       # $result = CreateAlias
        $result | Should -Be "UNKNOWN"
    }
}


