//
//  LDContentView.h
//  LDDPageView
//
//  Created by 李洞洞 on 23/6/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDTitleView.h"
#import "LDContentViewDelegate.h"
#import "LDTitleViewDelegate.h"
//@class LDContentView;
//@protocol LDContentViewDelegate <NSObject>
//- (void)contentView:(LDContentView *)contentView targetIndex:(NSInteger)targetIndex;
//- (void)contentView:(LDContentView *)contenView targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;
//
//@end
@interface LDContentView : UIView <UICollectionViewDataSource,UICollectionViewDelegate,LDTitleViewDelegate>
@property(nonatomic,assign)id<LDContentViewDelegate>  delegate;
@property(nonatomic,strong)NSArray<UIViewController*> * childVcs;
@property(nonatomic,strong)UIViewController * parentVc;
@property(nonatomic,assign)CGFloat  startOffsetX;
@property(nonatomic,assign)BOOL  isForbidScroll;
@property(nonatomic,strong)UICollectionView * collectionView;

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray*)childVcs parentVc:(UIViewController *)parentVc;

@end





























