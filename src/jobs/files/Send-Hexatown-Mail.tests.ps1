BeforeAll { 
    . "$PSScriptRoot\Send-Hexatown-Mail.ps1"
}

Describe 'Send-Hexatown-Mail' {
    It 'Test Send-Hexatown-Mail' {
       # $result = Send-Hexatown-Mail
        $result | Should -Be "UNKNOWN"
    }
}


