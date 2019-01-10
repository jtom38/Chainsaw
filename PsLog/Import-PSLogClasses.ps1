
# Have not come up with a way yet for this to work.  Do not use.
function Import-PSLogClasses {

    $Classes = @(
    "TemplateConverter.ps1",
    "PSLogConsole.ps1",
    "PSLogCsv.ps1",
    "PSLogEventLog.ps1",
    "PSLogSmtp.ps1",
    "PSLog.ps1"
    )

    foreach ( $class in $Classes ) {
        $file = Get-ChildItem -Path $PSScriptRoot\Classes\$class 

        #$p = "$($PSScriptRoot)\Classes\$($class)" 
        Write-Host $file.FullName

        if ( $file.Exists -eq $true ) {
            . $file.FullName -Force
        }else {
            Write-Error "Unable to find $class."
        }
        
    }
    
    
}