//
//  LXBaseCollectionCell.m
//  LXLiveAll
//
//  Created by 李旭 on 16/10/24.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "LXBaseCollectionCell.h"

@implementation LXBaseCollectionCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = bgColor;
    }
    return self;
}

- (void)configurationCell:(id)object
{
    
}

@end
