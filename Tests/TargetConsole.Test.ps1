
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
        Enable-ChainsawConsole -MessageTemplate 'Demo' `
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
        Remove-item -Path $json

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

    it "Should store updated values from config" {
        [string] $json = ".\PesterConsole.json"
        #Clean up if found
        Remove-item -Path $json
        Enable-ChainsawConsole -Levels @('Info') -MessageTemplate 'Demo' -ScopeGlobal
        
    }
}