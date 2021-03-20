function Create {
param($hexatown, $apiName, $method, $body)

    $api = $hexatown.apis.$apiName.$method
    return GraphAPI $hexatown "POST" $api.url $body

}
