//
//  HHLoadingView.m
//  FitMent
//
//  Created by LXH on 15/10/23.
//  Copyright © 2015年 LXH. All rights reserved.
//

#import "HHLoadingView.h"
#import "UIImage+GIF.h"
#import "LoadingView.h"
@implementation HHLoadingView
{
    LoadingView *loadview;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}
+(HHLoadingView *)shareLoading
{
    static HHLoadingView *loadingView;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        loadingView = [[HHLoadingView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        loadingView.backgroundColor = RGB_A(0, 0, 0, 0.2);
        
    });
    
    return loadingView;
}
//- (UIImageView *)imageView
//{
//    if (!_imageView)
//    {
//        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.bgview.width - 64)/2, 20, 64, 64)];
//        _imageView.image = [UIImage sd_animatedGIFNamed:@"loding"];
//        
//    }
//    return _imageView;
//}

- (void)Loading:(UIView *)view
{
    

#if  0
    [[HHLoadingView shareLoading] addSubview:self.bgview];
    UILabel *lable = [Unit createLable:CGRectMake(0, self.imageView.BottomY+10, self.bgview.width, 14) withName:@"数据加载中..." withFont:14];
    [_bgview addSubview:self.imageView];
    [_bgview addSubview:lable];
    
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor blackColor];
     [view addSubview:self.bgview];
#else
    loadview = [[LoadingView alloc] initWithFrame:CGRectMake((SCREENWIDTH -BGWIDTH)/2,(SCREENHEIGHT -BGWIDTH)/2, BGWIDTH, BGWIDTH)];
    
    [[HHLoadingView shareLoading] addSubview:loadview];
    
#endif

    
    [view addSubview:[HHLoadingView shareLoading]];
   
}
- (UIView*)bgview
{
    if (!_bgview)
    {
        _bgview = [[UIView alloc] initWithFrame:CGRectMake((SCREENWIDTH -BGWIDTH)/2,(SCREENHEIGHT -BGWIDTH)/2, BGWIDTH, BGWIDTH)];;
//        _bgview.backgroundColor = RGB_A(26, 184, 149, 1);
        _bgview.backgroundColor = [UIColor clearColor];
        _bgview.layer.cornerRadius = 5;
        _bgview.clipsToBounds = YES;
    }
    return _bgview;
}
- (void)stopLoading
{
    [[HHLoadingView shareLoading] removeFromSuperview];
    
    //移除LoadView的子view 避免重复
    for (id view in loadview.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self.bgview removeFromSuperview];
}

@end
