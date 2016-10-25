//
//  LXScrollView.m
//  LXScrollerCacheChildVC
//
//  Created by 李旭 on 16/8/24.
//  Copyright © 2016年 LX. All rights reserved.
//

#import "LXScrollView.h"
#import "ScrollChildHeader.h"
#import "LXListScrollView.h"

@interface LXScrollView ()<UIScrollViewDelegate>
{
    CGFloat titleWidth;
    NSInteger lastIndex;
    NSInteger newIndex;
    BOOL showing;
}
@property (nonatomic, weak) UIScrollView *titleScroll;      //顶部所有标签的view
@property (nonatomic, weak) UIButton *selectButton;         //记录选中的按钮
@property (nonatomic, weak) UIView *indicatorView;          //标签底部红色指示器
@property (nonatomic, strong) NSMutableArray *buttonArray;  //储存所有标签按钮
@property (nonatomic, weak) UIScrollView *contentView;      //内容视图
@property (nonatomic, copy) NSMutableDictionary *cacheChildVCDic;   //缓存池里的cell数据，key为cellId
@property (nonatomic, copy) NSMutableArray *showChildVCArr;         //显示在界面上的cell数组

@end

@implementation LXScrollView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _buttonArray = [NSMutableArray array];
        _cacheChildVCDic = [NSMutableDictionary dictionary];
        _showChildVCArr = [NSMutableArray array];
        lastIndex = 0;
        newIndex = 0;
        showing = NO;
    }
    return self;
}

#pragma mark - Interface

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    [self setupTitlesView];
    [self setupContentView];
}

- (nullable __kindof LXListScrollView *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    //先取显示中的cell
    if (lastIndex > newIndex) {//如果向右滑动
        for (int i = 0; i < self.showChildVCArr.count; i++) {
            LXListScrollView *cell = self.showChildVCArr[i];
            if (cell.x/SCREEN_WIDTH == newIndex) {//if成立说明这个cell还是显示在界面上的
                showing = YES;
                return cell;
            } else if (cell.x/SCREEN_WIDTH > newIndex){
                break;
            }
        }
    } else {
        for (int i = (int)self.showChildVCArr.count - 1; i >= 0; i--) {
            LXListScrollView *cell = self.showChildVCArr[i];
            if (cell.x/SCREEN_WIDTH == newIndex) {
                showing = YES;
                return cell;
            } else if (cell.x/SCREEN_WIDTH < newIndex){
                break;
            }
        }
    }
    
    //再取缓存中的cell
    NSArray *cellArr = [self.cacheChildVCDic objectForKey:identifier];
    if (cellArr.count > 0) {
        //随意取一个相同id的cell返回
        return [cellArr firstObject];
    }
    
    return nil;
}

#pragma mark - Create view

/**
 *  设置顶部的标签栏
 */
- (void)setupTitlesView
{
    [self setTitleWidth];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*2, TITLE_HEIGHT)];
    titleView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [self addSubview:titleView];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TITLE_HEIGHT)];
    scroll.contentSize = CGSizeMake(titleWidth*_titleArray.count, TITLE_HEIGHT);
    scroll.bounces = NO;
    scroll.scrollEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.backgroundColor = [UIColor whiteColor];
    [self addSubview:scroll];
    _titleScroll = scroll;
    
    for (int i = 0; i < _titleArray.count; i++) {
        
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(titleWidth*i, 0, titleWidth, TITLE_HEIGHT);
        [titleButton setTitle:_titleArray[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        titleButton.backgroundColor = RANDOM_COLOR;
        titleButton.tag = 100+i;
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:titleButton];
        
        if (i == 0) {
            _selectButton = titleButton;
            [_selectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _selectButton.titleLabel.font = [UIFont systemFontOfSize:18];
        }
        [_buttonArray addObject:titleButton];
    }
    
    //滑块
    UIView *sliderV=[[UIView alloc]initWithFrame:CGRectMake(0, TITLE_HEIGHT-1, titleWidth, 1)];
    sliderV.backgroundColor = [UIColor redColor];
    [scroll addSubview:sliderV];
    self.indicatorView=sliderV;
}

/**
 *  显示内容的scrollerView
 */
- (void)setupContentView
{
    CGFloat contentViewY = self.titleScroll.height;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = CGRectMake(0, contentViewY, SCREEN_WIDTH, self.height - contentViewY);
    contentView.delegate = self;
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(contentView.width * self.titleArray.count, self.height - contentViewY);
    [self insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    if (index != self.selectButton.tag-100) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
        [self selectButtonWithIndex:index];
    }
}

#pragma mark - Enent response

- (void)titleClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(scrollView:didSelectIndex:)]) {
        [self.delegate scrollView:self didSelectIndex:button.tag-100];
    }
    
    self.contentView.contentOffset = CGPointMake(SCREEN_WIDTH*(button.tag-100), 0);//这会触发代理方法scrollViewDidScroll:
    [self selectButtonWithIndex:button.tag-100];
}

