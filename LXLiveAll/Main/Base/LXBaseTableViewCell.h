//
//  LXBaseTableViewCell.h
//  LXLiveAll
//
//  Created by 李旭 on 16/10/21.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXBaseTableViewCell : UITableViewCell

- (void)configurationCell:(id)object;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
