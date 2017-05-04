//
//  CustomDatePickerView.m
//  HKRun
//
//  Created by apple on 14/11/29.
//  Copyright (c) 2014年 com.yuntongkeji. All rights reserved.
//
#define SCREEN_HEIGHT_FULL ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#import "CustomDatePickerView.h"

@implementation CustomDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init
{
    self=[super init];
    if (self)
    {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT_FULL-240, SCREEN_WIDTH+100, 240)];

        bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_FULL);
        
        self.datePicker=[[UIDatePicker alloc]init];
        self.datePicker.frame=CGRectMake(0, 40, SCREEN_WIDTH, 200);
        self.datePicker.frame=CGRectMake(0, 0, SCREENWIDTH, 200);
        self.datePicker.backgroundColor=[UIColor whiteColor];
        self.datePicker.datePickerMode=UIDatePickerModeDate;
         [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];//默认中文
        [bgView addSubview:self.datePicker];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.frame = CGRectMake(0, 0, 80, 40);
        [bgView addSubview:cancelButton];
        
        UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [commitButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        commitButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [commitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [commitButton addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        commitButton.frame = CGRectMake(SCREEN_WIDTH-80,0 , 80, 40);
        [bgView addSubview:commitButton];
        
        
    }
    return self;
}

-(void)cancelButtonClick:(UIButton*)sender
{
     [self removeFromSuperview];
    
}
-(void)commitButtonClick:(UIButton*)sender
{
    
    NSDate *select  = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime = [dateFormatter stringFromDate:select];
    if (dateAndTime)
    {
        self.commitBlock(dateAndTime);
    }
    
    [self removeFromSuperview];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

@end
