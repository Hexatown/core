BeforeAll { 
    . "$PSScriptRoot\Get-Verb.ps1"
}

Describe 'Get-Verb' {
    It 'Test Get-Verb' {
       # $result = Get-Verb
        $result | Should -Be "UNKNOWN"
    }
}


