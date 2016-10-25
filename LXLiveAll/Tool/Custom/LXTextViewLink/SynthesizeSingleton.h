//
//  SynthesizeSingleton.h
//  NiuZaiNet
//
//  Created by apple on 15/6/24.
//  Copyright (c) 2015年 LX. All rights reserved.
//

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
 \
static classname *shared##classname = nil; \
 \
+ (classname *)shared##classname \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        shared##classname = [[self alloc] init]; \
    }); \
    return shared##classname; \
} \
