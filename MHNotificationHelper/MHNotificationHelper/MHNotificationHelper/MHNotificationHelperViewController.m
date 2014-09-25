//
//  DMNotificationHelperViewController.m
//  3MobileTV
//
//  Created by Mario Hahn on 27.08.14.
//  Copyright (c) 2014 Hutchison Drei Austria GmbH. All rights reserved.
//

#import "MHNotificationHelperViewController.h"
#import "Masonry.h"

#define kMHNotificationBundleName @"MHNotification.bundle"

static NSString* (^ CustomLocalizationBlock)(NSString *localization) = nil;

NSBundle *MHNotificationBundle(void) {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* path = [NSBundle.mainBundle.resourcePath stringByAppendingPathComponent:kMHNotificationBundleName];
        bundle = [NSBundle bundleWithPath:path];
    });
    return bundle;
}

void MHNotificationCustomLocalizationBlock(NSString *(^customLocalizationBlock)(NSString *stringToLocalize)){
    CustomLocalizationBlock = customLocalizationBlock;
}
NSString *MHNotificationLocalizedString(NSString *localizeString) {
    if (CustomLocalizationBlock) {
        NSString *string = CustomLocalizationBlock(localizeString);
        if (string) {
            return string;
        }
    }
    return  NSLocalizedStringFromTableInBundle(localizeString, @"MHNotification", MHNotificationBundle(), @"");
}

@implementation MHNotificationHelperObject

- (instancetype)initWithTitle:(NSString*)title
                  description:(NSString*)notificationDescription
                      appIcon:(UIImage*)appIcon
                      appName:(NSString*)appname{
    self = [super init];
    if (!self)
        return nil;
    self.title = title;
    self.notifciationDescription = notificationDescription;
    self.appIcon = appIcon;
    self.appName = appname;
    return self;
}

+ (instancetype)objectWithTitle:(NSString*)title
                    description:(NSString*)notificationDescription
                        appIcon:(UIImage*)appIcon
                        appName:(NSString*)appname{
    return [self.class.alloc initWithTitle:title description:notificationDescription appIcon:appIcon appName:appname];
}
@end

@interface MHUISwitchView ()
@property (nonatomic,strong) UIView *switchView;
@end

@implementation MHUISwitchView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 10.5;
        self.clipsToBounds = YES;
        self.backgroundColor = UIColor.whiteColor;
        
        _switchView = UIView.new;
        self.switchView.backgroundColor = UIColor.blackColor;
        self.switchView.layer.cornerRadius = 9;
        self.switchView.clipsToBounds = YES;
        
        [self addSubview:self.switchView];
        
        [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).with.offset(-1.5);
            make.centerY.mas_equalTo(self.center);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
    }
    return self;
}


@end

@interface MHNotificationHelperViewController ()
@end

@implementation MHNotificationHelperViewController

