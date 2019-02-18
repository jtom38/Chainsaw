Describe "Classes - ChainsawConsole" {

    It "Initialize with inline code:" {
        $Levels = @("Information")
        $MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $c = [ChainsawConsole]::new($MessageTemplate, $Levels)
        $valid = $c._isEndPointValid() 
        $valid | Should -Be $true
    }

    It "Initialize with config file:" {
        $PathConfig = ".\config.json"

        $c = [ChainsawConsole]::new($PathConfig)   
        $valid = $c._isEndPointValid() 
        $valid | Should -Be $true
    }

    It "New-ChainsawConsole blank" {
        $c = New-ChainsawConsole 
        $valid = $c._isEndPointValid() 
        $valid | Should -Be $false
    }

    It "Use Write(Level, Message)" {
        $Levels = @("Information")
        $MessageTemplate = "#CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $csv = [ChainsawConsole]::new($MessageTemplate, $Levels)
        $csv.Write("Information", "Unit Testing")

    }

    It "Use Write(Level, Message, ErrorCode)" {
        $Levels = @("Information")
        $MessageTemplate = "#CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $csv = [ChainsawConsole]::new($MessageTemplate, $Levels)
        $csv.Write("Information", "Unit Testing", 1)

    }

}

Describe "Functions - ChainsawConsole" {

    It "New-ChainsawConsole Inline code:" {
        $Levels = @("Information")
        $MessageTemplate = "#CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $c = New-ChainsawConsole -MessageTemplate $MessageTemplate -Levels $Levels
        $valid = $c._isEndPointValid()
        $valid | Should -Be $true
    }

    It "New-ChainsawConsole config file" {
        $PathConfig = ".\config.json"

        $c = New-ChainsawConsole -PathConfig $PathConfig  
        $valid = $c._isEndPointValid() 
        $valid | Should -Be $true
    }

    It "New-ChainsawConsole blank" {
        $c = New-ChainsawConsole 
        $valid = $c._isEndPointValid() 
        $valid | Should -Be $false
    }
}