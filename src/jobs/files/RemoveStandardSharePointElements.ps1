function RemoveStandardSharePointElements {
param($fields)


$standardSharePointFields = @("@odata.etag", 
        "id",
        "Title",
        "ContentType",
        "Modified",
        "Created",
        "_UIVersionString",
        "Attachments",
        "Edit",
        "LinkTitleNoMenu",
        "LinkTitle",
        "ItemChildCount",
        "FolderChildCount",
        "contentType",
        "modified",
        "created",
         "Title",
        "Author",
        "AppAuthor",
        "Editor",
        "AppEditor",
        "_UIVersionString",
        "attachments",
        "edit",
        "linkTitleNoMenu",
        "linkTitle",
        "itemChildCount",
        "folderChildCount",
        "ComplianceAssetId"
        "_ComplianceFlags",
        "_ComplianceTag",
        "_ComplianceTagWrittenTime",
        "_ComplianceTagUserId",
        "DocIcon",
        "_IsRecord")
    $newFields = @()    
    foreach ($field in $fields)
    {
        $remove = $false
        foreach ($standardSharePointField in $standardSharePointFields) {
            if ($field.name -eq $standardSharePointField){
                $remove = $true
            }
        }
        if (!$remove){
        $newFields += $field
}
    }
    return $newFields


}
