Describe "Classes - PSLogConsole" {

    It "Initialize with inline code:" {
        $Levels = @("Information")
        $MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $c = [PSLogConsole]::new($MessageTemplate, $Levels)
        $valid = $c._isEndPointValid() 
        $valid | Should -Be $true
    }

    It "Initialize with config file:" {
        $PathConfig = ".\config.json"

        $c = [PSLogConsole]::new($PathConfig)   
        $valid = $c._isEndPointValid() 
        $valid | Should -Be $true
    }

    It "New-PSLogConsole blank" {
        $c = New-PSLogConsole 
        $valid = $c._isEndPointValid() 
        $valid | Should -Be $false
    }

    It "Use Write(Level, Message)" {
        $Levels = @("Information")
        $MessageTemplate = "#CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $csv = [PSLogConsole]::new($MessageTemplate, $Levels)
        $csv.Write("Information", "Unit Testing")

    }

    It "Use Write(Level, Message, ErrorCode)" {
        $Levels = @("Information")
        $MessageTemplate = "#CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $csv = [PSLogConsole]::new($MessageTemplate, $Levels)
        $csv.Write("Information", "Unit Testing", 1)

    }

}

Describe "Functions - PSLogConsole" {

    It "New-PSLogConsole Inline code:" {
        $Levels = @("Information")
        $MessageTemplate = "#CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $c = New-PSLogConsole -MessageTemplate $MessageTemplate -Levels $Levels
        $valid = $c._isEndPointValid()
        $valid | Should -Be $true
    }

    It "New-PSLogConsole config file" {
        $PathConfig = ".\config.json"

        $c = New-PSLogConsole -PathConfig $PathConfig  
        $valid = $c._isEndPointValid() 
        $valid | Should -Be $true
    }

    It "New-PSLogConsole blank" {
        $c = New-PSLogConsole 
        $valid = $c._isEndPointValid() 
        $valid | Should -Be $false
    }
}