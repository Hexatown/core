BeforeAll { 
    . "$PSScriptRoot\RemoveStandardSharePointElements.ps1"
}

Describe 'RemoveStandardSharePointElements' {
    It 'Test RemoveStandardSharePointElements' {
       # $result = RemoveStandardSharePointElements
        $result | Should -Be "UNKNOWN"
    }
}


