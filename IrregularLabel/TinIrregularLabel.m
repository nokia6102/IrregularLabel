//
//  TinIrregularLabel.m
//  IrregularLabel
//
//  Created by TinXie on 2018/4/11.
//  Copyright © 2018年 TinXie. All rights reserved.
//

#import "TinIrregularLabel.h"


@interface TinIrregularLabel ()

/** 遮罩 */
@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation TinIrregularLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 初始化遮罩
        self.maskLayer = [CAShapeLayer layer];
        // 設置遮罩
        [self.layer setMask:self.maskLayer];
        // 設置相關參數
        [self setParameter];
    }
    return self;
}

/**
 複寫方法 調整文字偏移
*/
- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(3, 2, 5, 2);
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, edgeInsets)];
}

/**
 設置lab 相關參數
 */
- (void)setParameter {
    self.backgroundColor = [UIColor colorWithRed:25/255.0f green:63/255.0f blue:108/255.0f alpha:1];
    self.textAlignment = NSTextAlignmentCenter; //置中
    self.textColor = [UIColor whiteColor];
    self.text = @"";
    self.alpha = 0.9;
    self.clipsToBounds = YES;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 6.0;
}

/**
 繪製曲線
 */
- (void)changeUI {
    // 遮罩層frame
    self.maskLayer.frame = self.bounds;
    CGFloat boundsWidth  = self.bounds.size.width;
    CGFloat boundsHeight = self.bounds.size.height;
    /** 路徑 */
    UIBezierPath *borderPath = [UIBezierPath bezierPath];
    /**
     ⌜->->⌝
          ⌄
     ⌞<-<-⌟
     由左上角順時鐘走
    */
    // 設置path起點
    [borderPath moveToPoint:CGPointMake(0, 10)];
    // 左上角的圓角
    [borderPath addQuadCurveToPoint:CGPointMake(10, 0)
                       controlPoint:CGPointMake(0, 0)];
    // 直線，到右上角
    [borderPath addLineToPoint:CGPointMake(boundsWidth -10, 0)];
    // 右上角的圓角
    [borderPath addQuadCurveToPoint:CGPointMake(boundsWidth, 10)
                       controlPoint:CGPointMake(boundsWidth, 0)];
    // 直線，到右下角
    [borderPath addLineToPoint:CGPointMake(boundsWidth, boundsHeight -15)];
    // 右下角的圓角
    [borderPath addQuadCurveToPoint:CGPointMake(boundsWidth -10, boundsHeight -5)
                       controlPoint:CGPointMake(boundsWidth, boundsHeight -5)];

    // 底部的小三角形
    [borderPath addLineToPoint:CGPointMake(boundsWidth /2 +5, boundsHeight -5)];
    [borderPath addLineToPoint:CGPointMake(boundsWidth /2, boundsHeight)];
    [borderPath addLineToPoint:CGPointMake(boundsWidth /2 -5, boundsHeight -5)];

    // 直線，到左下角
    [borderPath addLineToPoint:CGPointMake(10, boundsHeight -5)];
    // 左下角的圓角
    [borderPath addQuadCurveToPoint:CGPointMake(0, boundsHeight -15)
                       controlPoint:CGPointMake(0, boundsHeight -5)];

    // 直線，回到起點
    [borderPath addLineToPoint:CGPointMake(0, 10)];

    // 將這個path 給maskLayer的path
    self.maskLayer.path = borderPath.CGPath;
}

@end
