BeforeAll { 
    . "$PSScriptRoot\HexatownListLog.ps1"
}

Describe 'HexatownListLog' {
    It 'Test HexatownListLog' {
       # $result = HexatownListLog
        $result | Should -Be "UNKNOWN"
    }
}


