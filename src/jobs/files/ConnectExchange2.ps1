function ConnectExchange2 {
param($appid, $token, $ignoreErrors)


    
    
    if ($env:EXCHCERTIFICATEPATH -eq ""){
       FatalError 'Missing $env:EXCHCERTIFICATEPATH'
    }
    if ($env:EXCHCERTIFICATEPASSWORD -eq ""){
       FatalError 'Missing $env:EXCHCERTIFICATEPASSWORD'
    }
    if ($env:EXCHORGANIZATION -eq ""){
       FatalError 'Missing $env:EXCHORGANIZATION'
    }
    if ($env:EXCHAPPID -eq ""){
       FatalError 'Missing $env:EXCHAPPID'
    }

    $errorAction =[System.Management.Automation.ActionPreference]::Continue
    if ($ignoreErrors){
        $errorAction =[System.Management.Automation.ActionPreference]::SilentlyContinue
    }

    
    $Session = Connect-ExchangeOnline -CertificateFilePath $env:EXCHCERTIFICATEPATH -CertificatePassword (ConvertTo-SecureString -String $env:EXCHCERTIFICATEPASSWORD -AsPlainText -Force) -AppID $env:EXCHAPPID -Organization $env:EXCHORGANIZATION -ShowBanner:$false   -ErrorAction SilentlyContinue # $errorAction
    

    return $Session
    

}
