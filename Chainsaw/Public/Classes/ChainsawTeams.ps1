

class ChainsawTeams {
    
    ChainsawTeams(){

    }

    ChainsawTeams([string] $URI, [string] $MessageTemplate, [string] $MessageTitle, [string[]] $Levels){
        $this.Levels = $Levels
        $this.URI = $URI
        $this.MessageTemplate = $MessageTemplate
        $this.MessageTitle = $MessageTitle
    }

    ChainsawTeams([string] $PathConfig){  
        $json = Get-Content -Path $PathConfig | ConvertFrom-Json

        $this.Levels = $json.Chainsaw.Teams.Levels
        $this.URI = $json.Chainsaw.Teams.URI
        $this.MessageTemplate = $json.Chainsaw.Teams.MessageTemplate
        $this.MessageTitle = $json.Chainsaw.Teams.MessageTitle
    }

    [string[]] $Levels
    [string] $URI
    [string] $MessageTemplate
    [string] $MessageTitle

    hidden [bool] _isValidEndPoint(){
        if( [System.String]::IsNullOrEmpty($this.URI) -eq $false -and
            [System.String]::IsNullOrEmpty($this.MessageTitle) -eq $false -and
            [System.String]::IsNullOrEmpty($this.MessageSubtitle) -eq $false ){
                return $true
        }
        return $false
    }

    [void] Write([string] $Level, [string] $Message){
        $convert = [TemplateConverter]::new($this.MessageTemplate)
        [string] $sum = $convert.ConvertToMessageTemplate($Level, $Message)
        $this.SendMessage($sum)
    }

    [void] Write([string] $Level, [string] $Message, [int] $ErrorCode){
        $convert = [TemplateConverter]::new($this.MessageTemplate)
        [string] $sum = $convert.ConvertToMessageTemplate($Level, $Message, $ErrorCode)
        $this.SendMessage($sum)
    }

    [void] Write([string] $Level, [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $LineNumber){
        $convert = [TemplateConverter]::new($this.MessageTemplate)
        [string] $sum = $convert.ConvertToMessageTemplate($Level, $Message, $ErrorCode, $CallingFile, $LineNumber)
        $this.SendMessage($sum)
    }

    hidden [void] SendMessage([string] $MessageSummary){
        Send-TeamsMessage `
            -URI $this.URI `
            -MessageTitle $this.MessageTitle `
            -MessageSummary $MessageSummary
    }

}