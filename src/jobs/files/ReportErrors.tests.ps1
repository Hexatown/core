BeforeAll { 
    . "$PSScriptRoot\ReportErrors.ps1"
}

Describe 'ReportErrors' {
    It 'Test ReportErrors' {
       # $result = ReportErrors
        $result | Should -Be "UNKNOWN"
    }
}


