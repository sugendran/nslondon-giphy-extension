//
//  TodayViewController.m
//  gotd-extension
//
//  Created by Sugendran Ganess on 17/06/2014.
//  Copyright (c) 2014 Sugendran Ganess. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "giphy.h"

@interface TodayViewController () <NCWidgetProviding>


@end

@implementation TodayViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encoutered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    NSLog(@"viewdidload");
    // Do any additional setup after loading the view, typically from a nib.
    [Giphy currentGif:^(UIImage *result, NSNumber *width, NSNumber *height) {
        NSLog(@"Got something!");
        if (result == nil)
        {
            completionHandler(NCUpdateResultFailed);
        }
        else
        {
            NSLog(@"setting image");
            float h = (320/[width floatValue]) * [height floatValue];
            [self.imgView setFrame:CGRectMake(0, 0, 320, h)];
            [self setPreferredContentSize:CGSizeMake(320, h)];
            [self.imgView setImage:result];
            completionHandler(NCUpdateResultNewData);
        }
    }];
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsZero;
}

@end
