//
//  LDPageView.h
//  LDDPageView
//
//  Created by 李洞洞 on 23/6/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDTitleStyle.h"
#import "LDTitleView.h"
#import "LDContentView.h"
@interface LDPageView : UIView
@property(nonatomic,strong)NSArray<NSString *> * titles;
@property(nonatomic,strong)NSArray<UIViewController*> * childVcs;
@property(nonatomic,strong)UIViewController * parentVc;
@property(nonatomic,strong)LDTitleStyle * styly;
@property(nonatomic,strong)LDTitleView * titleView;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles childVc:(NSArray*)childVcs parentVc:(UIViewController*)parentVc styly:(LDTitleStyle*)styly;

@end

















