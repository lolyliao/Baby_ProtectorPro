//
//  CustomDatePickerView.h
//  HKRun
//
//  Created by apple on 14/11/29.
//  Copyright (c) 2014年 com.yuntongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDatePickerView : UIView

@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,copy,readwrite)void(^commitBlock)(NSString *resulet);
@end
