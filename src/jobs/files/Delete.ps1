function Delete {
param($hexatown, $apiName, $method, $id)

    $api = $hexatown.apis.$apiName.$method
    return GraphAPI $hexatown "DELETE" $api.url $id 

}
