BeforeAll { 
    . "$PSScriptRoot\downloadLists.ps1"
}

Describe 'downloadLists' {
    It 'Test downloadLists' {
       # $result = downloadLists
        $result | Should -Be "UNKNOWN"
    }
}


