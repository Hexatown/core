BeforeAll { 
    . "$PSScriptRoot\GetSharePointListItem.ps1"
}

Describe 'GetSharePointListItem' {
    It 'Test GetSharePointListItem' {
       # $result = GetSharePointListItem
        $result | Should -Be "UNKNOWN"
    }
}


