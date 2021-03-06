function RemoveStandardSharePointProperties {
param($item)

    $standardSharePointFields = @("@odata.etag", 
        #"id", << This field shall not be removed !        
        "ContentType",
        "Modified",
        "Created",
        "AuthorLookupId",
        "AppAuthorLookupId",
        "EditorLookupId",
        "AppEditorLookupId",
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
        "authorLookupId",
        "appAuthorLookupId",
        "editorLookupId",
        "appEditorLookupId",
        "_UIVersionString",
        "attachments",
        "edit",
        "linkTitleNoMenu",
        "linkTitle",
        "itemChildCount",
        "folderChildCount",

        "_ComplianceFlags",
        "_ComplianceTag",
        "_ComplianceTagWrittenTime",
        "_ComplianceTagUserId")


    foreach ($field in $standardSharePointFields) {
        $item.PSObject.Properties.Remove($field)
    }
    return $item


}
