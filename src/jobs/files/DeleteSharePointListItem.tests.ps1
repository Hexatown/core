BeforeAll { 
    . "$PSScriptRoot\DeleteSharePointListItem.ps1"
}

Describe 'DeleteSharePointListItem' {
    It 'Test DeleteSharePointListItem' {
       # $result = DeleteSharePointListItem
        $result | Should -Be "UNKNOWN"
    }
}


