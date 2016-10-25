//
//  LXHomeController.m
//  LXLiveAll
//
//  Created by 李旭 on 16/10/21.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "LXHomeController.h"
#import "LXHomeListView.h"
#import "LXListScrollView.h"
#import "LXScrollView.h"
#import "ScrollChildHeader.h"
#import "LXPlayerController.h"
#import "LXInkeHomeListModel.h"
#import "LXMiaoHomeListModel.h"
#import "LXDouyuHomeListView.h"
#import "LXDouyuRoomListModel.h"
#import "LXMyHomeView.h"

@interface LXHomeController ()<LXScrollViewDelegate, LXHomeListViewDelegate>

@property (nonatomic, weak) LXScrollView *scrollerView;
@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation LXHomeController
#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSetup];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;

    [super viewWillDisappear:YES];
}

#pragma mark - Loading data

- (void)initSetup
{
    self.view.backgroundColor = bgColor;
    //下面句代码必不可少
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.titleArray = @[@"映客", @"喵播", @"斗鱼", @"我"];
}

#pragma mark - Create view

- (void)createUI
{
    LXScrollView *scrollerView = [[LXScrollView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 20)];
    scrollerView.delegate = self;
    scrollerView.titleCanScroll = YES;
    scrollerView.titleArray = self.titleArray;
    [self.view addSubview:scrollerView];
    self.scrollerView = scrollerView;
}

#pragma mark - SystemDelegate

#pragma mark - CustomDelegate

- (LXListScrollView *)scrollView:(LXScrollView *)scrollView cellForIndex:(NSInteger)index
{
    
    if (index == self.titleArray.count - 1) {
        LXMyHomeView *cell = [LXMyHomeView cellWithScrollView:scrollView];
        cell.delegate = self;
        return cell;
    } else if (index == 2) {
        LXDouyuHomeListView *cell = [LXDouyuHomeListView cellWithScrollView:scrollView];
        [cell refreshDataWithIndex:index];
        cell.delegate = self;
        return cell;
    } else {
        LXHomeListView *cell = [LXHomeListView cellWithScrollView:scrollView];
        [cell refreshDataWithIndex:index];
        cell.delegate = self;
        return cell;
    }
}

- (void)scrollView:(LXScrollView *)tableView didSelectIndex:(NSInteger)index
{
    NSLog(@"点击了第 %ld 个标签", (long)index);
}

- (void)popToPlayerVC:(id)object
{
    LXPlayerController *vc = [[LXPlayerController alloc] init];
    
    if ([object isMemberOfClass:[LXInkeHomeListModel class]]) {
        LXInkeHomeListModel *model = object;
        vc.liveUrlStr = model.stream_addr;
    } else if ([object isMemberOfClass:[LXMiaoHomeListModel class]]) {
        LXMiaoHomeListModel *model = object;
        vc.liveUrlStr = model.flv;
    } else if ([object isMemberOfClass:[LXDouyuRoomListModel class]]) {
        LXDouyuRoomListModel *model = object;
        vc.liveUrlStr = [NSString stringWithFormat:URL_DOUYU_LIVE, model.room_id, [LXHelpClass getCurrentTimeStamp]];
    } else {
        vc.liveUrlStr = URL_LIVE;
    }
    
    [self presentViewController:vc animated:YES completion:nil];
}



#pragma mark - Observer

#pragma mark - Event response

#pragma mark - Private methods

#pragma mark - Setter and getter

@end



