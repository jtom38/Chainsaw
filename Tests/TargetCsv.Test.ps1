
Describe "EndPoint: CSV Config"{
    It "Should have a blank Config"{
        [hashtable] $hash = $Global:Chainsaw.CSV
        [bool] $result = $false

        if ([string]::IsNullOrEmpty($hash.LogPath) -eq $true -and 
            [string]::IsNullOrEmpty($hash.Levels) -eq $true -and 
            [string]::IsNullOrEmpty($hash.MessageTemplate) -eq $true){
                $result = $true
        }
        $result | Should -Be $true
    }

    It "Should update CSV.Levels"{
        Enable-ChainsawCsv -Levels @('Debug') -ScopeGlobal

        [hashtable]$h = $Global:Chainsaw.CSV
        [bool] $r = $false

        if( [string]::IsNullOrEmpty($h.Levels) -eq $false){
            $r = $true
        }

        $Global:Chainsaw.CSV.Levels = @()

        $r | Should -Be $true
    }

    It "Should update CSV.MessageTemplate"{
        Enable-ChainsawCsv -MessageTemplate "Filler" -ScopeGlobal

        [hashtable]$h = $Global:Chainsaw.CSV
        [bool] $r = $false

        if( [string]::IsNullOrEmpty($h.MessageTemplate) -eq $false){
            $r = $true
        }
        $Global:Chainsaw.CSV.MessageTemplate = ''
        $r | Should -Be $true
    }

    It "Should update CSV.LogPath"{
        Enable-ChainsawCsv -LogPath '.\pester.csv' -ScopeGlobal

        [hashtable]$h = $Global:Chainsaw.CSV
        [bool] $r = $false

        if( [string]::IsNullOrEmpty($h.LogPath) -eq $false){
            $r = $true
        }

        $Global:Chainsaw.CSV.LogPath = ''

        $r | Should -Be $true
    }

    it "Should update CSV.Levels & CSV.MessageTemplate & CSV.LogPath" {
        Enable-ChainsawCsv -MessageTemplate "Debug" `
            -Levels @('Debug') `
            -LogPath '.\pester.csv' `
            -ScopeGlobal

        [hashtable]$h = $Global:Chainsaw.CSV
        [bool] $r = $false

        if( [string]::IsNullOrEmpty($h.LogPath) -eq $false -and
            [string]::IsNullOrEmpty($h.MessageTemplate) -eq $false -and 
            [string]::IsNullOrEmpty($h.Levels) -eq $false){
            $r = $true
        }

        $Global:Chainsaw.CSV.LogPath = ''
        $Global:Chainsaw.CSV.MessageTemplate = ''
        $Global:Chainsaw.CSV.Levels = @()

        $r | Should -Be $true
    }
}

Describe "Endpoint: CSV Config Export"{
    it "Should export CSV.Levels"{
        [string] $json = '.\PesterCsv.json'

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

        Enable-ChainsawCsv -Levels $Levels -ScopeGlobal
        [bool] $r = $false

        try{
            Export-ChainsawConfig -JsonPath $json -ScopeGlobal
            $r = $true
        }catch{

        }

        $Global:Chainsaw.CSV.Levels = @()
        Remove-Item -Path $json

        $r | Should -Be $true
    }

    it "Should export CSV.MessageTemplate"{
        [string] $json = '.\PesterCsv.json'

        [string] $template = "debug"

        Enable-ChainsawCsv -MessageTemplate $template -ScopeGlobal
        [bool] $r = $false

        try{
            Export-ChainsawConfig -JsonPath $json -ScopeGlobal
            $r = $true
        }catch{

        }

        $Global:Chainsaw.CSV.MessageTemplate = ''
        Remove-Item -Path $json

        $r | Should -Be $true
    }

    it "Should export CSV.LogPath"{
        [string] $json = '.\PesterCsv.json'

        [string] $Log = ".\Pester.csv"

        Enable-ChainsawCsv -LogPath $Log -ScopeGlobal
        [bool] $r = $false

        try{
            Export-ChainsawConfig -JsonPath $json -ScopeGlobal
            $r = $true
        }catch{

        }

        $Global:Chainsaw.CSV.LogPath = ''
        Remove-Item -Path $json

        $r | Should -Be $true
    }

    it "Should -Force config update"{
        [string] $json = '.\PesterCsv.json'
        [bool] $r = $false

        try{
            Export-ChainsawConfig -JsonPath $json -ScopeGlobal -Force
            $r = $true
        }catch{

        }

        Remove-Item -Path $json

        $r | Should -Be $true
    }

    it "Should export all CSV values"{
        [string] $json = '.\PesterCsv.json'

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
        [string] $Log = ".\Pester.csv"

        Enable-ChainsawCsv -Levels $Levels `
            -MessageTemplate "#DateTime#, #Level#, #CallingFile#, #ErrorCode#, #LineNumber#, #Message#" `
            -LogPath $log `
            -ScopeGlobal
        [bool] $r = $false

        try{
            Export-ChainsawConfig -JsonPath $json -ScopeGlobal
            $r = $true
        }catch{

        }

        $Global:Chainsaw.CSV.MessageTemplate = ''
        $Global:Chainsaw.CSV.Levels = @()
        $Global:Chainsaw.CSV.LogPath = ''
        #Remove-Item -Path $json

        $r | Should -Be $true
    }
}

Describe "Endpoint: CSV Import Config"{
    it "Should Import Config From JSON"{
        [string] $json = '.\PesterCsv.json'

        $configFound = Test-Path -Path $json
        if($configFound -eq $false){
            throw "Unable to find $json"
        }

        Enable-ChainsawCsv -JsonConfig $json -ScopeGlobal

        [hashtable] $h = $Global:Chainsaw.CSV

        #Expecting three filled values
        [bool] $r = $false

        if( [string]::IsNullOrEmpty($h.LogPath) -eq $false -and
            [string]::IsNullOrEmpty($h.MessageTemplate) -eq $false -and 
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

Describe "Run CSV Cleanup"{
    it "Should remove global variables"{
        $Global:Chainsaw.CSV.Levels = @()
        $Global:Chainsaw.CSV.MessageTemplate = ''
        $Global:Chainsaw.CSV.LogPath = ''
        Remove-item -Path 'Pester.csv'
        $true | Should -Be $true
    }
}