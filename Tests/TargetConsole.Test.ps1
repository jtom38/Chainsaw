
Describe "Enpoint: Console Config"{

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

Describe "Endpoint Console Export"{
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
            -MessageTemplate '[#DateTime#] [#Level#] #Message#' `
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

Describe "Endpoint Console Import Config"{
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
            -

    }
    it "Should take -Alert"{
        [bool] $result = $false
        try{
            Invoke-ChainsawMessage -Alert -Message "Pester" | Out-Null
            $result = $true
        }catch{

        }
        $result | Should -Be $true
    }
    it "Should take -Critical"{
        [bool] $result = $false
        try{
            Invoke-ChainsawMessage -Critical -Message "Pester" | Out-Null
            $result = $true
        }catch{

        }
        $result | Should -Be $true
    }
    it "Should take -Error"{
        [bool] $result = $false
        try{
            Invoke-ChainsawMessage -Error -Message "Pester" | Out-Null
            $result = $true
        }catch{

        }
        $result | Should -Be $true
    }
    it "Should take -Warning"{
        [bool] $result = $false
        try{
            Invoke-ChainsawMessage -Warning -Message "Pester" | Out-Null
            $result = $true
        }catch{

        }
        $result | Should -Be $true
    }
    it "Should take -Notice"{
        [bool] $result = $false
        try{
            Invoke-ChainsawMessage -Notice -Message "Pester" | Out-Null
            $result = $true
        }catch{

        }
        $result | Should -Be $true
    }
    it "Should take -Info"{
        [bool] $result = $false
        try{
            Invoke-ChainsawMessage -Info -Message "Pester" | Out-Null
            $result = $true
        }catch{

        }
        $result | Should -Be $true
    }
    it "Should take -Debug"{
        [bool] $result = $false
        try{
            Invoke-ChainsawMessage -Debug -Message "Pester" | Out-Null
            $result = $true
        }catch{

        }
        $result | Should -Be $true
    }
}