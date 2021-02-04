function psEdit (){
param([Parameter(Mandatory=$true)]$filenames)

    foreach ($filename in $filenames)
    {
        dir $filename | where {!$_.PSIsContainer} | %{
            $psISE.CurrentPowerShellTab.Files.Add($_.FullName) > $null
        }
    }

}
