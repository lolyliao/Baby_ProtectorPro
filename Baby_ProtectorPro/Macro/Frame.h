//
//  Frame.pch
//  Fitment
//
//  Created by Easaa on 15/9/25.
//  Copyright (c) 2015年 Easaa. All rights reserved.
//

#ifndef Fitment_Frame_h
#define Fitment_Frame_h


#define AutoSizeScreenWidth_AutoSize  ([[UIScreen mainScreen] bounds].size.width)

#define AutoSizeScreenHeight_AutoSize ([[UIScreen mainScreen] bounds].size.height)

#define AutoSizeScaleX_AutoSize ((AutoSizeScreenHeight_AutoSize > 480.0) ? (AutoSizeScreenWidth_AutoSize / 320.0) : 1.0)

CG_INLINE CGFloat
AutoHeighScale(CGFloat width)
{
    CGFloat autoWidth = width * AutoSizeScaleX_AutoSize;
    return autoWidth;
}
#define autoSizeScaleX SCREENWIDTH/320
#define autoSizeScaleY SCREENHEIGHT/568
#define DevicesScale ([UIScreen mainScreen].bounds.size.height==480?1.00:[UIScreen mainScreen].bounds.size.height==568?1.00:[UIScreen mainScreen].bounds.size.height==667?1.17:1.29)
//#define AUTOIMAGESCALE SCREENHEIGHT/568

#define DEVICESCALEHEIGHT  ( [UIScreen mainScreen].bounds.size.height > 568) ? ( [[UIScreen mainScreen] bounds].size.height/667) : ([[UIScreen mainScreen] bounds].size.height/568)

#define HEIGHT5 [UIScreen mainScreen].bounds.size.height == 480
#define HEIGHT6 [UIScreen mainScreen].bounds.size.height == 667
#define HEIGHT6p [UIScreen mainScreen].bounds.size.height == 736


#define IPHINEHEIGHT4 [UIScreen mainScreen].bounds.size.height == 480
#define IPHINEHEIGHT5 [UIScreen mainScreen].bounds.size.height == 568
#define IPHINEHEIGHT6 [UIScreen mainScreen].bounds.size.height == 667
#define IPHINEHEIGHT6P [UIScreen mainScreen].bounds.size.height == 736
#endif
