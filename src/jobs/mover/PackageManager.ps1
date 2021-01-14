. "$PSScriptRoot\.hexatown.com.ps1"
$config = loadFromJSON $PSScriptRoot "/../../../.hexatown.com"
if (!$config.master) {
    return
}

$root = "$PSScriptRoot /../../../.."

write-host "Hexatown Mover "
write-host "------------------------------------------"


function PushHelperFileChanges() {
    $projects = get-childitem -Path $root -Directory

    $master = Get-Content "$PSScriptRoot\.hexatown.com.ps1" 

    foreach ($project in $projects) {

        $projectroot = $project.FullName
        $projectfile = "$projectroot"
        if (Test-Path "$projectfile/package.json") {
        
            $projectconfig = loadFromJSON $projectfile "package"
            if (!$projectconfig.hexatown.isMaster) {
             

                $helpers = Get-ChildItem -Path "$($project.FullName)/*.ps1"  -Recurse | Where-Object Name -eq ".hexatown.com.ps1" 
                foreach ($helper in $helpers) {
                
                    $slave = Get-Content $helper.VersionInfo.FileName 
                
                    $diff = Compare-Object -ReferenceObject $master -DifferenceObject $slave

                    if ($null -ne $diff) {
                        write-host "Updating $($projectconfig.name)  $($projectconfig.version) $($helper.VersionInfo.FileName) "
                        Out-File $helper.VersionInfo.FileName -InputObject $master 
                    }

             
                }

            }
        }
    }
}


PushHelperFileChanges