//
//  BPNavView.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/14.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPNavView.h"

@implementation BPNavView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        self.backgroundColor = [UIColor colorwithHexString:@"#ffcccc"];
 
        //        self.backgroundColor = [UIColor clearColor];
        
        
        _backBtn = [Unit creatButton:CGRectMake(0, 20,  50, 50) withName:nil normalImg:nil highlightImg:nil selectImg:nil];
        [_backBtn setImage:[UIImage imageNamed:@"back-b"] forState:UIControlStateNormal];
        _backBtn.contentMode = UIViewContentModeCenter;
        [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 10)];
        _backBtn.hidden = YES;
        [self addSubview:_backBtn];
        

        _titleLab = [Unit createLable:CGRectMake(0, 33, SCREENWIDTH, 18)  withName:@"呱儿百科" withFont:13 textAlignt:@"center"];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [_titleLab setTextColor:[UIColor whiteColor]];
        CGFloat width = [Unit widthWithString:_titleLab.text font:_titleLab.font];
        
//        _titleLab.width = width;
//        
//        _titleLab.x = SCREENWIDTH/2-_titleLab.width/2;
        
        [self addSubview:_titleLab];
        
        _midView = [[UIView alloc]initWithFrame:CGRectMake(53*DevicesScale, 28, SCREENWIDTH-106*DevicesScale, 34)];
        _midView.hidden = YES;
        [self addSubview:_midView];
        
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH-44, 20, 44, 44)];
        //        [_rightBtn normalTitle:@"关注"];
        
        [_rightBtn normalTitleColor:[UIColor blackColor]];
        
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_rightBtn];
        
        _rightNearBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH-44-30,30, 30, 30)];
        [_rightNearBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self addSubview:_rightNearBtn];
        
        
        _ToplineView = [[UIView alloc]initWithFrame:CGRectMake(0,63.5, SCREENWIDTH, 0.5)];
        _ToplineView.backgroundColor = [UIColor colorwithHexString:@"a3a3a3"];
//        [self addSubview:_ToplineView];
        _ToplineView.hidden = YES;
        
    }
    return self;
}

@end
