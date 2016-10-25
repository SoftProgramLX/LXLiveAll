//
//  LXDouyuHomeCollectionHeader.m
//  LXLiveAll
//
//  Created by 李旭 on 16/10/24.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "LXDouyuHomeCollectionHeader.h"

@interface LXDouyuHomeCollectionHeader ()

@property (nonatomic, weak)   UILabel *nameLabel;

@end

@implementation LXDouyuHomeCollectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_GAP, frame.size.height-16, SCREEN_WIDTH, 16)];
        label.text = @"***";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = kBlackColor0;
        [self addSubview:label];
        self.nameLabel = label;
    }
    return self;
}

- (void)configurationHeader:(NSString *)text
{
    self.nameLabel.text = text;
}

@end
