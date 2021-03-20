function List {
param($hexatown, $apiName, $method, $order, $property)

    $api = $hexatown.apis.$apiName.$method
    if ($null -ne $order){
        return GraphAPIAll $hexatown "GET" $api.url | Sort-Object -Property $property
    }else
    {
        return GraphAPIAll $hexatown "GET" $api.url
    }
    

}
