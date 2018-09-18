# PsLogCsv

## Description

This is a quick and dirty way to deal with CSV Logging so I don't have to have it all over the place.  One module that can stay with the script.

## How To use

Copy this directory and place it in the same folder.
In the main script call the following command

    ```powershell
    Import-Module .\LogCsv\LogCsv.psm1 -Force
    Set-CsvSettings -LogPath ".\log.csv" -Template "#DateTime#, #Level#, #Message#"
    ```

    This will import the module in your session so you can call it from any sub files that might need to report logging.

    To Import the settings from a config file:

    ```powershell
    Set-CsvConfig -Config '.\config.json'
    ```

    ```json
    "PsLogCsv" : {
        "LogPath" : ".\\log.csv",
        "Template" : "#DateTime#, #Level#, #Message#"
    }
    ```

To send a csv message just use the following example.

    ```powershell
    Send-CsvMessage -Message "Testing" -Level "Debug"
    ```
