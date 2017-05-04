//
//  BPSearchCell.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/27.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPSearchCell.h"

@implementation BPSearchCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10 ,self.width, 19.5)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font =FONTFZLTHK11;
        _titleLabel.textColor = COLOR_3333;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
                [self.contentView addSubview:_titleLabel];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
