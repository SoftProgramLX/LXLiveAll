//
//  LXHelpClass.m
//  LXLiveAll
//
//  Created by 李旭 on 16/10/21.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "LXHelpClass.h"

@implementation LXHelpClass

+ (CGFloat)getMaxYOfRect:(CGRect)rect
{
    return rect.origin.y + rect.size.height;
}

+ (CGFloat)getMaxXOfRect:(CGRect)rect
{
    return rect.origin.x + rect.size.width;
}

+ (NSString *)getCurrentTimeStamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    NSLog(@"time:%@", timeString);
    return timeString;
}

@end
