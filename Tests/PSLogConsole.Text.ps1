Describe "PSLogConsole" {

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

    It "Use Write(Level, Message)" {
        $Levels = @("Information")
        $MessageTemplate = "#CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $csv = [PSLogConsole]::new($MessageTemplate, $Levels)
        $csv.Write("Information", "Unit Testing")

    }

}