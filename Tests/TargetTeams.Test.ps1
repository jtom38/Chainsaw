
param(
    [string] $TeamsURL
)

Describe "EndPoint: Teams Config"{
    it "Should have a blank config"{
        [hashtable] $h = $Global:Chainsaw.Teams
        [bool] $r = $false

        if([string]::IsNullOrEmpty($h.URI) -eq $false -and 
            [string]::IsNullOrEmpty($h.Levels) -eq $false -and 
            [string]::IsNullOrEmpty($h.MessageTitle) -eq $false){
                $r = $true
        }
        $r | should -Be $true
    }

    it "Should update Teams.Levels"{
        Enable-ChainsawTeams -Levels @("Debug") -ScopeGlobal
        [hashtable] $h = $Global:Chainsaw.Teams
        [bool] $r = $false
        if([string]::IsNullOrEmpty($h.Levels) -eq $false){
            $r = $true
        }
        $Global:Chainsaw.Teams.Levels = @()
        $r | Should -Be $true

    }

    it "should update Teams.URI"{
        Enable-ChainsawTeams -URI "notanullstring" -ScopeGlobal
        [hashtable] $h = $Global:Chainsaw.Teams

        [bool] $r = $false
        if([string]::IsNullOrEmpty($h.URI) -eq $false){
            $r = $true
        }

        $Global:Chainsaw.Teams.URI = ""
        $r | Should -Be $true
    }

    it "should update Teams.MessageTitle"{
        Enable-ChainsawTeams -MessageTitle "Pestering" -ScopeGlobal
        [hashtable] $h = $Global:Chainsaw.Teams

        [bool] $r = $false
        if([string]::IsNullOrEmpty($h.MessageTitle) -eq $false){
            $r = $true
        }

        $Global:Chainsaw.Teams.MessageTemplate = ""
        $r | Should -Be $true
    }

    it "should update Teams.URI"{
        Enable-ChainsawTeams `
            -URI "notanullstring" `
            -Levels @("Deubg") `
            -MessageTitle "Pest" `
            -ScopeGlobal
        [hashtable] $h = $Global:Chainsaw.Teams

        [bool] $r = $false
        if([string]::IsNullOrEmpty($h.URI) -eq $false -and
            [string]::IsNullOrEmpty($h.MessageTitle) -eq $false -and 
            [string]::IsNullOrEmpty($h.Levels) -eq $false){
            $r = $true
        }

        $Global:Chainsaw.Teams.URI = ""
        $Global:Chainsaw.Teams.MessageTemplate = ""
        $Global:Chainsaw.Teams.Levels = @()
        $r | Should -Be $true
    }
}

Describe "Endpoint: Teams Config Export"{
    it "Should export Teams.Levels"{
        [string] $json = '.\PesterTeams.json'

        $Levels = @(
            'Emergency',
            'Alert',
            'Critical',
            'Error',
            'Warning',
            'Notice',
            'Info',
            'Debug'
        )

        Enable-ChainsawTeams -Levels $Levels -ScopeGlobal
        [bool] $r = $false

        try{
            Export-ChainsawConfig -JsonPath $json -ScopeGlobal
            $r = $true
        }catch{

        }

        $Global:Chainsaw.Teams.Levels = @()
        Remove-Item -Path $json

        $r | Should -Be $true
    }

    it "Should export Teams.URI"{
        [string] $json = '.\PesterTeams.json'

        $URI = 'value'

        Enable-ChainsawTeams -URI $URI -ScopeGlobal
        [bool] $r = $false

        try{
            Export-ChainsawConfig -JsonPath $json -ScopeGlobal
            $r = $true
        }catch{

        }

        $Global:Chainsaw.Teams.URI = ''
        Remove-Item -Path $json

        $r | Should -Be $true
    }

    it "Should export Teams.MessageTitle"{
        [string] $json = '.\PesterTeams.json'        

        Enable-ChainsawTeams -MessageTitle "Pester Tests" `
            -ScopeGlobal

        [bool] $r = $false

        try{
            Export-ChainsawConfig -JsonPath $json -ScopeGlobal
            $r = $true
        }catch{

        }

        Revoke-ChainsawEndpoint -Teams -Force
        Remove-Item -Path $json

        $r | Should -Be $true
    }

    it "Should export all Teams Values"{
        [string] $json = '.\PesterTeams.json'        

        [string[]] $Levels = @(
            'Emergency',
            'Alert',
            'Critical',
            'Error',
            'Warning',
            'Notice',
            'Info',
            'Debug'
        )

        $URI = 'notgoingtowork'
        if ( [string]::IsNullOrEmpty($env:TeamsURL) -eq $false ){
            $URI = $env:TeamsURL
        } 

        Enable-ChainsawTeams -URI $URI `
            -Levels $Levels `
            -MessageTitle "Pester Tests" `
            -ScopeGlobal

        [bool] $r = $false

        try{
            Export-ChainsawConfig -JsonPath $json -ScopeGlobal
            $r = $true
        }catch{

        }

        Revoke-ChainsawEndpoint -Teams -Force

        $r | Should -Be $true
    }
}

