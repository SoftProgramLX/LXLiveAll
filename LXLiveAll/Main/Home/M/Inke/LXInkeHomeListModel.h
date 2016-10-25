//
//  LXYingKeHomeListModel.h
//  LXLiveAll
//
//  Created by 李旭 on 16/10/21.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXInkeCreatorModel.h"

@interface LXInkeHomeListModel : NSObject

@property (nonatomic, strong) LXInkeCreatorModel *creator;
@property (nonatomic, copy)   NSString *stream_addr;
@property (nonatomic, copy)   NSString *city;
@property (nonatomic, copy)   NSString *online_users;

@end
