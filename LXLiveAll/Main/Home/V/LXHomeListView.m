//
//  LXHomeListView.m
//  LXLiveAll
//
//  Created by 李旭 on 16/10/21.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "LXHomeListView.h"
#import "LXInkeHomeListModel.h"
#import "LXHomeListCell.h"
#import "LXMiaoHomeListModel.h"

@interface LXHomeListView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak)   UITableView *tableView;
@property (nonatomic, copy)   NSMutableArray *dataArr;
@end

@implementation LXHomeListView

#pragma mark - Life cycle

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier withFrame:(CGRect)frame
{
    self = [super initWithReuseIdentifier:reuseIdentifier withFrame:frame];
    if (self) {
        self.backgroundColor = bgColor;
        
        _dataArr = [NSMutableArray array];
        [self createUI];
    }
    
    return self;
}

#pragma mark - Interface

- (void)refreshDataWithIndex:(NSInteger)index
{
    [self downloadData:index];
}

#pragma mark - Loading data

- (void)downloadData:(NSInteger)index
{
    switch (index) {
        case 0: {
            [LXNetWorkTool getWithUrlString:URL_INKE_HOME_LIST withParam:nil success:^(NSDictionary *responseDic) {
                DLog(@"%@", responseDic);
                NSArray *arr = [LXInkeHomeListModel mj_objectArrayWithKeyValuesArray:responseDic[@"lives"]];
                [self.dataArr setArray:arr];
                [self.tableView reloadData];
            } failure:^(NSError *error) {
                
            }];
        } break;
            
        case 1: {
            [LXNetWorkTool getWithUrlString:[NSString stringWithFormat:URL_MIAO_HOME_LIST, 1] withParam:nil success:^(NSDictionary *responseDic) {
                DLog(@"%@", responseDic);
                NSArray *arr = [LXMiaoHomeListModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
                [self.dataArr setArray:arr];
                [self.tableView reloadData];
            } failure:^(NSError *error) {
                
            }];
        } break;
            
        default: break;
    }
}

#pragma mark - Create view

- (void)createUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height - TITLE_HEIGHT) style:UITableViewStylePlain];
    tableView.backgroundColor = kWhiteColor255;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXHomeListCell *cell = [LXHomeListCell cellWithTableView:tableView];
    [cell configurationCell:self.dataArr[indexPath.section]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(popToPlayerVC:)]) {
        [self.delegate popToPlayerVC:self.dataArr[indexPath.section]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHomeListCellH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


#pragma mark - SystemDelegate

#pragma mark - CustomDelegate

#pragma mark - Observer

#pragma mark - Event response

#pragma mark - Private methods

#pragma mark - Setter and getter
@end
