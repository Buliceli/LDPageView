//
//  LDTitleViewDelegate.h
//  LDDPageView
//
//  Created by 李洞洞 on 23/6/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LDTitleView;
@protocol LDTitleViewDelegate <NSObject>
- (void)titleView:(LDTitleView *)titleV targetIndex:(NSInteger)targetIndex;
@end
