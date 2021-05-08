# AppleWatchCallNotificationFix
 Fixes call notification not working on Apple Watch after carplay is connected!

On iOS 14 - 14.4.2, there is a bug where as soon as the phone connects to Carplay, the apple watch will stop notifying of calls. This was fixed in iOS 14.5.
On debugging I found that restarting callservicesd after this happens fixes the issue. So this tweak basically captures the carplay disconnect event and then safely kickstarts callservicesd.
