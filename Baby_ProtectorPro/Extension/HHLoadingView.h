//
//  HHLoadingView.h
//  FitMent
//
//  Created by LXH on 15/10/23.
//  Copyright © 2015年 LXH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"
#define BGWIDTH    100
@interface HHLoadingView : UIView

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIView     *bgview;

@property (nonatomic,strong) LoadingView     *loadView;

+ (HHLoadingView*)shareLoading;

- (void)Loading:(UIView *)view;

- (void)stopLoading;

@end
