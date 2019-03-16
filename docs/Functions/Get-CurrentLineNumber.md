---
external help file: Chainsaw-help.xml
Module Name: Chainsaw
online version:
schema: 2.0.0
---

# Get-CurrentLineNumber

## SYNOPSIS
Wrapper function to return $MyInvocation.ScriptLineNumber

## SYNTAX

```
Get-CurrentLineNumber
```

## DESCRIPTION
Use this in debuging where a message came from.

## EXAMPLES

### EXAMPLE 1
```
Invoke-ChainsawMessage `
```

-Debug \`
    -Message "What line number is this?" \`
    -LineNumber $(Get-CurrentLineNumber)

Get-CurrentLineNumber

## PARAMETERS

## INPUTS

## OUTPUTS

### [int]
## NOTES

## RELATED LINKS
