//
//  LDContentView.m
//  LDDPageView
//
//  Created by 李洞洞 on 23/6/18.
//  Copyright © 2018年 Minte. All rights reserved.
//



#import "LDContentView.h"
static NSString * const kContentCellID = @"kContentCellID";
@implementation LDContentView

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}
- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc
{
    if (self = [super initWithFrame:frame]) {
        self.childVcs = childVcs;
        self.parentVc = parentVc;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    for (int i = 0; i < self.childVcs.count; i++) {
        [self.parentVc addChildViewController:self.childVcs[i]];
    }
    [self addSubview:self.collectionView];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childVcs.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIViewController * childVc = self.childVcs[indexPath.item];
    childVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVc.view];
    
    
    return cell;
}

#pragma mark --- UICollectionViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self contentEndScroll];
    scrollView.scrollEnabled = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self contentEndScroll];
    }else{
        scrollView.scrollEnabled = NO;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isForbidScroll = NO;
    self.startOffsetX = scrollView.contentOffset.x;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.startOffsetX == scrollView.contentOffset.x) {
        return;
    }
    if (self.isForbidScroll) {
        return;
    }
    
    NSInteger targetIndex = 0;
    CGFloat progress = 0.0;
    
    NSInteger currentIndex = self.startOffsetX / scrollView.bounds.size.width;
    //NSLog(@"%ld",currentIndex);
    
    if (self.startOffsetX < scrollView.contentOffset.x) { //左滑
        targetIndex = currentIndex + 1;
        if (targetIndex > self.childVcs.count - 1) {
            targetIndex = self.childVcs.count - 1;
        }
        progress = (scrollView.contentOffset.x - self.startOffsetX) / scrollView.bounds.size.width;
    }else{ //右滑
        targetIndex = currentIndex - 1;
        if (targetIndex < 0) {
            targetIndex = 0;
        }
        progress = (self.startOffsetX - scrollView.contentOffset.x) / scrollView.bounds.size.width;
    }
    
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentView:targetIndex:progress:)]) {
      
        [self.delegate contentView:self targetIndex:targetIndex progress:progress];
    }
    
}



- (void)contentEndScroll
{
    //判断是否是禁止状态
    if (self.isForbidScroll) {
        return;
    }
    
    //获取滚动到的位置
    NSInteger currentIndex = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    //NSLog(@"<<<%ld>>>",currentIndex);
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentView:targetIndex:)]) {
        [self.delegate contentView:self targetIndex:currentIndex];
    }
}
#pragma mark --- LDTitleViewDelegate
- (void)titleView:(LDTitleView *)titleV targetIndex:(NSInteger)targetIndex
{
    self.isForbidScroll = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:targetIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}
@end























