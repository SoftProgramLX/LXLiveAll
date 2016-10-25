//
//  LXMyHomeView.m
//  LXLiveAll
//
//  Created by 李旭 on 16/10/25.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "LXMyHomeView.h"
#import "LXTextView.h"

@interface LXMyHomeView () <UITextViewDelegate>

@end

@implementation LXMyHomeView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier withFrame:(CGRect)frame
{
    self = [super initWithReuseIdentifier:reuseIdentifier withFrame:frame];
    if (self) {
        self.backgroundColor = bgColor;
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2.0, 100, 150, 44)];
    VIEW_BORDER_RADIUS(btn, 5, 0, [UIColor whiteColor]);
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"观看我的直播" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    LXTextView *textView = [[LXTextView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(btn.frame) + 12, SCREEN_WIDTH-12*2, 80)];
    textView.delegate = self;
    textView.editable = NO; //非编辑状态下才可以点击Url]
    textView.fontFloat = 12.;
    textView.textColor = kBlackColor52;
    textView.textString = @"同时请用另外一台设备点击：直播->开始直播，并保证已经配置好了服务器环境，在pch里将URL_LIVE的ip已经更换为本机ip地址，查看教程";
    [self addSubview:textView];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"URL:%@   scheme:%@   host:%@", URL, [URL scheme], [URL host]);
    return YES;
}

- (void)btnClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(popToPlayerVC:)]) {
        [self.delegate popToPlayerVC:nil];
    }
}

@end