Describe "Endpoint: Teams Config Import"{
    it "Should import config from JSON"{
        [string] $json = '.\PesterTeams.json'

        $found = Test-Path -Path $json
        if($found -eq $false){
            throw "Unable to find JSON to import"
        }
        Enable-ChainsawTeams -JsonConfig $json -ScopeGlobal

        [hashtable] $h = $Global:Chainsaw.Teams

        [bool] $r = $false

        if( [string]::IsNullOrEmpty($h.URI) -eq $false -and
            [string]::IsNullOrEmpty($h.MessageTitle) -eq $false -and 
            [string]::IsNullOrEmpty($h.Levels) -eq $false){
            $r = $true
        }

        Remove-item -Path $json

        $r | Should -Be $true
    }   
}

Describe "Sending Messages"{
    it "Should take -Emergency"{
        Invoke-ChainsawMessage -Emergency `
            -Message "Pester"
            
        Invoke-ChainsawMessage -Emergency `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName)
        
        Invoke-ChainsawMessage -Emergency `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber)
        
        Invoke-ChainsawMessage -Emergency `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber) `
            -ErrorCode 100
    }
    it "Should take -Alert"{
        Invoke-ChainsawMessage -Alert `
            -Message "Pester"

        Invoke-ChainsawMessage -Alert `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName)
        
        Invoke-ChainsawMessage -Alert `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber)
        
        Invoke-ChainsawMessage -Alert `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber) `
            -ErrorCode 100
    }
    it "Should take -Critical"{
        Invoke-ChainsawMessage -Critical `
            -Message "Pester"

        Invoke-ChainsawMessage -Critical `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName)
        
        Invoke-ChainsawMessage -Critical `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber)
        
        Invoke-ChainsawMessage -Critical `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber) `
            -ErrorCode 100
    }
    it "Should take -Error"{
        Invoke-ChainsawMessage -Error `
            -Message "Pester"

        Invoke-ChainsawMessage -Error `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName)
        
        Invoke-ChainsawMessage -Error `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber)
        
        Invoke-ChainsawMessage -Error `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber) `
            -ErrorCode 100
    }
    it "Should take -Warning"{
        Invoke-ChainsawMessage -Warning `
            -Message "Pester"

        Invoke-ChainsawMessage -Warning `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName)
        
        Invoke-ChainsawMessage -Warning `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber)
        
        Invoke-ChainsawMessage -Warning `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber) `
            -ErrorCode 100
    }
    it "Should take -Notice"{
        Invoke-ChainsawMessage -Notice `
            -Message "Pester"

        Invoke-ChainsawMessage -Notice `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName)
        
        Invoke-ChainsawMessage -Notice `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber)
        
        Invoke-ChainsawMessage -Notice `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber) `
            -ErrorCode 100
    }
    it "Should take -Info"{
        Invoke-ChainsawMessage -Info `
            -Message "Pester"

        Invoke-ChainsawMessage -Info `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName)
        
        Invoke-ChainsawMessage -Info `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber)
        
        Invoke-ChainsawMessage -Info `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber) `
            -ErrorCode 100
    }
    it "Should take -Debug"{
        Invoke-ChainsawMessage -Debug `
            -Message "Pester"

        Invoke-ChainsawMessage -Debug `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName)
        
        Invoke-ChainsawMessage -Debug `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber)
        
        Invoke-ChainsawMessage -Debug `
            -Message "Pester" `
            -CallingFile (Get-CurrentFileName) `
            -LineNumber (Get-CurrentLineNumber) `
            -ErrorCode 100
    }
}