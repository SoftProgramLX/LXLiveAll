//
//  LXMyHomeView.h
//  LXLiveAll
//
//  Created by 李旭 on 16/10/25.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "LXListScrollView.h"
#import "LXHomeListViewDelegate.h"

@interface LXMyHomeView : LXListScrollView

@property (nonatomic, weak)   id<LXHomeListViewDelegate> delegate;

@end
