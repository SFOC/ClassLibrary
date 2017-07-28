//
//  UIButton+SFProgressView.m
//  test
//
//  Created by fly on 2017/7/11.
//  Copyright © 2017年 flyfly. All rights reserved.
//

#import "UIButton+SFProgressView.h"
#import <objc/runtime.h>

// 给属性增加key
static const void *progressKey = &progressKey;
static const void *lineWidthKey = &lineWidthKey;
static const void *lineColorKey = &lineColorKey;

@implementation UIButton (SFProgressView)
@dynamic progress;
// set方法中调用的
- (void)progress:(float)progress {
    [self setTitle:[NSString stringWithFormat:@"%0.2f%%",progress*100] forState:UIControlStateNormal];
    [self setNeedsDisplay];
}
// 绘制
- (void)drawRect:(CGRect)rect {
    CGFloat lineWidth = self.lineWidth?[self.lineWidth floatValue]:5;
    UIColor *lineColor = self.lineColor?self.lineColor:[UIColor orangeColor];
    // 创建贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radius = MIN(center.x, center.y) - lineWidth;
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = 2*M_PI*[self.progress floatValue] + startAngle;
    // 画线
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    // 设置线宽
    path.lineWidth = lineWidth;
    path.lineCapStyle = kCGLineCapRound; // 线头是半圆
    [lineColor setStroke]; // 设置线的颜色
    // 开始画
    [path stroke];
}


#pragma mark ---增加属性给分类---
// 进度的
-(NSNumber *)progress {
    return objc_getAssociatedObject(self, progressKey);
}
- (void)setProgress:(NSNumber *)progress {
    [self progress:[progress floatValue]];
    objc_setAssociatedObject(self, progressKey, progress, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

// 线条宽度的
- (NSNumber *)lineWidth {
    return objc_getAssociatedObject(self, lineWidthKey);
}

- (void)setLineWidth:(NSNumber *)lineWidth {
    objc_setAssociatedObject(self, lineWidthKey, lineWidth, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
// 线条颜色的
- (UIColor *)lineColor {
    return objc_getAssociatedObject(self, lineColorKey);
}

- (void)setLineColor:(UIColor *)lineColor {
    objc_setAssociatedObject(self, lineColorKey, lineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
