


Import-Module platyPS
.\install.ps1
Import-Module Chainsaw -Force

New-MarkdownHelp -Module Chainsaw -OutputFolder .\docs\Functions -Force
New-ExternalHelp -Path .\docs\Functions -OutputPath .\en-US\ -Force