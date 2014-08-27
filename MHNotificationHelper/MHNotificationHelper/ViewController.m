//
//  ViewController.m
//  MHNotificationHelper
//
//  Created by Mario Hahn on 27.08.14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//

#import "ViewController.h"
#import "MHNotificationHelperViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSString *title = @"Benachrichtungen aktivieren";
    NSString *descriptionString = @"Um die Notificationen verwenden zu können müssen sie die Banachrichtungen aktivieren.";
    
    MHNotificationHelperObject *notificationObject = [MHNotificationHelperObject objectWithTitle:title
                                                                                     description:descriptionString
                                                                                         appIcon:nil
                                                                                         appName:@"meine App"];
    
    MHNotificationHelperViewController *notificationHelper = [MHNotificationHelperViewController.alloc initWithNotification:notificationObject];
    notificationHelper.bannerLabel.text = NSLocalizedString(@"seaas", nil);
    notificationHelper.numberFourDescriptionLabel.text = @"Yeah";
    
    [self presentViewController:notificationHelper animated:YES completion:nil];
    
}

@end
