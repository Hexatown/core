function Update {
param($hexatown, $apiName, $method, $id, $body)

    $api = $hexatown.apis.$apiName.$method
    return GraphAPI $hexatown "PATCH" $api.url $id $body

}
