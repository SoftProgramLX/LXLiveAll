//
//  LXDouyuHomeListModel.h
//  LXLiveAll
//
//  Created by 李旭 on 16/10/24.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXDouyuRoomListModel.h"

@interface LXDouyuHomeListModel : NSObject

@property (nonatomic, copy)   NSString *tag_name;
@property (nonatomic, copy)   NSArray<LXDouyuRoomListModel *> *room_list;

@end
