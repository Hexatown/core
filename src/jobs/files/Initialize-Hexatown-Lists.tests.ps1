BeforeAll { 
    . "$PSScriptRoot\Initialize-Hexatown-Lists.ps1"
}

Describe 'Initialize-Hexatown-Lists' {
    It 'Test Initialize-Hexatown-Lists' {
       # $result = Initialize-Hexatown-Lists
        $result | Should -Be "UNKNOWN"
    }
}


