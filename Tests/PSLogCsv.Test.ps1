Describe "PSLogCsv" {
    It "Initialize with inline code:" {
        $Levels = @("Information")
        $LogPath = ".\pester.csv"
        $MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $csv = [PSLogCSV]::new($LogPath, $MessageTemplate, $Levels)
        $valid = $csv._isValidEndPoint() 
        $valid | Should -Be $true
     
    }

    It "Initialize with config file:" {
        $PathConfig = ".\config.json"

        $csv = [PSLogCSV]::new($PathConfig)   
        $valid = $csv._isValidEndPoint() 
        $valid | Should -Be $true

    }

    It "Generate new csv log:" {
        $Levels = @("Information")
        $LogPath = ".\pester.csv"
        $MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        # Remove old 

        $csv = [PSLogCSV]::new($LogPath, $MessageTemplate, $Levels)
        $csv._GenerateCsvIfMissing()

        $exists = [System.IO.File]::Exists(".\pester.csv")

        if ( $exists -eq $true ) {
            $row0 = Get-Content -Path $LogPath
            $row0 | Should -Be "DateTime, CallingFile, LineNumber, Level, Message, ErrorCode"
            [System.IO.File]::Delete($LogPath)
        }
        else {
            Write-Error -Message "Failed to generate the csv file"
            $exists | Should -Be $true
        }
        
    }

    It ""
}