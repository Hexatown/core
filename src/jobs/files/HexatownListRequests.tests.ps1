BeforeAll { 
    . "$PSScriptRoot\HexatownListRequests.ps1"
}

Describe 'HexatownListRequests' {
    It 'Test HexatownListRequests' {
       # $result = HexatownListRequests
        $result | Should -Be "UNKNOWN"
    }
}


