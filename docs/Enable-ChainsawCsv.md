---
external help file: Chainsaw-help.xml
Module Name: Chainsaw
online version:
schema: 2.0.0
---

# Enable-ChainsawCsv

## SYNOPSIS
This lets you enable Chainsaw to send messages to CSV endpoints.

## SYNTAX

```
Enable-ChainsawCsv [[-LogPath] <String>] [[-Levels] <String[]>] [[-MessageTemplate] <String>] [-ScopeGlobal]
 [[-JsonConfig] <String>] [<CommonParameters>]
```

## DESCRIPTION
In order to send to CSV you need to make sure you have the following paramerters filled.
\[string\]    $LogPath
\[string\[\]\]  $Levels
\[string\]    $MessageTemplate

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -LogPath
\[string\] LogPath defines the location where the CSV entries will be written to.

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
\[string\[\]\] Levels defines what levels of messages it will accept and record messages for.

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

### -MessageTemplate
\[string\] MessageTemplate defines the template that we will use and replace values for with variables sent to the logger.
See Example for information

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
\[switch\] ScopeGlobal defines where to look for the Chainsaw Configuration

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
{{Fill JsonConfig Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
