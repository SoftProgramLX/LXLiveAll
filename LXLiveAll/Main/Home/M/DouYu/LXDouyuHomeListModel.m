//
//  LXDouyuHomeListModel.m
//  LXLiveAll
//
//  Created by 李旭 on 16/10/24.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "LXDouyuHomeListModel.h"

@implementation LXDouyuHomeListModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"room_list":[LXDouyuRoomListModel class]};
}

@end