function CreateCoreList {
param($hexatown, $siteUrl, $definition)


    GraphAPI $hexatown POST "$siteUrl/lists" $definition
    


}
