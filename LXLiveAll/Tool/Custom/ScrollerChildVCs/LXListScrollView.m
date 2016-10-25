//
//  UIScrollViewCell.m
//  LXScrollerCacheChildVC
//
//  Created by 李旭 on 16/8/25.
//  Copyright © 2016年 LX. All rights reserved.
//

#import "LXListScrollView.h"
#import "ScrollChildHeader.h"

@implementation LXListScrollView

+ (instancetype)cellWithScrollView:(LXScrollView *)ScrollView
{
    NSString *ID = NSStringFromClass(self);
    LXListScrollView *cell = [ScrollView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithReuseIdentifier:ID withFrame:ScrollView.bounds];
    }
    return cell;
}

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.reuseIdentifier = reuseIdentifier;
    }

    return self;
}

- (void)refreshDataWithIndex:(NSInteger)index
{
}

@end
