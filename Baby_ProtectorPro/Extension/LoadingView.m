//
//  LoadingView.m
//  Rotate360
//
//  Created by LXH on 15/10/24.
//  Copyright © 2015年 LXH. All rights reserved.
//

#import "LoadingView.h"
#import "UIView+i7Rotate360.h"
@implementation LoadingView
{
    UIImageView *imgView ;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        if (imgView)
        {
            [imgView removeFromSuperview];
        }
        else
        {
            imgView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 20, 44, 44)];
            [self addSubview:imgView];
        }
        
        imgView.image = [UIImage imageNamed:@"icon_refresh"];
        
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.BottomY+10, 100, 20)];
        lab.text = @"加载中...";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:14 ];
        lab.textColor = GREEN_COLOR;
        [self addSubview:lab];
        [imgView rotate360WithDuration:1 repeatCount:10000 timingMode:i7Rotate360TimingModeEaseInEaseOut];
        
    }
    return self;
}

@end
