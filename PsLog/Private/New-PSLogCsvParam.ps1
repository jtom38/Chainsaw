
function New-PSLogCsvParam {
    param (
        [string] $LogPath, 
        [string] $MessageTemplate, 
        [string[]] $Levels
    )

    Process {

        return [PSLogCsv]::new($LogPath, $MessageTemplate, $Levels)

    }
    
}