
function Import-PSLogCsvFromConfig {
    param (
        [string] $Config
    )
    
    Process {
        
        # Check for the file on disk
        if ( [System.IO.File]::Exists($Config) -eq $true ) {

            $json = Get-Content -Path $Config | ConvertFrom-Json

            if ( [System.String]::IsNullOrEmpty($json.PsLogCsv) -eq $false ) {

                if ( [System.String]::IsNullOrEmpty($json.PsLogCsv.LogPath) -eq $false ) {
                    #$script:PsLogCsvLogPath = $json.PsLogCsv.LogPath
                    #$v | Add-Member -MemberType NoteProperty -Name "LogPath" -Value $json.PsLogCsv.LogPath
                    $global:LogCsvLogPath = $json.PsLogCsv.LogPath
                }

                if ( [System.String]::IsNullOrEmpty($json.PsLogCsv.Template) -eq $false ) {
                    #$Script:PsLogCsvTemplate = $json.PsLogCsv.Template
                    #$v | Add-Member -MemberType NoteProperty -Name "Template" -Value $json.PsLogCsv.Template
                    $global:LogCsvTemplate = $json.PsLogCsv.Template
                }

                if ( [System.String]::IsNullOrEmpty($json.PsLogCsv.ReturnMessage) -eq $false ) {
                    $Global:LogCsvReturnMessage = $json.PsLogCsv.ReturnMessage
                }

                if ( [System.String]::IsNullOrEmpty($json.PsLogCsv.StoreMessagesSent) -eq $false ) {
                    $Global:LogCsvStoreMessagesSet = $json.PsLogCsv.StoreMessagesSent
                }

            } else {
                throw "Unable to find 'PsLogCsv' in the config.  Please check the readme.md file for setup."
            }

        } else {
            throw "Unable to find $($Config) on disk."
        }
    }
}