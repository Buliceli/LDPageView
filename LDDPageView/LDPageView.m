//
//  LDPageView.m
//  LDDPageView
//
//  Created by 李洞洞 on 23/6/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import "LDPageView.h"

@implementation LDPageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles childVc:(NSArray *)childVcs parentVc:(UIViewController *)parentVc styly:(LDTitleStyle *)styly
{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.childVcs = childVcs;
        self.parentVc = parentVc;
        self.styly = styly;
        [self setUpUI];
        
    }
    return self;
}
- (void)setUpUI
{
    [self setUpTitleView];
    [self setUpContentView];
}
- (void)setUpTitleView
{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.styly.titleHeight);
    self.titleView = [[LDTitleView alloc]initWithFrame:rect titles:self.titles style:self.styly];
    
    
    [self addSubview:self.titleView];
    
}
- (void)setUpContentView
{
    CGRect contentFrame = CGRectMake(0, self.styly.titleHeight, self.bounds.size.width, self.bounds.size.height - self.styly.titleHeight);
    LDContentView * contentView = [[LDContentView alloc]initWithFrame:contentFrame childVcs:self.childVcs parentVc:self.parentVc];
    [self addSubview:contentView];
    
    //设置代理
    self.titleView.delegate = contentView;
    contentView.delegate = self.titleView;
}
@end



