#pragma mark - Private methods

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    if (self.titleArray.count <= index) {
        return;
    }
    
    newIndex = index;
    
    if ([self.delegate respondsToSelector:@selector(scrollView:cellForIndex:)]) {
        [self manageData];
        
        LXListScrollView *cell = [self.delegate scrollView:self cellForIndex:index];
        [self refreshCellFrame:cell withIndex:index];
    }
}

- (void)selectButtonWithIndex:(NSInteger)index
{
    [self changeSelectButtonSatusWithIndex:index];
    
    if (self.titleCanScroll) {
        CGRect rect = [self.selectButton.superview convertRect:self.selectButton.frame toView:self];
        [UIView animateWithDuration:0 animations:^{
            self.indicatorView.x = titleWidth*index;
            CGPoint contentOffset = self.titleScroll.contentOffset;
            if (contentOffset.x - (SCREEN_WIDTH/2-rect.origin.x-titleWidth/2)<=0) {
                [self.titleScroll setContentOffset:CGPointMake(0, contentOffset.y) animated:YES];
            } else if (contentOffset.x - (SCREEN_WIDTH/2-rect.origin.x-titleWidth/2)+SCREEN_WIDTH>=_titleArray.count*titleWidth) {
                [self.titleScroll setContentOffset:CGPointMake(_titleArray.count*titleWidth-SCREEN_WIDTH, contentOffset.y) animated:YES];
            } else {
                [self.titleScroll setContentOffset:CGPointMake(contentOffset.x - (SCREEN_WIDTH/2-rect.origin.x-titleWidth/2), contentOffset.y) animated:YES];
            }
        }];
    }
}

- (void)changeSelectButtonSatusWithIndex:(NSInteger)index
{
    [self.selectButton setTitleColor:DEFAULT_TITLE_COLOR forState:UIControlStateNormal];
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (self.buttonArray.count <= index) {
        return;
    }
    
    lastIndex = index;
    self.selectButton = self.buttonArray[index];
    [self.selectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [UIView animateWithDuration:.025 animations:^{
        self.indicatorView.x = titleWidth*index;
    }];
}

- (void)refreshCellFrame:(LXListScrollView *)cell withIndex:(NSInteger)index
{
    cell.x = index * SCREEN_WIDTH;
    cell.height = self.contentView.height;
    [self.contentView addSubview:cell];
    
    if (showing) {
        showing = NO;
    } else {
        if (index > lastIndex) {
            [self.showChildVCArr addObject:cell];
        } else {
            [self.showChildVCArr insertObject:cell atIndex:0];
        }
        
        //将cell从缓存池中移除
        [[self.cacheChildVCDic objectForKey:cell.reuseIdentifier] removeObject:cell];
    }

    NSLog(@"\nall:%@\nshow:%@", self.cacheChildVCDic, self.showChildVCArr);
}

- (void)manageData
{
    //判断滑动方向，因为self.showChildVCArr的数据是根据X坐标升序排列的
    if (lastIndex < newIndex) {
        for (int i = 0; i < self.showChildVCArr.count; i++) {
            LXListScrollView *cell = self.showChildVCArr[i];
            
            if (cell.x/SCREEN_WIDTH < newIndex-1) {
                //判断了此cell已经没有显示在屏幕上
                [self changeDataWithCell:cell];
                i--;
            } else {
                break;
            }
        }
    } else {
        for (int i = (int)self.showChildVCArr.count - 1; i >= 0 && self.showChildVCArr.count > 0; i--) {
            LXListScrollView *cell = self.showChildVCArr[i];
            
            if (cell.x/SCREEN_WIDTH > newIndex+1) {
                //判断了此cell已经没有显示在屏幕上
                [self changeDataWithCell:cell];
            } else {
                break;
            }
        }
    }
}

- (void)changeDataWithCell:(LXListScrollView *)cell
{
    [self.showChildVCArr removeObject:cell];
    if ([self.cacheChildVCDic objectForKey:cell.reuseIdentifier] == nil) {
        [self.cacheChildVCDic setObject:[NSMutableArray array] forKey:cell.reuseIdentifier];
    }
    
    //将cell添加到缓存池中
    [[self.cacheChildVCDic objectForKey:cell.reuseIdentifier] addObject:cell];
}

- (void)setTitleWidth
{
    titleWidth = SCREEN_WIDTH/self.titleArray.count;
    //根据判断标签栏能否滚动去设置标签按钮的宽
    if (self.titleCanScroll) {
        if (100*self.titleArray.count > SCREEN_WIDTH) {
            titleWidth = 100;
        } else {
            self.titleCanScroll = NO;
        }
    }
}

@end


