//
//  DMNotificationHelperViewController.h
//  3MobileTV
//
//  Created by Mario Hahn on 27.08.14.
//  Copyright (c) 2014 Hutchison Drei Austria GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHNotificationHelperObject : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *notifciationDescription;
@property (nonatomic,strong) UIImage  *appIcon;
@property (nonatomic,strong) NSString *appName;


- (instancetype)initWithTitle:(NSString*)title
                  description:(NSString*)notificationDescription
                      appIcon:(UIImage*)appIcon
                      appName:(NSString*)appname;


+ (instancetype)objectWithTitle:(NSString*)title
                    description:(NSString*)notificationDescription
                        appIcon:(UIImage*)appIcon
                        appName:(NSString*)appname;
@end

@interface MHUISwitchView : UIView
@end



@interface MHNotificationHelperViewController : UIViewController
@property (nonatomic,strong) UILabel        *titleLabel;
@property (nonatomic,strong) UILabel        *descriptionLabel;

@property (nonatomic,strong) UIButton       *exitButton;
@property (nonatomic,strong) UILabel        *doesItWorkLabel;

@property (nonatomic,strong) UILabel        *numberOneLabel;
@property (nonatomic,strong) UILabel        *numberOneDescriptionLabel;
@property (nonatomic,strong) UIImageView    *numberOneImageView;

@property (nonatomic,strong) UILabel        *numberTwoLabel;
@property (nonatomic,strong) UILabel        *numberTwoDescriptionLabel;
@property (nonatomic,strong) UIImageView    *numberTwoImageView;

@property (nonatomic,strong) UILabel        *numberThreeLabel;
@property (nonatomic,strong) UILabel        *numberThreeDescriptionLabel;
@property (nonatomic,strong) UIImageView    *numberThreeImageView;


@property (nonatomic,strong) UILabel        *numberFourLabel;
@property (nonatomic,strong) UILabel        *numberFourDescriptionLabel;
@property (nonatomic,strong) UIView         *numberFourDescriptionView;
@property (nonatomic,strong) MHUISwitchView *numberFourSwitchView;
@property (nonatomic,strong) UILabel        *numberFourDescriptionLabelInDescriptionView;


@property (nonatomic,strong) UILabel        *numberFiveLabel;
@property (nonatomic,strong) UILabel        *numberFiveDescriptionLabel;
@property (nonatomic,strong) UIView         *numberFiveDescriptionView;
@property (nonatomic,strong) UILabel        *noneLabel;
@property (nonatomic,strong) UILabel        *bannerLabel;
@property (nonatomic,strong) UILabel        *hinweisLabel;

- (id)initWithNotification:(MHNotificationHelperObject*)notification;
@end
