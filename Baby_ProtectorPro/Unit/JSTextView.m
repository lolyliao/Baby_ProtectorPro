//
//  JSTextView.m
//  FitMent
//
//  Created by 张煜 on 15/12/18.
//  Copyright © 2015年 LXH. All rights reserved.
//

#import "JSTextView.h"

@interface JSTextView ()

@property (nonatomic,weak) UILabel *placeholderLabel;

@end
@implementation JSTextView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    self.backgroundColor = [UIColor clearColor];
    UILabel *placeholderLabel = [[UILabel alloc]init];
    placeholderLabel.backgroundColor = [UIColor clearColor];
    placeholderLabel.numberOfLines = 0;
    [self addSubview:placeholderLabel];
    
    _placeholderLabel = placeholderLabel;
    _myPlaceholderColor = [UIColor lightGrayColor];
    self.font = [UIFont fontWithName:@"Arial" size:13];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}
-(void)textDidChange{
    _placeholderLabel.hidden = self.hasText;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.placeholderLabel.y=8; //设置UILabel 的 y值
    
    self.placeholderLabel.x=5;//设置 UILabel 的 x 值
    
    self.placeholderLabel.width=self.width-self.placeholderLabel.x*2.0; //设置 UILabel 的 x
    
    //根据文字计算高度
    
    CGSize maxSize =CGSizeMake(self.placeholderLabel.width,MAXFLOAT);
    
    self.placeholderLabel.height= [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    
}
- (void)setMyPlaceholder:(NSString*)myPlaceholder{
    
    _myPlaceholder= [myPlaceholder copy];
    
    //设置文字
    
    self.placeholderLabel.text= myPlaceholder;
    
    //重新计算子控件frame
    
    [self setNeedsLayout];
    
}
-(void)setMyPlaceholderColor:(UIColor *)myPlaceholderColor{
    _myPlaceholderColor = myPlaceholderColor;
    _placeholderLabel.textColor = myPlaceholderColor;
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    _placeholderLabel.font = font;
    [self setNeedsLayout];
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self textDidChange];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
}
@end
