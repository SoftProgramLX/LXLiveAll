//
//  LXHomeListCell.m
//  LXLiveAll
//
//  Created by 李旭 on 16/10/21.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "LXHomeListCell.h"
#import "LXInkeHomeListModel.h"
#import "LXMiaoHomeListModel.h"

@interface LXHomeListCell ()

@property (nonatomic, weak)   UIImageView *headerImgV;
@property (nonatomic, weak)   UILabel *nameLabel;
@property (nonatomic, weak)   UILabel *onNumLabel;
@property (nonatomic, weak)   UILabel *addressLabel;
@property (nonatomic, weak)   UIImageView *bgImgV;

@end

@implementation LXHomeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *headerImgV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_GAP, 5, kHomeListCellHeaderH - 2*5, kHomeListCellHeaderH - 2*5)];
        [self.contentView addSubview:headerImgV];
        self.headerImgV = headerImgV;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake([LXHelpClass getMaxXOfRect:self.headerImgV.frame] + 12, self.headerImgV.y + 5, 300, 18)];
        nameLabel.font = [UIFont systemFontOfSize:18];
        nameLabel.textColor = kBlackColor0;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.x, [LXHelpClass getMaxYOfRect:self.nameLabel.frame] + 14, 300, 14)];
        addressLabel.font = [UIFont systemFontOfSize:14];
        addressLabel.textColor = kBlackColor52;
        [self.contentView addSubview:addressLabel];
        self.addressLabel = addressLabel;
        
        UILabel *onNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - (100 + SCREEN_GAP), 0, 100, kHomeListCellHeaderH)];
        onNumLabel.numberOfLines = 2;
        onNumLabel.textAlignment = NSTextAlignmentRight;
        onNumLabel.font = [UIFont systemFontOfSize:18];
        onNumLabel.textColor = kBlackColor0;
        [self.contentView addSubview:onNumLabel];
        self.onNumLabel = onNumLabel;
        
        UIImageView *bgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, kHomeListCellHeaderH, SCREEN_WIDTH, kHomeListCellH - kHomeListCellHeaderH)];
        bgImgV.image = [UIImage imageNamed:@"default_bg"];
        [self.contentView addSubview:bgImgV];
        self.bgImgV = bgImgV;
    }
    return self;
}

- (void)configurationCell:(id)object
{
    if ([object isMemberOfClass:[LXInkeHomeListModel class]]) {
        LXInkeHomeListModel *model = object;
        NSString *imgUrlStr = [NSString stringWithFormat:URL_INKE_IMG, model.creator.portrait];
        [self.headerImgV sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:[UIImage imageNamed:@"default_avatar"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.headerImgV.image = [image cutIntoACircleImage];
            self.bgImgV.image = image;
        }];
        self.nameLabel.text = model.creator.nick;
        self.addressLabel.text = model.city;
        self.onNumLabel.text = [model.online_users stringByAppendingString:@"\n人在看"];
    } else if ([object isMemberOfClass:[LXMiaoHomeListModel class]]) {
        LXMiaoHomeListModel *model = object;
        [self.headerImgV sd_setImageWithURL:[NSURL URLWithString:model.bigpic] placeholderImage:[UIImage imageNamed:@"default_avatar"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.headerImgV.image = [image cutIntoACircleImage];
            self.bgImgV.image = image;
        }];
        self.nameLabel.text = model.myname;
        self.addressLabel.text = model.gps;
        self.onNumLabel.text = [model.allnum stringByAppendingString:@"\n人在看"];
    }
}

@end
