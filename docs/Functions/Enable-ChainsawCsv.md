---
external help file: Chainsaw-help.xml
Module Name: Chainsaw
online version:
schema: 2.0.0
---

# Enable-ChainsawCsv

## SYNOPSIS
This will allow you to enter values that bound to the CSV endpoint.

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

### EXAMPLE 1
```
Enable-ChainsawCsv `
```

-LogPath '.\log.csv' \`
    -Levels @("Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Information", "Debug") \`
    -MessageTemplate "#DateTime#, #Level#, #CallingFile#, #ErrorCode#, #LineNumber#, #Message#"

Enable-ChainsawCsv -JsonPath '.\chainsaw.json'

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
\[string\[\]\] This will define the events that it will monitor for. 
Enter the following values that are pre defined.
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

### -MessageTemplate
\[string\] This defines the format of the message that will be displayed in. 
Use any of the following values in a string to build the MessageTemplate.
    #DateTime#
    #Level#
    #CallingFile#
    #ErrorCode#
    #LineNumber#
    #Message#

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
\[string\] This if filled will tell it where to look for a exported config file to reimport.

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
