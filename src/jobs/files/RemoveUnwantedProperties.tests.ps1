BeforeAll { 
    . "$PSScriptRoot\RemoveUnwantedProperties.ps1"
}

Describe 'RemoveUnwantedProperties' {
    It 'Test RemoveUnwantedProperties' {
       # $result = RemoveUnwantedProperties
        $result | Should -Be "UNKNOWN"
    }
}


