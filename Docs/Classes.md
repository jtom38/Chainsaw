# PSLog - Classes

## Overview

The class build of PsLog lets you treat your logging simular to say NLog in .net.  I wanted to be able to create multiple logging endpoints and make a logging tool for PowerShell that got out of your way.  In this doc I will go over what you need to do to use the classes in PSLog.

## Enable Classes

To Enable the use of the classes in your applications you will currently need to call the files directly at the start of your application.  PowerShell classes do not import with the Import-Module command.  You can also use the new using command.

```using module FullFilePath```


## EndPoints

### CSV

To 