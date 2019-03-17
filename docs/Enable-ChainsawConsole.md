---
external help file: Chainsaw-help.xml
Module Name: Chainsaw
online version:
schema: 2.0.0
---

# Enable-ChainsawConsole

## SYNOPSIS
This will allow you to enter values that are bound to the Console endpoint.

## SYNTAX

```
Enable-ChainsawConsole [[-Levels] <String[]>] [[-MessageTemplate] <String>] [-ScopeGlobal]
 [[-JsonConfig] <String>]
```

## DESCRIPTION
In order to send to Console, you need to make sure you have the following parameters filled.
\[string\[\]\]  $Levels
\[string\]    $MessageTemplate

## EXAMPLES

### EXAMPLE 1
```
Enable-ChainsawConsole -Levels @("Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Information", "Debug") -MessageTemplate '#DateTime# #Level# #Message#'
```

Enable-ChainsawConsole -JsonConfig '.\chainsaw.json'

## PARAMETERS

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
Position: 1
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
Position: 2
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
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
