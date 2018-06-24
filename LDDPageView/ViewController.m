//
//  ViewController.m
//  LDDPageView
//
//  Created by 李洞洞 on 22/6/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import "ViewController.h"
#import "LDPageView.h"

#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define HWRandomColor HWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray * titles = @[@"游戏1",@"游戏2",@"游戏3",@"游戏4"];
    
    LDTitleStyle * style = [[LDTitleStyle alloc]init];
    style.isShowScrollLine = YES;
    if (titles.count > 5) {
        style.isScrollEnable = YES;
    }else{
        style.isScrollEnable = NO;
    }
    style.titleHeight = 54;
    
    NSMutableArray * childVcs = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        UIViewController * vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = HWRandomColor;
        [childVcs addObject:vc];
    }
    
    CGRect pageRect = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    LDPageView * pageView = [[LDPageView alloc]initWithFrame:pageRect titles:titles childVc:childVcs parentVc:self styly:style];
    
    [self.view addSubview:pageView];
    
    
    
    
}


@end

















