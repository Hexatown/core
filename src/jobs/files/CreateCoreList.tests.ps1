BeforeAll { 
    . "$PSScriptRoot\CreateCoreList.ps1"
}

Describe 'CreateCoreList' {
    It 'Test CreateCoreList' {
       # $result = CreateCoreList
        $result | Should -Be "UNKNOWN"
    }
}


