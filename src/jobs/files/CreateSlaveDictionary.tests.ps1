BeforeAll { 
    . "$PSScriptRoot\CreateSlaveDictionary.ps1"
}

Describe 'CreateSlaveDictionary' {
    It 'Test CreateSlaveDictionary' {
       # $result = CreateSlaveDictionary
        $result | Should -Be "UNKNOWN"
    }
}


