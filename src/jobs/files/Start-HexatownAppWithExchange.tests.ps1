BeforeAll { 
    . "$PSScriptRoot\Start-HexatownAppWithExchange.ps1"
}

Describe 'Start-HexatownAppWithExchange' {
    It 'Test Start-HexatownAppWithExchange' {
       # $result = Start-HexatownAppWithExchange
        $result | Should -Be "UNKNOWN"
    }
}


