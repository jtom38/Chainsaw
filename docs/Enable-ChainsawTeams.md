---
external help file: Chainsaw-help.xml
Module Name: Chainsaw
online version:
schema: 2.0.0
---

# Enable-ChainsawTeams

## SYNOPSIS
This will allow you to enter values that are bound to the Microsoft Teams endpoint.

## SYNTAX

```
Enable-ChainsawTeams [[-URI] <String>] [[-Levels] <String[]>] [[-MessageTitle] <String>] [-ScopeGlobal]
 [[-JsonConfig] <String>]
```

## DESCRIPTION
In order to send to Teams, you need to make sure you have the following parameters filled.
\[string\[\]\]  $Levels
\[string\]    $URI
\[string\]    $MessageTitle

## EXAMPLES

### EXAMPLE 1
```
Enable-ChainsawTeams -URI "https://FakeUrl.com" -Levels @("Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Information", "Debug") -MessageTitle 'Message From Chainsaw'
```

Enable-ChainsawTeams -JsonConfig '.\chainsaw.json'

## PARAMETERS

### -URI
\[string\] This will define the Webhook URL that we will send data to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Levels
\[string\[\]\] This will define the events that it will monitor for. 
Enter the following values that are predefined.
    "Emergency"
    "Alert"
    "Critical"
    "Error"
    "Warning"
    "Notice"
    "Information"
    "Debug"

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MessageTitle
\[string\] This will define the header message in Teams.
If you have several processes that use the same webhook you can use this to define the process name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScopeGlobal
\[switch\] ScopeGlobal defines where to look for the Chainsaw Configuration.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -JsonConfig
\[string\] This if filled will tell it where to look for an exported config file to reimport.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
