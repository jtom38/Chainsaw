# Chainsaw

## About

This project was designed around easy logging and also gives flex regarding how and where you want your logs to go.  I enjoyed working with [NLog](https://nlog-project.org) when I do C# work but more I had needed to automate processes with PowerShell but was not happy with some of the logging I found.  So with that, I started to work on this project Chainsaw to hopefully make logging easier for others and myself.

## Targets

If you use NLog you will know they have different targets so where you can write logs.  I went with the same general idea.  Currently, the following targets are enabled.

* [Console](https://github.com/luther38/Chainsaw/blob/master/docs/Targets/Console.md)
* [CSV](https://github.com/luther38/Chainsaw/blob/master/docs/Targets/CSV.md)
* [EventLog](https://github.com/luther38/Chainsaw/blob/master/docs/Targets/EventLog.md)
* Microsoft Teams Webhook
* SMTP - TBD
* MSSQL - TBD

Wishlist

* Discord Webhook

* Slack

## Requirements

Currently, I am targeting PowerShell 5+ because this is built with Classes currently.  I do have legacy commands but they need to be reworked.  Please do not use the legacy commands at this time.

### How to Use

Currently this module is only found on GitHub as I do not have it published, yet.  Download the master branch and take the Chainsaw folder and place it at the root of your script.  At the start of your script run the following to enable Chainsaw

```PowerShell
Import-Module .\Chainsaw\Chainsaw.psm1 -Force
. .\Chainsaw\ChainsawClasses.ps1 -Force
```

With those added you can call the rest of the classes as needed and build your logger.

[Example Script](https://github.com/luther38/Chainsaw/blob/master/Examples/Basic-Logging.ps1)

## Config File

Everything with Chainsaw was designed around the aspect of being able to adjust the logging with just a config file.  The processes that I build are all with a JSON config file so I can allow my other team members who do not want to touch code can make adjustments.  It also makes it easier to adjust configuration while the process is alive.  I do recommend using a config file to support your processes but I do have constructors that will allow you to use inline code if you desired to do so.

## How to help

If you desire to help with the project please take a look at the active [Issues](https://github.com/luther38/Chainsaw/issues) and open tickets so I can keep track of what has been found.

## New Targets

If you have a target that you want please create an issue and I will see what I can do to add it.  If you want to build the target please feel free to do a pull request and help out.

## Linux and MacOS

These are untested platforms at this time.  Please report your findings if you try Chainsaw on these operating systems.