//
//  LDTitleStyle.h
//  LDDPageView
//
//  Created by 李洞洞 on 22/6/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LDTitleStyle : NSObject
@property(nonatomic,assign)CGFloat titleHeight;
@property(nonatomic,strong)UIColor * normalColor;
@property(nonatomic,strong)UIColor * selectColor;
@property(nonatomic,assign)CGFloat  fontSize;
@property(nonatomic,assign)BOOL  isScrollEnable;
@property(nonatomic,assign)CGFloat  itemMargin;
@property(nonatomic,assign)BOOL  isShowScrollLine;
@property(nonatomic,assign)CGFloat  scrollLineHeight;
@property(nonatomic,strong)UIColor * scrollLineColor;
@end
