//
//  LXNetWorkTool.h
//  LXBaseFunction
//
//  Created by 李旭 on 16/3/26.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXNetWorkTool : NSObject

@property (nonatomic, assign) AFNetworkReachabilityStatus wifiType;

+ (LXNetWorkTool *)sharedLXNetWorkTool;

+ (void)getWithUrlString:(NSString *)urlStr withParam:(NSDictionary *)param success:(void (^)(NSDictionary * responseDic))success failure:(void (^)(NSError *error))failure;
+ (void)postWithUrlString:(NSString *)urlStr withParam:(NSDictionary *)param success:(void (^)(NSDictionary * responseDic))success failure:(void (^)(NSError *error))failure;

+ (NetworkStates)getCurrentNetworkStates;

@end
