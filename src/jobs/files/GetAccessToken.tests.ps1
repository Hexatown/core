BeforeAll { 
    . "$PSScriptRoot\GetAccessToken.ps1"
}

Describe 'GetAccessToken' {
    It 'Test GetAccessToken' {
       # $result = GetAccessToken
        $result | Should -Be "UNKNOWN"
    }
}


