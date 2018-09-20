# PsLogCsv

## Description

This is a quick and dirty way to deal with CSV Logging so I don't have to have it all over the place.  One module that can stay with the script.

## How To use

Copy this directory and place it in the same folder.
In the main script call the following command

    ```powershell
    Import-Module .\LogCsv\LogCsv.psm1 -Force
    Set-CsvSettings -LogPath ".\log.csv" -Template "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#"
    ```

This will import the module in your session so you can call it from any sub files that might need to report logging.

To Import the settings from a config file:

    ```powershell
    Set-CsvConfig -Config '.\config.json'
    ```

    ```json
    "PsLogCsv" : {
        "LogPath" : ".\\log.csv",
        "Template" : "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#"
    }
    ```

To send a csv message just use the following example.

    ```powershell
    Send-CsvMessage -Message "Testing" -Level "Debug" -CallingFile $(Get-CurrentFileName) -LineNumber $(Get-CurrentLineNumber)
    ```

If you want to capture what was sent to the CSV file so you can send the data back in a email or send it elsewhere enable the following.

From inline code

    ```powershell
    Set-CsvSettings -LogPath ".\log.csv" -Template "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#" -ReturnMessage "[#DateTime#] [#Level#] #Message#"
    ```

From Config file

    ```json
    {
        "PsLogCsv" : {
            "LogPath":  ".\\log.csv",
            "Template":  "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#",
            "ReturnMessage" : "[#DateTime#] [#Level#] #Message#"
        }
    }
    ```

To capture the message.  I use an array to store them so I can convert them back at the end of the process.

    ```powershell
    $EmailMessage = @()
    $EmailMessage += Send-CsvMessage -Message "Testing" -Level "Debug" -CallingFile $(Get-CurrentFileName) -LineNumber $(Get-CurrentLineNumber)
    ```
