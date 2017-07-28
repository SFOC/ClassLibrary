//
//  UIButton+SFProgressView.h
//  test
//
//  Created by fly on 2017/7/11.
//  Copyright © 2017年 flyfly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SFProgressView)
/*!
 进度 0.0 - 1.0
 */
@property (nonatomic, copy) NSNumber *progress;

/*!
 进度条颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/*!
 进度条宽度
 */
@property (nonatomic, copy) NSNumber *lineWidth;
@end
