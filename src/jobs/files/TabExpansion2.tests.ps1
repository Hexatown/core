BeforeAll { 
    . "$PSScriptRoot\TabExpansion2.ps1"
}

Describe 'TabExpansion2' {
    It 'Test TabExpansion2' {
       # $result = TabExpansion2
        $result | Should -Be "UNKNOWN"
    }
}


