//
//  LXTextAttachment.m
//  TextViewLink
//
//  Created by 李旭 on 16/4/19.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import "LXTextAttachment.h"

@implementation LXTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    if ((int)self.imgSize.width > 0) {
        return CGRectMake(0, -5, self.imgSize.width, self.imgSize.height);
    }
    return CGRectMake(0, -5, 30, 30);
}

@end
