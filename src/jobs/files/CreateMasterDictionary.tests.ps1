BeforeAll { 
    . "$PSScriptRoot\CreateMasterDictionary.ps1"
}

Describe 'CreateMasterDictionary' {
    It 'Test CreateMasterDictionary' {
       # $result = CreateMasterDictionary
        $result | Should -Be "UNKNOWN"
    }
}


