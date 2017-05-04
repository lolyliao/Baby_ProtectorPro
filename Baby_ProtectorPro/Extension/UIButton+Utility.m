//
//  UIButton+Utility.m
//  OC-Project
//
//  Created by liuxhui on 15/7/3.
//  Copyright (c) 2015年 刘小辉. All rights reserved.
//

#import "UIButton+Utility.h"

@implementation UIButton (Utility)

- (void)normalTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}
- (void)highltTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateHighlighted];
}
- (void)selectTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateSelected];
}

- (void)normalTitleColor:(UIColor *)color;  //正常状态
{
    [self setTitleColor:color forState:UIControlStateNormal];
}
- (void)highltTitleColor:(UIColor *)color;  //高亮
{
    [self setTitleColor:color forState:UIControlStateHighlighted];
}
- (void)selectTitleColor:(UIColor *)color;  //选中
{
    [self setTitleColor:color forState:UIControlStateSelected];
}

- (void)normalImage:(NSString *)imgName
{
    [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];;
}
- (void)highltImage:(NSString *)imgName
{
    [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];;
}
- (void)selectImage:(NSString *)imgName
{
    [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateSelected];;
}
- (void)left  
{
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0); //button文字偏移量 向右偏移10
}
- (void)right
{
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10); //button文字偏移量 向左偏移10
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0); //button文字偏移量 向左偏移10
}

@end
