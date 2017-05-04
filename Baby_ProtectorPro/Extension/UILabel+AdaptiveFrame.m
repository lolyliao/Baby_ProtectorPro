//
//  UILabel+AdaptiveFrame.m
//  WhiteLife
//
//  Created by baoxiuyizhantong on 15/6/15.
//  Copyright (c) 2015年 BX. All rights reserved.
//

#import "UILabel+AdaptiveFrame.h"

@implementation UILabel (AdaptiveFrame)

- (CGSize)boundingRectWithSize:(CGSize)size
{
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attribute = @{NSFontAttributeName:self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return retSize;
}

@end
