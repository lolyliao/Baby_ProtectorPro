//
//  Unit.m
//  FMDB-demo
//
//  Created by apple on 14-11-12.
//  Copyright (c) 2014年 LXH. All rights reserved.
//

#import "Unit.h"
#import "MBProgressHUD.h"
@implementation Unit

+ (void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(removeAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alert, @"alert", nil] repeats:NO];
}

+ (void)removeAlert:(NSTimer *)timer
{
    UIAlertView *alert = (UIAlertView *)[timer.userInfo objectForKey:@"alert"];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [timer invalidate];
    timer = nil;
}

//创建Label
+(UILabel*)createLable:(CGRect)frame withName:(NSString *)name withFont:(CGFloat)font textAlignt:(NSString *)alignt
{
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    if(!name)
    {
        lable.text = @"";
    }
    else
    {
        lable.text = name;
    }
    lable.font = [UIFont fontWithName:FZLTHKGBK size:font];
    lable.backgroundColor = [UIColor clearColor];
    lable.numberOfLines = 0;
    if([alignt  isEqual: @"center"]){
        lable.textAlignment = NSTextAlignmentCenter;
    }else if ([alignt isEqual: @"left"]){
            lable.textAlignment = NSTextAlignmentLeft;
    }else if ([alignt isEqual: @"right"]){
            lable.textAlignment = NSTextAlignmentRight;
    }
    return lable;
}
//创建Button
+(UIButton*)creatButton:(CGRect)frame withName:(NSString*)name normalImg:(UIImage*)normalImg highlightImg:(UIImage*)highlightImg selectImg:(UIImage*)selectImg
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    if(!name)
    {
        [button setTitle:@"" forState:UIControlStateNormal];
    }
    else
    {
        [button setTitle:name forState:UIControlStateNormal];
    }
    [button setBackgroundImage:normalImg forState:UIControlStateNormal ];
     [button setBackgroundImage:selectImg forState:UIControlStateSelected];
    [button setBackgroundImage:highlightImg forState:UIControlStateHighlighted];
    return button;
}
//创建TextField
+ (UITextField *)createTextField:(CGRect)frame withPlaceholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = placeholder;
    [textField setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
    [textField setValue:FONTFORNAVI17 forKeyPath:@"placeholderLabel.font"];
    
    textField.font = [UIFont systemFontOfSize:14];
    return textField;
}
//创建Label
+ (UITableView *)createTableView:(CGRect)frame withDelegate:(id)delegate
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    return tableView;
}
#pragma mark - layer封装
+(void)CreatView:(UIView *)_ViewName Color:(UIColor *)color cornerRadius:(NSInteger)cornerRadius
{
    _ViewName.layer.cornerRadius = cornerRadius;
    _ViewName.layer.masksToBounds = YES;
    _ViewName.layer.borderWidth     = 1.0;
    _ViewName .layer.borderColor = [color  CGColor];
}
//创建图片
+ (UIImageView *)createImageView:(CGRect)frame isRound:(BOOL)isRound
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    if(isRound)
    {
        imageView.layer.cornerRadius = frame.size.height/2;
        imageView.layer.borderWidth = 1;
        imageView.layer.borderColor = [UIColor clearColor].CGColor;
        imageView.layer.masksToBounds = YES;
    }
    return imageView;
}
//创建scrollerView
+ (UIScrollView *)createScrollView:(CGRect)frame withDelegate:(id)delegate withContentSize:(CGSize)contentSize
{
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:frame];
    scrollview.contentSize = contentSize;
    scrollview.delegate = delegate;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.bounces = NO;
    return scrollview;
}
// ***  存本地数据  *** //
+ (BOOL)saveUserDefaultsObj:(id)obj forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:obj forKey:key];
    return [userDefaults synchronize];
}
// ***  存本地数据  *** //
+ (BOOL)saveUserDefaultsInt:(NSInteger)obj forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:obj forKey:key];
    return [userDefaults synchronize];
}
// ***  取本地数据  *** //
+ (id)getUserDefaultsObjForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}
// ***  取本地数据  *** //
+ (NSInteger)getUserDefaultsIntForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:key];
}
// ***  移除本地数据  *** //
+ (BOOL)removeUserDefaultsObjForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    return [userDefaults synchronize];
}
// ***  移除本地数据  *** //
//+ (BOOL)removeUserDefaultsIntForKey:(NSString *)key {
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults removeObjectForKey:key];
//    return [userDefaults synchronize];
//}
#pragma mark --计算Lable高度
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    CGSize rtSize;
//    if(iOS7)
//    {
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
//        
//        rtSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//        return ceil(rtSize.height) + 0.5;
//    }
//    else
//    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        //FIXME: kkkk
//        rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
      rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByTruncatingTail];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
