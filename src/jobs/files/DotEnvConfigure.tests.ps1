BeforeAll { 
    . "$PSScriptRoot\DotEnvConfigure.ps1"
}

Describe 'DotEnvConfigure' {
    It 'Test DotEnvConfigure' {
       # $result = DotEnvConfigure
        $result | Should -Be "UNKNOWN"
    }
}


