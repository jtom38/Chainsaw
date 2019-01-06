
function New-PSLogCsvConfig {
    param (
        [string] $PathConfig
    )
    
    Process {

        return [PSLogCsv]::new($PathConfig)

    }
}