//rtSize =    [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
#pragma clang diagnostic pop

        return rtSize.height;
  //  }
}


+(NSArray *)RefrshTheData:(id)string{
    NSString *data  = [string isKindOfClass:[NSNull class]] ? @"" : string;
    NSString *requestTmp = [NSString stringWithString: data ];
    NSData *resData = [[NSData alloc]initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
    return resultDic;
}
#pragma mark --  Lable单行文字宽度
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font
{
    CGSize rtSize;
//    if(iOS7)
//    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        rtSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return ceil(rtSize.width) + 0.5;
//    }
//    else
//    {
        rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return rtSize.width;
   // }
}
#pragma mark -- 弹框
+ (void)showNetFail
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                    message:@"数据加载失败,请检查网络重新加载"
                                                   delegate:self
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark -- image的翻转
+ (UIImage *)rotateImage:(UIImage *)aImage
{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            break;
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft)
    {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else
    {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,181,189
     */
    NSString * MOBILES = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278]|47[0-8])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,181,189
     22         */
    NSString * CT = @"^1((33|53|8[019]|76)[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILES];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+ (void)showHint:(NSString *)hint
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view                  = [[UIApplication sharedApplication].delegate window];
        MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.userInteractionEnabled    = NO;
        // Configure for text only and offset down
        hud.mode                      = MBProgressHUDModeText;
        hud.labelText                 = hint;
        
        //hud.margin = 10.f;
        //hud.yOffset = iPhone5?200.f:150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    });
    
    
    
}

//邮箱
+ (BOOL)checkEmail:(NSString *)email
{
    NSString *emailRegex   = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//弹出弹框
+ (void)showAlertViewWithTitle:(NSString*)title  messsage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil,nil];
    [alert show];
    [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0];
    
    [alert show];
}

//消失
+ (void)dimissAlert:(UIAlertView *)alert
{
    if(alert)
    {
        [alert dismissWithClickedButtonIndex:0 animated:NO];
        
    }
    
}

//
//
//+(void)showNote:(UIView *)views
//{
//        CGRect frame = [UIScreen mainScreen].bounds;
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width / 2 - 140 / 2,frame.size.height / 2 - 70 / 2 , 160 , 80)];
//        label.text = @"网络不给力呀";
//        label.clipsToBounds = YES;
//        label.alpha = 0.5;
//        label.numberOfLines = 0;
//        label.layer.cornerRadius = 9;
//        label.textAlignment = NSTextAlignmentCenter;
//        label.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.502 alpha:1.000];
//        label.textColor = [UIColor whiteColor];
//        [views addSubview:label];
//        //    [UIView animateWithDuration:1 animations:^{
//        //        POPSpringAnimation *upAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
//        //        upAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(160, 80)];
//        //        upAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(120, 50)];
//        //        upAnimation.springBounciness = 15;
//        //        upAnimation.springSpeed = 14;
//        //
//        //        [label.layer pop_addAnimation:upAnimation forKey:@"upForRemove"];
//        //    } completion:^(BOOL finished) {
//        //        if (finished) {
//        POPSpringAnimation *upAnimation1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
//        upAnimation1.fromValue = [NSValue valueWithCGSize:CGSizeMake(160, 80)];
//        upAnimation1.toValue = [NSValue valueWithCGSize:CGSizeMake(120, 40)];
//        upAnimation1.springBounciness = 15;
//        upAnimation1.springSpeed = 14;
//        [label.layer pop_addAnimation:upAnimation1 forKey:@"upForRemove2"];
//
//        POPSpringAnimation *ani = [POPSpringAnimation animationWithPropertyNamed:kPOPViewAlpha];
//
//
//        ani.fromValue = @0;
//        ani.toValue = @0.4;
//        [label pop_addAnimation:ani forKey:@"upForRgemo"];
//        label.textAlignment = NSTextAlignmentCenter;
//
//
//
//        [self performSelector:@selector(remos:) withObject:label afterDelay:0.8];
//
//        //        }
//        //
//        //    }];
//
//
//
//
//
//
//
//
//
//
//
//}
//
//
//+ (void)remos:(UILabel *)label
//    {
//
//        POPSpringAnimation *upAnimation1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
//        upAnimation1.fromValue = [NSValue valueWithCGSize:CGSizeMake(120, 40)];
//        upAnimation1.toValue = [NSValue valueWithCGSize:CGSizeMake(145, 60)];
//        upAnimation1.springBounciness = 15;
//        upAnimation1.springSpeed = 14;
//        [label.layer pop_addAnimation:upAnimation1 forKey:@"upForRemove2"];
//
//        POPSpringAnimation *ani = [POPSpringAnimation animationWithPropertyNamed:kPOPViewAlpha];
//
//        ani.fromValue = @0.4;
//        ani.toValue = @0;
//        [label pop_addAnimation:ani forKey:@"upForRemo"];
//        label.textAlignment = NSTextAlignmentCenter;
//
//
//        [self performSelector:@selector(remos2:) withObject:label afterDelay:2];
//
//
//
//    }
//
//
//
//+ (void)remos2:(UILabel *)label
//{
//    [label removeFromSuperview];
//}
//


