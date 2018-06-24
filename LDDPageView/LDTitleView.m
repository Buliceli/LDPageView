//
//  LDTitleView.m
//  LDDPageView
//
//  Created by 李洞洞 on 22/6/18.
//  Copyright © 2018年 Minte. All rights reserved.
//



#import "LDTitleView.h"
#import "UIView+XMGExtension.h"


@interface LDTitleView ()
@property(nonatomic,strong)NSArray * normalColorRGB;
@property(nonatomic,strong)NSArray * selectedColorRGB;
@end
@implementation LDTitleView
- (NSArray *)normalColorRGB
{
    if (_normalColorRGB) {
        return _normalColorRGB;
    }else{
        return [self getRGBWithColor:self.style.normalColor];
    }
}
- (NSArray<NSNumber*> *)selectedColorRGB
{
    if (_selectedColorRGB) {
        return _selectedColorRGB;
    }else{
        return [self getRGBWithColor:self.style.selectColor];
    }
    
}
- (void)normalColorRGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b
{
    [self getRGBWithColor:self.style.normalColor];
}
- (NSArray*)getRGBWithColor:(UIColor*)color
{
    CGColorRef  cgcolor = color.CGColor;
    const CGFloat *colorComponents = CGColorGetComponents(cgcolor);
    if (!colorComponents) {
        NSLog(@"请使用RGB方式给Title赋值颜色");
    }
   
    return @[@(colorComponents[0] * 255),@(colorComponents[1] * 255),@(colorComponents[2] *255)];
    
}
- (NSMutableArray<UILabel *> *)titleLabels
{
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
       
    }
    return _scrollView;
}
- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = self.style.scrollLineColor;
        
        _bottomLine.xmg_height = self.style.scrollLineHeight;
        _bottomLine.xmg_y = self.bounds.size.height - self.style.scrollLineHeight;

     }
    return _bottomLine;
}
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles style:(LDTitleStyle*)style
{
    if (self = [super initWithFrame:frame]) {
        
        self.titles = titles;
        self.style = style;
        [self setUpUI];
     }
    return self;
}
- (void)setUpUI
{
    
    [self addSubview:self.scrollView];
    
    [self setUpTitleLabels];
    
    [self setupTitleLabelsFrame];
    
    if (self.style.isShowScrollLine) {
        [self setBottomLine];
    }
    
    self.backgroundColor = [UIColor lightGrayColor];
}
- (void)setBottomLine
{
    [self.scrollView addSubview:self.bottomLine];
    UILabel * firstL = self.titleLabels.firstObject;
    self.bottomLine.frame = firstL.frame;
    CGRect rect = self.bottomLine.frame;
    rect.size.height = self.style.scrollLineHeight;
    rect.size.width = rect.size.width * 1;
    
    rect.origin.y = self.bounds.size.height - self.style.scrollLineHeight;
    self.bottomLine.frame = rect;
    self.bottomLine.xmg_centerX = firstL.xmg_centerX;
    
}
#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define HWRandomColor HWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

