# togglBar
If you use Toggl for managing your working hours, this macOS app allows you to display your weekly earnings in the status bar.

You have to configure your user parameters in the config.plist file. If you are compiling from scratch it is located in the root source directory. If you are using the compiled app in the Releases folder you can find the file by right clicking on TogglBar and selecting Show Package Contents and navigating to TogglBar/Contents/Resources/config.plist.

There you set the following information:

Parameter|Description
---------|-----------
userAgent|Your e-mail. This is asked by Toggle as a way to contact you if you are using the api in a way you shouldn'.
togglApiToken|You can obtain this token in your Profile settings in your Toggl account. It is an alphanumeric number of the form ea807c3211b7efAf3329c594da02909
hourlyRate|How much you earn by work hour.
currency|The currency symbol that should be displayed along your weekly earnings.
workspaceIndex|If you have several workspaces on Toggl, use this index to select which one you wish to display. 0 is the first, and the default value.
