MHNotificationHelper
====================

![alt tag](https://dl.dropboxusercontent.com/u/17911939/notification.png)

## Podfile

```ruby
platform :ios, '6.0'
pod 'MHNotificationHelper'
```

##Usage

```objective-c
NSString *title = @"Benachrichtungen aktivieren";
NSString *descriptionString = @"Um die Notificationen verwenden zu können müssen sie die Banachrichtungen aktivieren.";
    
MHNotificationHelperObject *notificationObject = [MHNotificationHelperObject objectWithTitle:title
                                                                                 description:descriptionString
                                                                                     appIcon:nil
                                                                                     appName:@"meine App"];
    
MHNotificationHelperViewController *notificationHelper = [MHNotificationHelperViewController.alloc initWithNotification:notificationObject];
notificationHelper.bannerLabel.text = NSLocalizedString(@"Banner", nil);
    
[self presentViewController:notificationHelper animated:YES completion:nil];


```
