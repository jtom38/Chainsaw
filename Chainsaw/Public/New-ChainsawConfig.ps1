

function New-ChainsawConfig {

    param(
        [switch] $CSV,
        [switch] $Console,

        # This will return the config hashtable but make sure it is empty
        [switch] $Empty
    )

    if( $CSV ){

        if ($Empty){
            $Config = @{
                Levels = @()
                LogPath = ""
                MessageTemplate = ""
            }
        }
        else {
            $Config = @{
                Levels = @(
                    "Emergency",
                    "Alert",
                    "Critical",
                    "Error",
                    "Warning",
                    "Notice",
                    "Information",
                    "Debug"
                )
                LogPath = ".\log.csv"
                MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"
            }
        }

        return $Config
    }

    if ( $Console ) {
        $Config = @{
            Levels = @(
                "Emergency",
                "Alert",
                "Critical",
                "Error",
                "Warning",
                "Notice",
                "Information",
                "Debug"
            )
            MessageTemplate = "[#DateTime#] [#Level#] #Message#"
        }

        return $Config
    }    
}