- (void)setUpTitleLabels
{
    for (int i = 0; i < self.titles.count; i++) {
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = self.titles[i];
        titleLabel.font = [UIFont systemFontOfSize:self.style.fontSize];
        titleLabel.tag = i;
        titleLabel.textAlignment = YES;
        titleLabel.textColor = i == 0 ? self.style.selectColor : self.style.normalColor;
        [self.scrollView addSubview:titleLabel];
        [self.titleLabels addObject:titleLabel];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelClick:)];
        [titleLabel addGestureRecognizer:tap];
        titleLabel.userInteractionEnabled = YES;
    }
}
- (void)adaptiveLayout
{
    CGFloat margin = (5 - self.titles.count)*(self.bounds.size.width / 5) / (self.titles.count + 1);
    for (int i = 0; i < self.titleLabels.count; i++) {
        UILabel * subLabel = self.titleLabels[i];
        CGFloat w = 0;
        CGFloat h = self.bounds.size.height;
        CGFloat x = 0;
        CGFloat y = 0;
        w = self.bounds.size.width / 5;
        x = i * w + margin * (i+1);
        if (i == 0 && self.style.isShowScrollLine) {
            UILabel * firstL = self.titleLabels[0];
            CGRect rect = self.bottomLine.frame;
            rect.size.width = w * 1;
            CGPoint point = self.bottomLine.center;
            point.x = firstL.center.x;
            self.bottomLine.frame = rect;
            self.bottomLine.center = point;
        }
         subLabel.frame = CGRectMake(x, y, w, h);
    }
    
    self.scrollView.contentSize = self.style.isScrollEnable ? CGSizeMake(CGRectGetMaxX(self.titleLabels.lastObject.frame) + self.style.itemMargin * 0.5, 0) : CGSizeZero;
    
}
- (void)setupTitleLabelsFrame
{
    if (self.titles.count < 5) {
        
        [self adaptiveLayout];
        
        return;
     }
    NSInteger count = self.titles.count;
    for (int i = 0; i < self.titleLabels.count; i++) {
        UILabel * subLabel = self.titleLabels[i];
        CGFloat w = 0;
        CGFloat h = self.bounds.size.height;
        CGFloat x = 0;
        CGFloat y = 0;
        if (self.style.isScrollEnable) { // 可以滑动
            w = [UIScreen mainScreen].bounds.size.width / 5;
            if (i == 0) {
                x = self.style.itemMargin * 0.5;
                
                if (self.style.isShowScrollLine) {
                    CGRect rect = self.bottomLine.frame;
                    rect.size.width = w * 1;
                    CGPoint point = self.bottomLine.center;
                    point.x = w * 0.5;
                    self.bottomLine.center = point;
                    self.bottomLine.frame = rect;
                }
                
            }else{
                
                UILabel * label = self.titleLabels[i - 1];
                x = CGRectGetMaxX(label.frame) + self.style.itemMargin;
            }
            
        }else{
            w = self.bounds.size.width / count;
            x = w * i;
            if (i == 0 && self.style.isShowScrollLine) {
                UILabel * firstL = self.titleLabels[0];
                CGRect rect = self.bottomLine.frame;
                rect.size.width = w * 1;
                CGPoint point = self.bottomLine.center;
                point.x = firstL.center.x;
                self.bottomLine.frame = rect;
                self.bottomLine.center = point;
                

            }
        }
        
        subLabel.frame = CGRectMake(x, y, w, h);
    }
    
    
    self.scrollView.contentSize = self.style.isScrollEnable ? CGSizeMake(CGRectGetMaxX(self.titleLabels.lastObject.frame) + self.style.itemMargin * 0.5, 0) : CGSizeZero;
    
    
}
- (void)titleLabelClick:(UITapGestureRecognizer *)tap
{
    UILabel * targetLabel = (UILabel *)tap.view;
    
    UILabel * sourceLabel = self.titleLabels[self.currentIndex];
    CGFloat scaleDelte = 0.2 * 1.0;
    sourceLabel.transform = CGAffineTransformIdentity;
    targetLabel.transform = CGAffineTransformMakeScale(1.0 + scaleDelte, 1.0 + scaleDelte);
    
    //调整title
    [self adjustTitleLabel:targetLabel.tag];
    
    //调整bottomLine
    if (self.style.isShowScrollLine) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = self.bottomLine.frame;
            rect.origin.x = targetLabel.frame.origin.x;
            rect.size.width = targetLabel.frame.size.width * 1;
            CGPoint point = self.bottomLine.center;
            point.x = targetLabel.center.x;
            self.bottomLine.frame = rect;
            self.bottomLine.center = point;
        }];
    }
    //通知代理
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleView:targetIndex:)]) {
        [self.delegate titleView:self targetIndex:self.currentIndex];
    }
    
    
}
- (void)adjustTitleLabel:(NSInteger)index
{
    if (index == self.currentIndex) {
        return;
    }
    //取出label
    UILabel * targetLabel = self.titleLabels[index];
    UILabel * sourceLabel = self.titleLabels[self.currentIndex];
    //切换文字颜色
    targetLabel.textColor = self.style.selectColor;
    sourceLabel.textColor = self.style.normalColor;
    
    self.currentIndex = index;
    
    //调整位置
    if (self.style.isScrollEnable) {
        CGFloat offsetX = targetLabel.center.x - self.scrollView.bounds.size.width * 0.5;
        if (offsetX < 0) {
            offsetX = 0;
        }
        if (offsetX > (self.scrollView.contentSize.width - self.scrollView.bounds.size.width)) {
            offsetX = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
        }
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
}

#pragma mark --- LDContentViewDelegate
- (void)contentView:(LDContentView *)contentView targetIndex:(NSInteger)targetIndex
{
    [self adjustTitleLabel:targetIndex];
    
}

- (void)contentView:(LDContentView *)contenView targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress
{
    UILabel * targetLabel = self.titleLabels[targetIndex];
    UILabel * sourceLabel = self.titleLabels[self.currentIndex];
#if 1
    //颜色渐变
    CGFloat r = [self.selectedColorRGB[0] integerValue] - [self.normalColorRGB[0] integerValue];
    CGFloat g = [self.selectedColorRGB[1] integerValue] - [self.normalColorRGB[1] integerValue];
    CGFloat b = [self.selectedColorRGB[2] integerValue] - [self.normalColorRGB[2] integerValue];
    //变化sourceLabel
    sourceLabel.textColor = [UIColor colorWithRed:([self.selectedColorRGB[0] integerValue] - r * progress) / 255 green:([self.selectedColorRGB[1] integerValue] - g * progress) / 255 blue:([self.selectedColorRGB[2] integerValue] - b * progress) / 255 alpha:1];
    //变化targetLabel
    targetLabel.textColor = [UIColor colorWithRed:([self.normalColorRGB[0] integerValue] + r * progress) / 255 green:([self.normalColorRGB[1] integerValue] + g * progress) / 255 blue:([self.normalColorRGB[2] integerValue] + b * progress) / 255 alpha:1];
#endif

    //bottomLine渐变
    if (self.style.isShowScrollLine) {
        
        CGFloat deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
        CGFloat deltaW = targetLabel.frame.size.width - sourceLabel.frame.size.width;
        
        self.bottomLine.xmg_x = sourceLabel.frame.origin.x + deltaX * progress;
        self.bottomLine.xmg_width = sourceLabel.frame.size.width + deltaW * progress;
    }
    //缩放
    CGFloat scaleDelte = 0.2 * progress;
    sourceLabel.transform = CGAffineTransformMakeScale(1.2 - scaleDelte, 1.2 - scaleDelte);
    targetLabel.transform = CGAffineTransformMakeScale(1.0 + scaleDelte, 1.0 + scaleDelte);
}

@end































