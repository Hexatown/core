function more {

param([string[]]$paths)
$OutputEncoding = [System.Console]::OutputEncoding
if($paths) {
    foreach ($file in $paths)
    {
        Get-Content $file | more.com
    }
} else { $input | more.com }

}
