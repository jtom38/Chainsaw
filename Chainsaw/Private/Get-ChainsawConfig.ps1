
<#
.Synopsis
This will look at both Script and Global scopes to find the stored configuration.

.Outputs
[HashTable]
#>

function Get-ChainsawConfig {
    param (
        [switch] $Console,
        [switch] $CSV,
        [switch] $Teams
    )

    if($Console){
        [hashtable] $s = $Script:Chainsaw.Console
        [hashtable] $g = $Global:Chainsaw.Console
        
        # Checking Script Scope for values
        if( [string]::IsNullOrEmpty($g.Levels) -eq $false -and
            [string]::IsNullOrEmpty($g.MessageTemplate)-eq $false){
                return $g
        }
        elseif( [string]::IsNullOrEmpty($s.Levels) -eq $false -and
            [string]::IsNullOrEmpty($s.MessageTemplate)-eq $false){
            return $s
        }else{
            [hashtable] $e = $Global:Chainsaw.Console
            $e.Levels = @()
            $e.MessageTemplate = ''
            return $e
        }
    }

    if($CSV){
        [hashtable] $s = $Script:Chainsaw.CSV
        [hashtable] $g = $Global:Chainsaw.CSV

        # Checking Script Scope for values
        if( [string]::IsNullOrEmpty($s.Levels) -eq $false -and
            [string]::IsNullOrEmpty($s.MessageTemplate)-eq $false -and
            [string]::IsNullOrEmpty($s.LogPath) -eq $false){
                return $s
        }
        elseif( [string]::IsNullOrEmpty($g.Levels) -eq $false -and
            [string]::IsNullOrEmpty($g.MessageTemplate)-eq $false -and
            [string]::IsNullOrEmpty($g.LogPath) -eq $false){
            return $g
        }else{
            [hashtable] $e = $Global:Chainsaw.CSV
            $e.Levels = @()
            $e.MessageTemplate = ''
            $e.LogPath = ''
            return $e
        }
    }

    if($Teams){
        [hashtable] $s = $Script:Chainsaw.Teams
        [hashtable] $g = $Global:Chainsaw.Teams

        # Checking Script Scope for values
        if( [string]::IsNullOrEmpty($s.Levels) -eq $false -and
            [string]::IsNullOrEmpty($s.MessageTemplate)-eq $false -and
            [string]::IsNullOrEmpty($s.URI) -eq $false -and
            [string]::IsNullOrEmpty($s.MessageTitle) -eq $false){
                return $s
        }
        elseif( [string]::IsNullOrEmpty($g.Levels) -eq $false -and
            [string]::IsNullOrEmpty($g.MessageTemplate)-eq $false -and
            [string]::IsNullOrEmpty($g.URI) -eq $false -and
            [string]::IsNullOrEmpty($g.MessageTitle) -eq $false){
            return $g
        }else{
            [hashtable] $e = $Global:Chainsaw.Teams
            $e.Levels = @()
            $e.MessageTemplate = ''
            $e.URI = ''
            $e.MessageTitle = ''
            return $e
        }
    }
    
}