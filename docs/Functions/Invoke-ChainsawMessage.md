---
external help file: Chainsaw-help.xml
Module Name: Chainsaw
online version:
schema: 2.0.0
---

# Invoke-ChainsawMessage

## SYNOPSIS
This will pass the message to all defined endpoints.

## SYNTAX

```
Invoke-ChainsawMessage [-Emergency] [-Alert] [-Critical] [-Error] [-Warning] [-Notice] [-Info] [-Debug]
 [[-Message] <String>] [[-ErrorCode] <Int32>] [[-CallingFile] <String>] [[-LineNumber] <Int32>]
```

## DESCRIPTION
When you have a message from a process this will take care of all message routing for you.

## EXAMPLES

### EXAMPLE 1
```
Invoke-ChainsawMessage -Debug -Message 'Testing Chainsaw'
```

Invoke-ChainsawMessage -Debug -Message 'Testing Chainsaw' -ErrorCode 100
Invoke-ChainsawMessage -Debug -Message 'Testing Chainsaw' -ErrorCode 100 -CallingFile $(Get-CurrentFileName)
Invoke-ChainsawMessage -Debug -Message 'Testing Chainsaw' -ErrorCode 100 -CallingFile $(Get-CurrentFileName) -LineNumber $(Get-CurrentLineNumber)

## PARAMETERS

### -Emergency
\[switch\] This will define the level of the message as Emergency.
Only define one of the switches.

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

### -Alert
\[switch\] This will define the level of the message as Alert.
Only define one of the switches.

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

### -Critical
\[switch\] This will define the level of the message as Critical.
Only define one of the switches.

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

### -Error
\[switch\] This will define the level of the message as Error.
Only define one of the switches.

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

### -Warning
\[switch\] This will define the level of the message as Warning.
Only define one of the switches.

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

### -Notice
\[switch\] This will define the level of the message as Notice.
Only define one of the switches.

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

### -Info
\[switch\] This will define the level of the message as Information.
Only define one of the switches.

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

### -Debug
\[switch\] This will define the level of the message as Debug.
Only define one of the switches.

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

### -Message
\[string\] This will define the log message that you want to have recorded.

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

### -ErrorCode
\[int\] This will let you define a custom error code if you wanted to.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CallingFile
\[string\] This will let you define the filename that the message came from.
Use Get-CurrentFileName as a helper

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

### -LineNumber
\[int\] This will let you define the line number that the message came from.
Use Get-CurrentLineNumber as a helper

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
