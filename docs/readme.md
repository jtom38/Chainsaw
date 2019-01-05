# PSLog

## About

This project was designed around easy logging and also gives flex reguarding how and where you want your logs to go.  I enjoyed working with [NLog](https://nlog-project.org) when I do C# work but more I had needs to automate processes with PowerShell but was not happy with some of the logging I found.  So with that I started to work on this project PSLog to hopfully make logging easier for others and myself.

## Targets

If you use NLog you will know they have different targets so where you can write logs.  I went with the same general idea.  Currently the following targets are enabled.

* [Console](https://github.com/luther38/PSLog/blob/master/Docs/Targets/Console.md)
* [CSV](https://github.com/luther38/PSLog/blob/master/Docs/Targets/CSV.md)
* [EventLog](https://github.com/luther38/PSLog/blob/master/Docs/Targets/EventLog.md)
* SMTP - TBD
* MSSQL - TBD

Wishlist

* Discord Webhook
* Microsoft Teams Webhook
* Slack

## Requirements

Currently I am targeting PowerShell 5+ because this is built with Classes currently.  I do have legacy commands but they need to be reworked.  Please do not use the legacy commands at this time.

## Config File

Everything with PSLog was designed around the aspect of being able to adjust the logging with just a config file.  My processes that I build are all with a JSON config file so I can allow my other team members who do not want to touch code can make adjustments.  It also makes it easier to adjust configuration while the process is alive.  I do recomend using a config file to support your processes but I do have contructors that will allow you to use inline code if you desired to do so.

## How to help

If you desire to help with the project please take a look at the active [Issues](https://github.com/luther38/PSLog/issues) and open tickets so I can keep track of what has been found.

## New Targets

If you have a target that you want please create a issue and I will see about what I can do to add it.  If you want to build the target please feel free to do a pull request and help out.

## Linux and MacOS

These are untested platforms at this time.  Please report your findings if you try PSLog on these operating systems. 