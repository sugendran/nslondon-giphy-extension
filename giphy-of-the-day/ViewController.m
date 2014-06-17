//
//  ViewController.m
//  giphy-of-the-day
//
//  Created by Sugendran Ganess on 17/06/2014.
//  Copyright (c) 2014 Sugendran Ganess. All rights reserved.
//

#import "ViewController.h"
#import "giphy.h"

@interface ViewController ()
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload");
    // Do any additional setup after loading the view, typically from a nib.
    [Giphy currentGif:^(UIImage *result, NSNumber *width, NSNumber *height) {
        NSLog(@"Got something!");
        if (result == nil)
        {
            return;
        }
        NSLog(@"setting image");
        [self.imgView setImage:result];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
