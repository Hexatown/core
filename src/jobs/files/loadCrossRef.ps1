function loadCrossRef {
param($dataset, $key)

    if ($null -eq $key) {
        return $null
    }
    return  $dataset.$key

}
