BeforeAll { 
    . "$PSScriptRoot\GetPayload.ps1"
}

Describe 'GetPayload' {
    It 'Test GetPayload' {
       # $result = GetPayload
        $result | Should -Be "UNKNOWN"
    }
}


