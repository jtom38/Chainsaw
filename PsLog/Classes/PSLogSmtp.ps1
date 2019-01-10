
class PSLogSmtp {
    
    PSLogSmtp() {

    }

    PSLogSmtp([string[]] $Levels, [string] $Server, [int] $Port, [bool] $Security) {
        $this.Levels = $Levels
        $this.Server = $Server
        $this.Port = $Port
        $this.Security = $Security
    }

    PSLogSmtp([string[]] $Levels, [string] $Server, [int] $Port, [bool] $Security, [string] $Username, [string] $Password) {
        $this.Levels = $Levels
        $this.Server = $Server
        $this.Port = $Port
        $this.Security = $Security
        $this.Username = $Username
        $this.Password = $Password

        $client = $this.BuildSmtpClient()        
    }

    [string[]] $Levels
    [string] $Server
    [int] $Port
    [bool] $Security

    [string] $Username
    [string] $Password

    [bool] _isValidEndPoint() {

        if ( [System.String]::IsNullOrEmpty($this.Server) -eq $false -and 
             [System.String]::IsNullOrEmpty($this.Port) -eq $false ) {
            return $true
        }

        return $false
    }

    # This is a generic class we will use to write the CSV Log
    [void] Write( [string] $Level, [string] $Message) {
        if ( $this._IsMessageValid($Level) -eq $false) {
            continue
        }

        $client = $this.BuildSmtpClient()


    }

    [MailKit.Net.Smtp.SmtpClient] BuildSmtpClient() {
        $client = [MailKit.Net.Smtp.SmtpClient]::new()
        $client.Connect($this.Server, $this.Port, $true)

        if ( $client.IsConnected -eq $true ) {
            return $client
        }
        else {
            throw "Unable to connect to SMTP server"
            return $null
        }
    }

    [void] BuildMessage() {
        

    }
}