BeforeAll { 
    . "$PSScriptRoot\loadFromJSON.ps1"
}

Describe 'loadFromJSON' {
    It 'Test loadFromJSON' {
       # $result = loadFromJSON
        $result | Should -Be "UNKNOWN"
    }
}


