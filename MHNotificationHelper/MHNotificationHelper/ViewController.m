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
    
    NSString *title = @"Turn on Notifications";
    NSString *descriptionString = @"This way, you and your friends will see messages instantly on your phones.";
    
    MHNotificationHelperObject *notificationObject = [MHNotificationHelperObject objectWithTitle:title
                                                                                     description:descriptionString
                                                                                         appIcon:[[UIImage imageNamed:@"MHVideo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                                                                         appName:@"meine App"];
    
    MHNotificationHelperViewController *notificationHelper = [MHNotificationHelperViewController.alloc initWithNotification:notificationObject];    
    [self presentViewController:notificationHelper animated:YES completion:nil];
    
}

@end
