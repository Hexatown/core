function LogChange {
param($hexatown, $title, $area, $method, $reference)

    LogToSharePoint $hexatown.token $hexatown.site $title "OK" $area $method $reference 0 "."

}
