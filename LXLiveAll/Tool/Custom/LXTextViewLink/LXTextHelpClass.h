//
//  LXHelpClass.h
//  TestVal
//
//  Created by 李旭 on 16/3/21.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXTextHelpClass : NSObject

@property (nonatomic, strong) NSArray *faces;
@property (nonatomic, strong) NSMutableArray *keyArr;
@property (nonatomic, strong) NSMutableArray *valueArr;

+ (LXTextHelpClass *)sharedLXTextHelpClass;
+ (NSArray *)validateEmojiOfText:(NSString *)string;
+ (NSArray *)validateLinkOfText:(NSString *)string;

@end
