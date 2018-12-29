
# Can I just insert into a custom 

# Check to see if we find any events for where we want to log
$ConfigPath = ".\config.json"
$Config = Get-Content -Path $ConfigPath | ConvertFrom-Json

$t = Get-EventLog -LogName $Config.EventViewer.LogName -Source $Config.EventViewer.Source -Newest 1 | Measure-Object
if ( $t.Count -eq 0) {
    try {
        New-EventLog -LogName $Config.EventViewer.LogName -Source $Config.EventViewer.Source 
    } catch {

    }
}


New-EventLog -LogName $Config.EventViewer.LogName -Source $Config.EventViewer.Source

Write-EventLog -LogName $Config.EventViewer.LogName -Source $Config.EventViewer.Source -EventID 3001 -EntryType Information -Message "New log was initialized by $ENV:Username"


Write-EventLog -LogName "PowerShellApps" -Source "PSLog" -EventID 3001 -EntryType Information -Message "MyApp added a user-requested feature to the display."