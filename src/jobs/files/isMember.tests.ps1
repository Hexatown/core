BeforeAll { 
    . "$PSScriptRoot\isMember.ps1"
}

Describe 'isMember' {
    It 'Test isMember' {
       # $result = isMember
        $result | Should -Be "UNKNOWN"
    }
}


