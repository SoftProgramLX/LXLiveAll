//
//  LXHelpClass.m
//  TestVal
//
//  Created by 李旭 on 16/3/21.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import "LXTextHelpClass.h"
#import "SynthesizeSingleton.h"

@interface LXTextHelpClass ()

@property (nonatomic, copy) NSString *validateStr; //表情文字的正则表达式

@end

@implementation LXTextHelpClass

SYNTHESIZE_SINGLETON_FOR_CLASS(LXTextHelpClass)

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"expression" ofType:@"plist"];
        _faces = [NSArray arrayWithContentsOfFile:path];
        _keyArr = [[NSMutableArray alloc] init];
        _valueArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in self.faces) {
            [self.keyArr addObject:[dic allKeys][0]];
            [self.valueArr addObject:[dic allValues][0]];
        }
    }
    return self;
}

+ (NSArray *)validateEmojiOfText:(NSString *)string
{
    LXTextHelpClass *helpClass = [LXTextHelpClass sharedLXTextHelpClass];
    NSMutableArray *imgKeyArr = [NSMutableArray array];
    NSArray *arr = [string componentsSeparatedByString:@"["];
    for (int i = 1; i < arr.count; i++) {
        NSString *str1 = arr[i];
        NSArray *arr2 = [str1 componentsSeparatedByString:@"]"];
        for (int j = 0; j < arr2.count - 1; j++) {
            NSString *seekStr = [NSString stringWithFormat:@"[%@]", arr2[j]];
            if ([helpClass.keyArr containsObject:seekStr]) {
                [imgKeyArr addObject:seekStr];
            }
        }
    }
    
    return imgKeyArr;
}

+ (NSArray *)validateLinkOfText:(NSString *)string
{
    //采用正则表达式匹配敏感词
    NSError *error;
    
    //适用于任何网址
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    NSMutableArray *strLinkArr = [NSMutableArray array];
    for (NSTextCheckingResult *arr in arrayOfAllMatches) {
        [strLinkArr addObject:NSStringFromRange(arr.range)];
    }
    
    return strLinkArr;
}

@end



