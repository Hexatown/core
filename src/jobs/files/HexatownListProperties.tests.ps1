BeforeAll { 
    . "$PSScriptRoot\HexatownListProperties.ps1"
}

Describe 'HexatownListProperties' {
    It 'Test HexatownListProperties' {
       # $result = HexatownListProperties
        $result | Should -Be "UNKNOWN"
    }
}


