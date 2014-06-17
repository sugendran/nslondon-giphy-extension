//
//  giphy.h
//  giphy-of-the-day
//
//  Created by Sugendran Ganess on 17/06/2014.
//  Copyright (c) 2014 Sugendran Ganess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Giphy : NSObject

+ (void) currentGif:(void (^)(UIImage *result, NSNumber *width, NSNumber *height)) callback;

@end
