
Param(
    [string] $TeamsURI
)

Describe "Enpoint: Console [Config]"{

    It "Should have blank config"{
        [hashtable] $hash = $Global:Chainsaw.Console
        [bool] $result = $false

        if ([string]::IsNullOrEmpty($hash.MessageTemplate) -eq $true -and
            [string]::IsNullOrEmpty($hash.Levels) -eq $true ){
            $result = $true
        }

        $result | Should -Be $true
    }

    it "Should update Console.Levels"{
        Enable-ChainsawConsole -Levels @('Info') `
            -ScopeGlobal
        [hashtable] $hash = $Global:Chainsaw.Console
        if ([string]::IsNullOrEmpty($hash.Levels) -eq $false ){
            $result = $true
        }

        $result | Should -Be $true

        # Revert changes
        $Global:Chainsaw.Console.Levels = @()
    }

    it "Should update Console.MessageTemplate"{
        Enable-ChainsawConsole -MessageTemplate 'Demo' `
            -ScopeGlobal
        [hashtable] $hash = $Global:Chainsaw.Console
        if ([string]::IsNullOrEmpty($hash.MessageTemplate) -eq $false ){
            $result = $true
        }

        $result | Should -Be $true

        # Revert changes
        $Global:Chainsaw.Console.MessageTemplate = ''
    }

    it "Should update Console.Levels and Console.MessageTemplate"{
        Enable-ChainsawConsole -MessageTemplate '[#DateTime#] [#Level#] #Message#' `
            -Levels @('Info') `
            -ScopeGlobal
        [hashtable] $hash = $Global:Chainsaw.Console
        if ([string]::IsNullOrEmpty($hash.MessageTemplate) -eq $false -and 
            [string]::IsNullOrEmpty($hash.Levels) -eq $false){
            $result = $true
        }

        $result | Should -Be $true

        # Revert changes
        $Global:Chainsaw.Console.MessageTemplate = ''
        $Global:Chainsaw.Console.Levels = @()
    }
}

Describe "Endpoint: Console [Export Config]"{
    it "Should export blank Console Config"{
        [string] $json = ".\PesterConsole.json"
        #Clean up if found
        #Remove-item -Path $json

        Export-ChainsawConfig -JsonPath $json -ScopeGlobal
        $result = Test-Path -Path $json

        $result | Should -Be $true
        #Remove-item $json
    }

    it "Should fail to export Blank Console Config" {
        [string] $json = ".\PesterConsole.json"
        [bool] $result = $false
        try{
            Export-ChainsawConfig -JsonPath $json -ScopeGlobal
        }
        catch{
            # We got our error, we failed without -Force
            $result = $true
        }

        $result | Should -Be $true
        #Remove-item $json
    }

    it "Should -Force conifg update"{
        [string] $json = ".\PesterConsole.json"
        [bool] $result = $false
        try{
            Export-ChainsawConfig -JsonPath $json -ScopeGlobal -Force
            $result = $true
        }
        catch{
            $result = $false
        }

        $result | Should -Be $true
        Remove-item $json
    }

    it "Should store updated values from config and export" {
        [string] $json = ".\PesterConsole.json"
        #Clean up if found
        #Remove-item -Path $json
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
        Enable-ChainsawConsole -Levels $Levels `
            -MessageTemplate '[#DateTime#] [#Level#] [#CallingFile#] [#ErrorCode#] [#LineNumber#] #Message#' `
            -ScopeGlobal

        [bool] $result = $false
        try{
            Export-ChainsawConfig -JsonPath $json -ScopeGlobal
            $result = $true
        }catch{

        }
        $result | Should -Be $true
    }

    it "should have stored config information"{
        [string] $json = ".\PesterConsole.json"
        $jsonData = Get-Content -Path $json | ConvertFrom-Json

        [bool] $result = $false
        if ([string]::IsNullOrEmpty($jsonData.Console.MessageTemplate) -eq $false -and 
            [string]::IsNullOrEmpty($jsonData.Console.Levels) -eq $false){
                $result = $true
        }

        $result | Should -Be $true
    }
}

Describe "Endpoint: Console [Import Config]"{
    it "Should Import config"{
        [string] $json = ".\PesterConsole.json"

        $configFound = Test-Path -Path $json
        if($configFound -eq $false){
            throw "Unable to find $json"
        }

        Enable-ChainsawConsole -JsonConfig $json -ScopeGlobal

        [bool] $result = $false
        $hash = $Global:Chainsaw.Console
        if ([string]::IsNullOrEmpty($hash.Levels) -eq $false -and 
            [string]::IsNullOrEmpty($hash.MessageTemplate) -eq $false){
                $result = $true
        }
        
        Remove-Item -Path $json
        $result | Should -Be $true
    }
}

Describe "Sending Messages"{
    it "Should Accept -Emergency"{
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

Describe "Run Console Cleanup"{

    it "Revokes Endpoint"{
        Revoke-ChainsawEndpoint -Console -Force
    }

    it "Global should be null"{
        $g = $Global:Chainsaw.CSV
        $result = $false
        if( [string]::IsNullOrEmpty($g.Levels) -eq $true -and 
            [string]::IsNullOrEmpty($g.MessageTemplate) -eq $true -and
            [string]::IsNullOrEmpty($g.LogPath) -eq $true){
                $result = $true
        }
        $result | Should -Be $true
    }

    it "Script should be null"{
        $g = $Script:Chainsaw.CSV
        $result = $false
        if( [string]::IsNullOrEmpty($g.Levels) -eq $true -and 
            [string]::IsNullOrEmpty($g.MessageTemplate) -eq $true -and
            [string]::IsNullOrEmpty($g.LogPath) -eq $true){
                $result = $true
        }
        $result | Should -Be $true
    }
}