+(void)showMessage:(UIView *)views withMessage:(NSString *)message
{
    [Unit showMessage:views];
    UIView *v = [views viewWithTag:189];
    UILabel *la = (UILabel *)v;
    la.text = message;
}

/**
 *  @author guilin, 15-03-15 22:03:36
 *
 *  显示网络不给力，变小再变大的动画，然后自动淡出移除
 *
 *  @param views 传入要在显示的view
 */
+ (void)showMessage:(UIView *)views
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(views.center.x - 120 / 2,views.center.y - 80 /2, 160 , 80)];
    label.text = @"网络不给力呀";
    label.clipsToBounds = YES;
    label.alpha = 0.2;
    label.tag = 189;
    label.numberOfLines = 0;
    label.layer.cornerRadius = 9;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithWhite:0.298 alpha:1.000];
    label.textColor = [UIColor whiteColor];
    [views addSubview:label];
    [UIView animateWithDuration:0.3 animations:^{
        [UIView animateWithDuration:0.4 animations:^{
            label.alpha = 0.5;
            
            label.frame = CGRectMake(views.center.x - 120 /2,views.center.y - 50 /2, 120 , 50);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 animations:^{
                label.alpha = 0.0;
                
                label.frame = CGRectMake(views.center.x - 140 /2,views.center.y - 60 /2, 140 , 60);
                
            } completion:^(BOOL finished) {
                if(finished) {
                    [label removeFromSuperview];
                }
            }];
            
        }];
        
    } ];
    
    
    
    
}




+ (void)showHud:(UIView *)view title:(NSString *)title animated:(BOOL)isAnimated
{
    //    dispatch_main_async_safe(^{
    //        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:isAnimated];
    //        hud.labelText = title;
    //        hud.dimBackground = NO;
    //    });
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:isAnimated];
    hud.labelText = title;
    hud.dimBackground = NO;
}

+ (void)hideHud:(UIView *)view animated:(BOOL)animated
{
    //    dispatch_main_async_safe(^{
    //        [MBProgressHUD hideHUDForView:view animated:animated];
    //    });
    [MBProgressHUD hideHUDForView:view animated:animated];
}


+ (NSString *)convertToTime:(NSString *)addTime;
{
    addTime = [addTime stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:addTime];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
    
}
+ (NSString *)convertToTimeWithSecond:(NSString *)addTime
{
    addTime = [addTime stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:addTime];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)convertToUTCTime:(NSString *)addTime
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[addTime integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
    
}




+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
#define METHOD      @"Method"
#pragma mark   56上传图片set.picture.add"
#pragma mark - layer封装
+(void)CreatView:(UIView *)_ViewName Color:(UIColor *)color
{
    _ViewName.layer.cornerRadius = 10.0;
    _ViewName.layer.masksToBounds = YES;
    _ViewName.layer.borderWidth     = 1.0;
    _ViewName .layer.borderColor = [color  CGColor];
}
#pragma mark  时间  多少分前
+ (NSString *)compareCurrentTime:(NSString *)str{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
#pragma mark  时间戳转时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    NSTimeInterval time=[timeString doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+ (CGSize)getLabelSizeFortextFont:(UIFont *)font textLabel:(NSString *)text{
    NSDictionary * totalMoneydic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize totalMoneySize =[text boundingRectWithSize:CGSizeMake(SCREENWIDTH-16,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:totalMoneydic context:nil].size;
    return totalMoneySize;
}
@end
