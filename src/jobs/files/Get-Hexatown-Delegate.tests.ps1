BeforeAll { 
    . "$PSScriptRoot\Get-Hexatown-Delegate.ps1"
}

Describe 'Get-Hexatown-Delegate' {
    It 'Test Get-Hexatown-Delegate' {
       # $result = Get-Hexatown-Delegate
        $result | Should -Be "UNKNOWN"
    }
}


