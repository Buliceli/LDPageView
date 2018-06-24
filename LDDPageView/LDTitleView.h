//
//  LDTitleView.h
//  LDDPageView
//
//  Created by 李洞洞 on 22/6/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDTitleStyle.h"
#import "LDContentView.h"
#import "LDTitleViewDelegate.h"
#import "LDContentViewDelegate.h"
//@class LDTitleView;
//@protocol LDTitleViewDelegate <NSObject>
//- (void)titleView:(LDTitleView *)titleV targetIndex:(NSInteger)targetIndex;
//@end

@interface LDTitleView : UIView <LDContentViewDelegate>
@property(nonatomic,assign)id<LDTitleViewDelegate>  delegate;
@property(nonatomic,strong)NSArray<NSString *> * titles;
@property(nonatomic,strong)LDTitleStyle * style;
@property(nonatomic,assign)NSInteger  currentIndex;
@property(nonatomic,strong)NSMutableArray<UILabel *> * titleLabels;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIView * bottomLine;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles style:(LDTitleStyle*)style;
@end













