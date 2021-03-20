function RefreshSharePointList {
param($hexatown)

    $schema = loadFromJSON $PSScriptRoot ".schema"
    $lists = $schema.lists | Get-Member -MemberType  NoteProperty | select Name 

    ShowState "Refreshing copy of SharePoint lists" 
    downloadLists $hexatown $schema.lists  $lists

}
