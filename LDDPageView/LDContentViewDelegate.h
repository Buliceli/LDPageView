//
//  LDContentViewDelegate.h
//  LDDPageView
//
//  Created by 李洞洞 on 23/6/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LDContentView;
@protocol LDContentViewDelegate <NSObject>
- (void)contentView:(LDContentView *)contentView targetIndex:(NSInteger)targetIndex;
- (void)contentView:(LDContentView *)contenView targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;
@end
