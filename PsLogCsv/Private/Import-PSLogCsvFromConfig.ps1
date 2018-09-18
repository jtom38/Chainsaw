
function Import-PSLogCsvFromConfig {
    param (
        [string] $Config
    )
    
    Process {
        
        # Check for the file on disk
        if ( [System.IO.File]::Exists($Config) -eq $true ) {

            $json = Get-Content -Path $Config | ConvertFrom-Json
            
            $v = New-Object psobject

            if ( [System.String]::IsNullOrEmpty($json.PsLogCsv) -eq $false ) {

                if ( [System.String]::IsNullOrEmpty($json.PsLogCsv.LogPath) -eq $false ) {
                    #$script:PsLogCsvLogPath = $json.PsLogCsv.LogPath
                    $v | Add-Member -MemberType NoteProperty -Name "LogPath" -Value $json.PsLogCsv.LogPath
                }

                if ( [System.String]::IsNullOrEmpty($json.PsLogCsv.Template) -eq $false ) {
                    #$Script:PsLogCsvTemplate = $json.PsLogCsv.Template
                    $v | Add-Member -MemberType NoteProperty -Name "Template" -Value $json.PsLogCsv.Template
                }

                $script:PsLogCsv = $v
            } else {
                throw "Unable to find 'PsLogCsv' in the config.  Please check the readme.md file for setup."
            }

        } else {
            throw "Unable to find $Config on disk."
        }
    }
}