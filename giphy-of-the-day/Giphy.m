//
//  giphy.m
//  giphy-of-the-day
//
//  Created by Sugendran Ganess on 17/06/2014.
//  Copyright (c) 2014 Sugendran Ganess. All rights reserved.
//

#import "Giphy.h"
#import "AFNetworking/AFNetworking.h"
#import "AnimatedGIFImageSerialization/AnimatedGIFImageSerialization.h"

@implementation Giphy

+ (void) currentGif:(void (^)(UIImage *result, NSNumber *width, NSNumber *height)) callback
{
//    NSURL *dataURL = [NSURL URLWithString:@"http://api.giphy.com/v1/gifs/trending?limit=1&rating=g&api_key=dc6zaTOxFJmzC"];
    NSURL *dataURL = [NSURL URLWithString:@"http://api.giphy.com/v1/gifs/search?q=puppy&limit=1&rating=g&api_key=dc6zaTOxFJmzC"];
    NSURLRequest *request = [NSURLRequest requestWithURL:dataURL];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];

    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;;
        NSArray *data = [result objectForKey:@"data"];
        NSDictionary *gif = [data objectAtIndex:0];
        NSDictionary *images = [gif objectForKey:@"images"];
        NSDictionary *info = [images objectForKey:@"fixed_width"];
        NSURL *url = [NSURL URLWithString:[info objectForKey:@"url"]];
        NSNumber *width = [NSNumber numberWithInt:[[info objectForKey:@"width"] intValue]];
        NSNumber *height = [NSNumber numberWithInt:[[info objectForKey:@"height"] intValue]];
        
        NSURLRequest *imgRequest = [NSURLRequest requestWithURL:url];
        AFHTTPRequestOperation *imgOp = [[AFHTTPRequestOperation alloc] initWithRequest:imgRequest];
        [imgOp setResponseSerializer:[AFImageResponseSerializer serializer]];
        [imgOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            callback(responseObject, width, height);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            callback(nil, nil, nil);
        }];
        [imgOp start];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(nil, nil, nil);
    }];
    [op start];
}
@end
