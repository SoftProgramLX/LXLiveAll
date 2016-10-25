//
//  UIScrollViewCell.h
//  LXScrollerCacheChildVC
//
//  Created by 李旭 on 16/8/25.
//  Copyright © 2016年 LX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXScrollView.h"

@interface LXListScrollView : UIView

@property (nonatomic, copy, nonnull)   NSString *reuseIdentifier;

- (nullable __kindof instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier withFrame:(CGRect)frame;
- (void)refreshDataWithIndex:(NSInteger)index;
+ (nullable __kindof instancetype)cellWithScrollView:(nullable __kindof LXScrollView *)ScrollView;

@end
