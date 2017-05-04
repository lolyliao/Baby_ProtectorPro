//
//  UIView+Frame.m
//  Journey
//
//  Created by liuxhui on 15/7/27.
//  Copyright (c) 2015年 liuxhui. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

/**
 *  改变View的frame 或者其中一个或者多个属性
 *
 *  @param x x 改变x坐标
 */

- (void)setX:(CGFloat)x             /** 改变x坐标 */
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setY:(CGFloat)y             /** 改变y坐标 */
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)width     /** 改变宽度 */
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height    /** 改变高度 */
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setOrigin:(CGPoint)origin    /** 改变x和y的坐标 */
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame =frame;
}
- (void)setSize:(CGSize)size         /** 改变frame */
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGFloat)x
{
    return CGRectGetMinX(self.frame);
}
- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}
- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}
- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}
- (CGPoint)origin
{
    return self.frame.origin;
}
- (CGSize)size
{
    return self.frame.size;
}


//获取view的坐标
- (CGSize)Size
{
    return self.frame.size;
}
- (CGFloat)Width        /** 获取宽度 */
{
  return  CGRectGetWidth(self.frame);
}
- (CGFloat)Heigh
{
    return CGRectGetHeight(self.frame);
}
- (CGFloat)TopY         /** 获取上面的y坐标 */
{
    return CGRectGetMinY(self.frame);
}
- (CGFloat)BottomY      /** 获取下面的y坐标 */
{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)LeftX        /** 获取左边的x坐标 */
{
    return CGRectGetMinX(self.frame);
}
- (CGFloat)RightX       /** 获取右边的y坐标 */
{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)CenterX        /** 获取左边的x坐标 */
{
    return CGRectGetMidX(self.frame);
}
- (CGFloat)CenterY       /** 获取右边的y坐标 */
{
    return CGRectGetMidY(self.frame);
}
@end
