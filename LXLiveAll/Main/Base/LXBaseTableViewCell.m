//
//  LXBaseTableViewCell.m
//  LXLiveAll
//
//  Created by 李旭 on 16/10/21.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "LXBaseTableViewCell.h"

@implementation LXBaseTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = NSStringFromClass(self);
    LXBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kWhiteColor255;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return self;
}

- (void)configurationCell:(id)object
{
    
}

@end
