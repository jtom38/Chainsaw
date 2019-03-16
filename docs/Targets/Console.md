
# Target: Console

## Description

Console target is a very simple one, it will output messages to the console window for viewing as the process is active.  This might not be something that is needed all the time but you can enable it when you need it.

# Message Template

For a message to be passed in the desired format with the data that we are looking for we have a template that should be followed. Here are the values that will be upated per the template.

* #DateTime#
* #Level#
* #CallingFile#
* #ErrorCode#
* #LineNumber#
* #Message#

You can use any of these that you want to support.  If you just want to know When, Level, and Message you can do that.

```PowerShell
$MessageTemplate = '#DateTime# #Level# #Message#'
```

With this example we would only end up replaceing values that Chainsaw knows about.  If you want to add decorations you can.

```PowerShell
$MessageTemplate = '[#DateTime#] - [#Level#] - #Message#'
```