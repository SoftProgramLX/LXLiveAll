//
//  LXTextView.h
//  TextViewLink
//
//  Created by 李旭 on 16/4/19.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXTextView : UITextView

@property (nonatomic, assign) CGFloat fontFloat;

@property (nonatomic, weak) NSString *textString;

- (void)downloadImageWithUrl:(NSString *)urlString withIndex:(NSInteger)index;

@end
