//
//  LXDouyuHomeGameCollectionCell.m
//  LXLiveAll
//
//  Created by 李旭 on 16/10/24.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "LXDouyuHomeGameCollectionCell.h"
#import "LXDouyuRoomListModel.h"

@interface LXDouyuHomeGameCollectionCell ()

@property (nonatomic, weak)   UIImageView *bgImgV;
@property (nonatomic, weak)   UILabel *roomNameLabel;
@property (nonatomic, strong) UIButton *onlineNumBtn;
@property (nonatomic, strong) UIButton *nickNameBtn;

@end

@implementation LXDouyuHomeGameCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor255;
        
        UIImageView *bgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 16)];
        VIEW_BORDER_RADIUS(bgImgV, 5, 0, kWhiteColor255);
        [self addSubview:bgImgV];
        self.bgImgV = bgImgV;
        
        UIButton *onlineNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        onlineNumBtn.backgroundColor = colora(0, 0, 0, 0.4);
        onlineNumBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        onlineNumBtn.frame = CGRectMake(bgImgV.width - 70, 0, 70, 20);
//        [onlineNumBtn setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
        [onlineNumBtn setTitle:@"-" forState:UIControlStateNormal];
        [onlineNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.bgImgV addSubview:onlineNumBtn];
        self.onlineNumBtn = onlineNumBtn;
        
        UIButton *nickNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nickNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        nickNameBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        nickNameBtn.frame = CGRectMake(0, bgImgV.height - 20, bgImgV.width, 20);
//        [nickNameBtn setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
        [nickNameBtn setTitle:@"**" forState:UIControlStateNormal];
        [nickNameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        nickNameBtn.imageEdgeInsets = UIEdgeInsetsMake(3, 0, 3, 3);
        nickNameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self.bgImgV addSubview:nickNameBtn];
        self.nickNameBtn = nickNameBtn;
        
        UILabel *roomNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 12, frame.size.width, 12)];
        roomNameLabel.font = [UIFont systemFontOfSize:12];
        roomNameLabel.textColor = kBlackColor0;
        [self addSubview:roomNameLabel];
        self.roomNameLabel = roomNameLabel;
        
    }
    return self;
}

- (void)configurationCell:(LXDouyuRoomListModel *)model
{
    [self.bgImgV sd_setImageWithURL:[NSURL URLWithString:model.room_src] placeholderImage:[UIImage imageNamed:@"default_bg"]];
    self.roomNameLabel.text = model.room_name;
    [self.onlineNumBtn setTitle:model.online forState:UIControlStateNormal];
    [self.nickNameBtn setTitle:model.nickname forState:UIControlStateNormal];
}

@end
