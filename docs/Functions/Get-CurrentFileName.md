---
external help file: Chainsaw-help.xml
Module Name: Chainsaw
online version:
schema: 2.0.0
---

# Get-CurrentFileName

## SYNOPSIS
Use this to return the calling files name.
Use this to find the source of a calling message.

## SYNTAX

```
Get-CurrentFileName
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1
```
Invoke-ChainsawMessage `
```

-Debug \`
    -Message "What file is this?" \`
    -CallingFile $(Get-CurrentFileName)

Get-CurrentFileName

## PARAMETERS

## INPUTS

## OUTPUTS

### [string]
## NOTES

## RELATED LINKS
