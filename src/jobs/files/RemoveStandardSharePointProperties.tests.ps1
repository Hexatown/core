BeforeAll { 
    . "$PSScriptRoot\RemoveStandardSharePointProperties.ps1"
}

Describe 'RemoveStandardSharePointProperties' {
    It 'Test RemoveStandardSharePointProperties' {
       # $result = RemoveStandardSharePointProperties
        $result | Should -Be "UNKNOWN"
    }
}