- (id)initWithNotification:(MHNotificationHelperObject*)notification
{
    self = [super init];
    if (self) {
        
        self.view.backgroundColor = UIColor.blackColor;
        
        CGFloat paddingBetweenLabels = 28;
        CGFloat paddingBetweenViews = 10;
        CGFloat paddingImageView = 5;
        
        _exitButton = UIButton.new;
        [self.exitButton addTarget:self action:@selector(exitButtonAction) forControlEvents:UIControlEventTouchUpInside];
        self.exitButton.tintColor = UIColor.lightGrayColor;
        [self.exitButton setImage:[[UIImage imageNamed:@"MHExit"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [self.view addSubview:self.exitButton];
        
        [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.view.mas_right).with.offset(-5);
            make.top.mas_equalTo(self.view.mas_top).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        _titleLabel = UILabel.new;
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.text = notification.title;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = UIColor.whiteColor;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.view addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(20);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
            make.top.mas_equalTo(self.view.mas_top).with.offset(60);
        }];
        
        _descriptionLabel = UILabel.new;
        self.descriptionLabel.text = notification.notifciationDescription;
        self.descriptionLabel.numberOfLines = MAXFLOAT;
        self.descriptionLabel.textColor = UIColor.lightGrayColor;
        self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.descriptionLabel];
        
        [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(10);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(paddingBetweenLabels-8);
        }];
        
        _doesItWorkLabel = UILabel.new;
        self.doesItWorkLabel.textColor = UIColor.whiteColor;
        self.doesItWorkLabel.text = MHNotificationLocalizedString(@"notification.work");
        [self.doesItWorkLabel setAdjustsFontSizeToFitWidth:YES];
        self.doesItWorkLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.view addSubview:self.doesItWorkLabel];
        
        [self.doesItWorkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(10);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.descriptionLabel.mas_bottom).with.offset(paddingBetweenLabels-8);
        }];
        
        _numberOneLabel = UILabel.new;
        self.numberOneLabel.text = @"1.";
        [self.view addSubview:self.numberOneLabel];
        
        [self.numberOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(10);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.doesItWorkLabel.mas_bottom).with.offset(paddingBetweenLabels);
        }];
        
        _numberOneImageView = UIImageView.new;
        self.numberOneImageView.image = [[UIImage imageNamed:@"MHSettings"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.view addSubview:self.numberOneImageView];
        
        [self.numberOneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(35);
            make.size.mas_equalTo(CGSizeMake(28, 28));
            make.top.mas_equalTo(self.doesItWorkLabel.mas_bottom).with.offset(paddingBetweenLabels-paddingImageView);
        }];
        
        _numberOneDescriptionLabel = UILabel.new;
        self.numberOneDescriptionLabel.textColor = UIColor.whiteColor;
        self.numberOneDescriptionLabel.text = MHNotificationLocalizedString(@"notification.open");
        self.numberOneDescriptionLabel.numberOfLines = 2;
        self.numberOneDescriptionLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.view addSubview:self.numberOneDescriptionLabel];
        
        [self.numberOneDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(75);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.doesItWorkLabel.mas_bottom).with.offset(paddingBetweenLabels);
        }];
        
        _numberTwoLabel = UILabel.new;
        self.numberTwoLabel.text = @"2.";
        [self.view addSubview:self.numberTwoLabel];
        
        [self.numberTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(10);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.numberOneDescriptionLabel.mas_bottom).with.offset(paddingBetweenLabels);
        }];
        
        _numberTwoImageView = UIImageView.new;
        self.numberTwoImageView.image = [[UIImage imageNamed:@"MHNotification"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.view addSubview:self.numberTwoImageView];
        
        [self.numberTwoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(35);
            make.size.mas_equalTo(CGSizeMake(28, 28));
            make.top.mas_equalTo(self.numberOneDescriptionLabel.mas_bottom).with.offset(paddingBetweenLabels-paddingImageView);
        }];
        
        _numberTwoDescriptionLabel = UILabel.new;
        self.numberTwoDescriptionLabel.textColor = UIColor.whiteColor;
        self.numberTwoDescriptionLabel.text = MHNotificationLocalizedString(@"notification.notificationTap");
        self.numberTwoDescriptionLabel.numberOfLines = 2;
        self.numberTwoDescriptionLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.view addSubview:self.numberTwoDescriptionLabel];
        
        [self.numberTwoDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(75);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.numberOneDescriptionLabel.mas_bottom).with.offset(paddingBetweenLabels);
        }];
        
        _numberThreeLabel = UILabel.new;
        self.numberThreeLabel.text = @"3.";
        [self.view addSubview:self.numberThreeLabel];
        
        [self.numberThreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(10);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.numberTwoDescriptionLabel.mas_bottom).with.offset(paddingBetweenLabels);
        }];
        
        _numberThreeImageView = UIImageView.new;
        self.numberThreeImageView.image = notification.appIcon;
        [self.view addSubview:self.numberThreeImageView];
        
        [self.numberThreeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(35);
            make.size.mas_equalTo(CGSizeMake(28, 28));
            make.top.mas_equalTo(self.numberTwoDescriptionLabel.mas_bottom).with.offset(paddingBetweenLabels-paddingImageView);
        }];
        
        _numberThreeDescriptionLabel = UILabel.new;
        self.numberThreeDescriptionLabel.textColor = UIColor.whiteColor;
        self.numberThreeDescriptionLabel.text = [NSString stringWithFormat:MHNotificationLocalizedString(@"notification.chooseBanner"),notification.appName];
        self.numberThreeDescriptionLabel.numberOfLines = 2;
        self.numberThreeDescriptionLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.view addSubview:self.numberThreeDescriptionLabel];
        
        [self.numberThreeDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(75);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.numberTwoDescriptionLabel.mas_bottom).with.offset(paddingBetweenLabels);
        }];
        
        _numberFourLabel = UILabel.new;
        self.numberFourLabel.text = @"4.";
        [self.view addSubview:self.numberFourLabel];
        
        [self.numberFourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(10);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.numberThreeLabel.mas_bottom).with.offset(paddingBetweenLabels);
        }];
        
        _numberFourDescriptionLabel = UILabel.new;
        self.numberFourDescriptionLabel.textColor = UIColor.whiteColor;
        self.numberFourDescriptionLabel.text = MHNotificationLocalizedString(@"notification.activate");
        self.numberFourDescriptionLabel.numberOfLines = 2;
        self.numberFourDescriptionLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.view addSubview:self.numberFourDescriptionLabel];
        
        [self.numberFourDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(35);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.numberThreeDescriptionLabel.mas_bottom).with.offset(paddingBetweenLabels);
        }];
        
        _numberFourDescriptionView = UIView.new;
        self.numberFourDescriptionView.layer.cornerRadius = 8;
        self.numberFourDescriptionView.layer.borderColor = UIColor.whiteColor.CGColor;
        self.numberFourDescriptionView.layer.borderWidth = 1;
        [self.view addSubview:self.numberFourDescriptionView];
        
        [self.numberFourDescriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(35);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-35);
            make.height.mas_equalTo(35);
            make.top.mas_equalTo(self.numberFourDescriptionLabel.mas_bottom).with.offset(paddingBetweenViews);
        }];
        
        _numberFourDescriptionLabelInDescriptionView = UILabel.new;
        self.numberFourDescriptionLabelInDescriptionView.font = [UIFont boldSystemFontOfSize:15];
        self.numberFourDescriptionLabelInDescriptionView.textColor = UIColor.whiteColor;
        self.numberFourDescriptionLabelInDescriptionView.text = MHNotificationLocalizedString(@"notification.lockScreen");
        [self.numberFourDescriptionLabelInDescriptionView setAdjustsFontSizeToFitWidth:YES];
        [self.numberFourDescriptionView addSubview:self.numberFourDescriptionLabelInDescriptionView];
        
        [self.numberFourDescriptionLabelInDescriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.numberFourDescriptionView.mas_left).with.offset(15);
            make.right.mas_equalTo(self.numberFourDescriptionView.mas_right).with.offset(-70);
            make.top.mas_equalTo(self.numberFourDescriptionView.mas_top).with.offset(0);
            make.bottom.mas_equalTo(self.numberFourDescriptionView.mas_bottom).with.offset(0);
        }];
        
        _numberFourSwitchView = MHUISwitchView.new;
        [self.numberFourDescriptionView addSubview:self.numberFourSwitchView];
        
        [self.numberFourSwitchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.numberFourDescriptionView.mas_right).with.offset(-10);
            make.centerY.mas_equalTo(self.numberFourDescriptionView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(45, 21));
        }];
        
        _numberFiveLabel = UILabel.new;
        self.numberFiveLabel.text = @"5.";
        [self.view addSubview:self.numberFiveLabel];
        
        [self.numberFiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(10);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.numberFourDescriptionView.mas_bottom).with.offset(paddingBetweenLabels/2);
        }];
        
        _numberFiveDescriptionLabel = UILabel.new;
        self.numberFiveDescriptionLabel.textColor = UIColor.whiteColor;
        self.numberFiveDescriptionLabel.text = MHNotificationLocalizedString(@"notification.chooseBanner");
        self.numberFiveDescriptionLabel.numberOfLines = 2;
        self.numberFiveDescriptionLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.view addSubview:self.numberFiveDescriptionLabel];
        
        [self.numberFiveDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(35);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.numberFourDescriptionView.mas_bottom).with.offset(paddingBetweenLabels/2);
        }];
        
        _numberFiveDescriptionView = UIView.new;
        self.numberFiveDescriptionView.layer.cornerRadius = 8;
        self.numberFiveDescriptionView.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
        self.numberFiveDescriptionView.layer.borderWidth = 1;
        [self.view addSubview:self.numberFiveDescriptionView];
        
        [self.numberFiveDescriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(35);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-35);
            make.height.mas_equalTo(35);
            make.top.mas_equalTo(self.numberFiveDescriptionLabel.mas_bottom).with.offset(paddingBetweenViews);
        }];
        
        [self.view layoutIfNeeded];
        
        _noneLabel = UILabel.new;
        self.noneLabel.textColor = UIColor.lightGrayColor;
        self.noneLabel.text = MHNotificationLocalizedString(@"notification.none");
        [self.noneLabel setAdjustsFontSizeToFitWidth:YES];
        self.noneLabel.font = [UIFont boldSystemFontOfSize:15];
        self.noneLabel.textAlignment = NSTextAlignmentCenter;
        [self.numberFiveDescriptionView addSubview:self.noneLabel];
        
        _bannerLabel = UILabel.new;
        self.bannerLabel.backgroundColor = UIColor.whiteColor;
        self.bannerLabel.clipsToBounds = YES;
        self.bannerLabel.layer.cornerRadius = 8;
        self.bannerLabel.textColor = UIColor.blackColor;
        self.bannerLabel.text = MHNotificationLocalizedString(@"notification.banner");
        [self.bannerLabel setAdjustsFontSizeToFitWidth:YES];
        self.bannerLabel.font = [UIFont boldSystemFontOfSize:15];
        self.bannerLabel.textAlignment = NSTextAlignmentCenter;
        [self.numberFiveDescriptionView addSubview:self.bannerLabel];
        
        _hinweisLabel = UILabel.new;
        self.hinweisLabel.textColor = UIColor.lightGrayColor;
        self.hinweisLabel.text = MHNotificationLocalizedString(@"notification.alert");
        [self.hinweisLabel setAdjustsFontSizeToFitWidth:YES];
        self.hinweisLabel.font = [UIFont boldSystemFontOfSize:15];
        self.hinweisLabel.textAlignment = NSTextAlignmentCenter;
        [self.numberFiveDescriptionView addSubview:self.hinweisLabel];
        
        [self.noneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.numberFiveDescriptionView.mas_left);
            make.centerY.mas_equalTo(self.numberFiveDescriptionView.mas_centerY);
            make.right.mas_equalTo(self.bannerLabel.mas_left);
            [self constraintsForLabelsInViewFive:make];
        }];
        
        [self.bannerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.noneLabel.mas_right);
            make.right.mas_equalTo(self.hinweisLabel.mas_left);
            [self constraintsForLabelsInViewFive:make];
        }];
        
        [self.hinweisLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bannerLabel.mas_right);
            [self constraintsForLabelsInViewFive:make];
            make.right.mas_equalTo(self.numberFiveDescriptionView.mas_right);
            make.centerY.mas_equalTo(self.numberFiveDescriptionView.mas_centerY);
        }];
        
        [self numberAppearanceForLables:@[self.numberOneLabel,self.numberTwoLabel,self.numberThreeLabel,self.numberFourLabel,self.numberFiveLabel]];
        [self appearanceForImageViews:@[self.numberOneImageView,self.numberTwoImageView,self.numberThreeImageView]];
    }
    return self;
}

-(void)appearanceForImageViews:(NSArray*)imagesViews{
    for (UIImageView *imageView in imagesViews) {
        imageView.layer.cornerRadius = 8;
        imageView.backgroundColor = UIColor.whiteColor;
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeCenter;
        imageView.tintColor = UIColor.blackColor;
    }
}

-(void)constraintsForLabelsInViewFive:(MASConstraintMaker *)make{
    make.top.mas_equalTo(self.numberFiveDescriptionView.mas_top).with.offset(7);
    make.bottom.mas_equalTo(self.numberFiveDescriptionView.mas_bottom).with.offset(-7);
    make.width.mas_equalTo(@[self.noneLabel.mas_width,self.bannerLabel.mas_width]);
}

-(void)numberAppearanceForLables:(NSArray*)labels{
    
    for (UILabel *label in labels) {
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = UIColor.darkGrayColor;
    }
}

-(void)exitButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

@end
