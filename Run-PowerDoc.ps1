#Import-Module PowerDoc
Import-Module "C:\Users\James.Tombleson\Documents\GitHub\PowerDoc\PowerDoc\PowerDoc.psm1" -Force

Start-PowerDoc -PathOutput ".\docs\Classes" `
    -PathInput ".\PsLog\Classes" `
    -Markdown `
    -Classes `
    -CleanOutput