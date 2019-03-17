

function Enable-ChainsawSMTP {
    param (
        [pscredential] $Credentials,
        [string] $Server,
        [int] $Port,
        [string] $From,
        [string[]] $To,
        [string[]] $CC,
        [string[]] $BCC,
        [string] $Subject,
        [string[]] $Levels,

        [switch] $ScopeGlobal,

        [string] $JsonConfig
    )
 
    if( $Credentials -ne $null){
        [System.Net.NetworkCredential] $c = $Credentials.GetNetworkCredential()
        if ([string]::IsNullOrEmpty($c.UserName) -eq $false){
            $Script:Chainsaw.SMTP.Credentials.UserName = $c.UserName
        }
        if ([string]::IsNullOrEmpty($c.SecurePassword) -eq $false){
            $Script:Chainsaw.SMTP.Credentials.Password = $c.SecurePassword
        }
        if ([string]::IsNullOrEmpty($c.Domain) -eq $false){
            $Script:Chainsaw.SMTP.Credentials.Domain = $c.Domain
        }
    }
    if ([string]::IsNullOrEmpty($Server) -eq $false){
        $Script:Chainsaw.SMTP.Server = $Server
    }
    if( $Port -ge 1){
        $Script:Chainsaw.SMTP.Port = $Port
    }
    if ([string]::IsNullOrEmpty($From) -eq $false){
        $Script:Chainsaw.SMTP.From = $From
    }
    if ([string]::IsNullOrEmpty($To) -eq $false){
        $Script:Chainsaw.SMTP.To = $To
    }
    if ([string]::IsNullOrEmpty($CC) -eq $false){
        $Script:Chainsaw.SMTP.CC = $CC
    }
    if ([string]::IsNullOrEmpty($BCC) -eq $false){
        $Script:Chainsaw.SMTP.BCC = $BCC
    }
    if ([string]::IsNullOrEmpty($Subject) -eq $false){
        $Script:Chainsaw.SMTP.$Subject = $Subject
    }
    if ([string]::IsNullOrEmpty($Levels) -eq $false){
        $Script:Chainsaw.SMTP.$Levels = $Levels
    }

}