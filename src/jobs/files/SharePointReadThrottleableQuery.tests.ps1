BeforeAll { 
    . "$PSScriptRoot\SharePointReadThrottleableQuery.ps1"
}

Describe 'SharePointReadThrottleableQuery' {
    It 'Test SharePointReadThrottleableQuery' {
       # $result = SharePointReadThrottleableQuery
        $result | Should -Be "UNKNOWN"
    }
}


