BeforeAll { 
    . "$PSScriptRoot\getHash.ps1"
}

Describe 'getHash' {
    It 'Test getHash' {
       # $result = getHash
        $result | Should -Be "UNKNOWN"
    }
}


