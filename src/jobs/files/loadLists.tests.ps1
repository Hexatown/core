BeforeAll { 
    . "$PSScriptRoot\loadLists.ps1"
}

Describe 'loadLists' {
    It 'Test loadLists' {
       # $result = loadLists
        $result | Should -Be "UNKNOWN"
    }
}


