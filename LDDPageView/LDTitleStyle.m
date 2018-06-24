//
//  LDTitleStyle.m
//  LDDPageView
//
//  Created by 李洞洞 on 22/6/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import "LDTitleStyle.h"
#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@implementation LDTitleStyle
- (CGFloat)titleHeight
{
    if (_titleHeight) {
        return _titleHeight;
    }
    return 44;
}
- (UIColor *)normalColor
{
    if (_normalColor) {
        return _normalColor;
    }
    return HWColor(0, 0, 0);
}
- (UIColor *)selectColor
{
    if (_selectColor) {
        return _selectColor;
    }
    return HWColor(250, 127, 0);
}
- (CGFloat)fontSize
{
    if (_fontSize) {
        return _fontSize;
    }
    return 15.0;
}
- (BOOL)isScrollEnable
{
    if (_isScrollEnable) {
        return _isScrollEnable;
    }
    return NO;
}
- (CGFloat)itemMargin
{
    if (_itemMargin) {
        return _itemMargin;
    }
    return 30;
}
- (BOOL)isShowScrollLine
{
    if (_isShowScrollLine) {
        return _isShowScrollLine;
    }
    return NO;
}
- (CGFloat)scrollLineHeight
{
    if (_scrollLineHeight) {
        return _scrollLineHeight;
    }
    return 2;
}
- (UIColor *)scrollLineColor
{
    if (_scrollLineColor) {
        return _scrollLineColor;
    }
    return [UIColor orangeColor];
}
@end
