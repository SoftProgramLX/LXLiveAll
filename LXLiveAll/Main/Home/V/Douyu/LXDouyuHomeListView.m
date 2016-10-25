//
//  LXDouyuHomeListView.m
//  LXLiveAll
//
//  Created by 李旭 on 16/10/24.
//  Copyright © 2016年 lixu. All rights reserved.
//

#import "LXDouyuHomeListView.h"
#import "LXDouyuHomeListModel.h"
#import "LXDouyuHomeGameCollectionCell.h"
#import "LXDouyuHomeGirlCollectionCell.h"
#import "LXDouyuHomeCollectionHeader.h"
#import "LXDouyuHomeListModel.h"

static NSString *kDouyuHomeGameCollectionCell  = @"LXDouyuHomeGameCollectionCell";
static NSString *kDouyuHomeGirlCollectionCell      = @"LXDouyuHomeGirlCollectionCell";
static NSString *kDouyuHomeCollectionHeader       = @"LXDouyuHomeCollectionHeader";
static NSString *kDouyuHomeCollectionFooter       = @"kDouyuHomeCollectionFooter";

@interface LXDouyuHomeListView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak)   UICollectionView * collectionView;
@property (nonatomic, copy)   NSMutableArray<LXDouyuHomeListModel *> *dataArr;
@property (nonatomic, copy)   NSMutableArray *headertitleArr;
@end

@implementation LXDouyuHomeListView

#pragma mark - Life cycle

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier withFrame:(CGRect)frame
{
    self = [super initWithReuseIdentifier:reuseIdentifier withFrame:frame];
    if (self) {
        self.backgroundColor = bgColor;
        
        _dataArr = [NSMutableArray array];
        _headertitleArr = [NSMutableArray array];
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
    NSString *urlStr = [NSString stringWithFormat:URL_DOUYU_HOME_LIST, [LXHelpClass getCurrentTimeStamp]];
    [LXNetWorkTool postWithUrlString:urlStr withParam:@{@"token": @"74858010_11_e85e92db03e0d351_2_63009732"} success:^(NSDictionary *responseDic) {
        DLog(@"%@", responseDic);
        NSArray *arr = [LXDouyuHomeListModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"]];
        [self.dataArr setArray:arr];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Create view

- (void)createUI
{
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection =UICollectionViewScrollDirectionVertical;
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - TITLE_HEIGHT - 49) collectionViewLayout:flow];
    collection.bounces = YES;
    collection.backgroundColor = kWhiteColor255;
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerClass:[LXDouyuHomeGameCollectionCell class] forCellWithReuseIdentifier:kDouyuHomeGameCollectionCell];
    [collection registerClass:[LXDouyuHomeGirlCollectionCell class] forCellWithReuseIdentifier:kDouyuHomeGirlCollectionCell];
    [collection registerClass:[LXDouyuHomeCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kDouyuHomeCollectionHeader];
    [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kDouyuHomeCollectionFooter];
    [self addSubview:collection];
    self.collectionView = collection;
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
//        case 0: {
//            LXDouyuHomeGirlCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDouyuHomeGirlCollectionCell forIndexPath:indexPath];
//            [cell configurationCell:self.dataArr[indexPath.section].room_list[indexPath.row]];
//            return cell;
//        } break;
            
        default: {
            LXDouyuHomeGameCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDouyuHomeGameCollectionCell forIndexPath:indexPath];
            [cell configurationCell:self.dataArr[indexPath.section].room_list [indexPath.row]];
            return cell;
        } break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(popToPlayerVC:)]) {
        [self.delegate popToPlayerVC:self.dataArr[indexPath.section].room_list[indexPath.row]];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [self.dataArr[section].room_list count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArr.count;
}

//cell间的最大间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}

//cell的宽高值
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWidth = (SCREEN_WIDTH - 5*3)/2.0;
    return CGSizeMake(cellWidth, cellWidth*0.65);
}

//cell间最小横向间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//cell间最小纵向间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//设置标头和标尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LXDouyuHomeCollectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kDouyuHomeCollectionHeader forIndexPath:indexPath];
            [headerView configurationHeader:self.dataArr[indexPath.section].tag_name];
        return headerView;
    } else {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kDouyuHomeCollectionFooter forIndexPath:indexPath];
        footerView.backgroundColor = kWhiteColor238;
        return footerView;
    }
    
    
}

//设置镖头的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 30);
}

//设置彪尾的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section != self.dataArr.count) {
        return CGSizeMake(SCREEN_WIDTH, 10);
    }
    return CGSizeZero;
}


#pragma mark - SystemDelegate



#pragma mark - CustomDelegate



#pragma mark - Observer



#pragma mark - Event response



#pragma mark - Private methods



#pragma mark - Setter and getter

@end
