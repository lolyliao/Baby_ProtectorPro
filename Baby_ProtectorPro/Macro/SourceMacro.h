//
//  SourceMacro.h
//  demo
//
//  Created by gaofu on 2017/3/10.
//  Copyright © 2017年 siruijk. All rights reserved.
//

#ifndef SourceMacro_h
#define SourceMacro_h

//获取Window
#define MAIN_WINDOW [(AppDelegate *) [[UIApplication sharedApplication] delegate] window]

#define IOS10_OR_LATER	([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define IOS9_OR_LATER	([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define IOS8_OR_LATER	([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)



//实例化NibView
#define InstanceNibView [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject]
#define InstanceNibViewWithParams(className, XIBName) ((className *)[[[NSBundle mainBundle] loadNibNamed:XIBName owner:self options:nil] lastObject])

//实例化StoryBoard
#define InstanceNibViewStoryBoard [[UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([self class])]
#define InstanceNibViewStoryBoardWithParams(storyBoardName, storyBoardIdentifier) ([[UIStoryboard storyboardWithName:storyBoardName bundle:nil] instantiateViewControllerWithIdentifier:storyBoardIdentifier])

//注册cell
#define RegisterNibCell(nibName, identifier) ([self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:Identifier])
#define RegisterClassCell(cellClass, identifier) [self registerClass:[cellClass class]Class forCellWithReuseIdentifier:cellId];


//app名字
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)@"CFBundleDisplayName"]
//app版本号
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//appBulid版本号
#define APP_BUILD_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:kCFBundleVersionKey]
//appBundleId
#define APP_BUNDLE_ID [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey]


//物理屏幕
//#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
//#define SCREEN_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)

//StatusBar高度
#define STATUSBAR_HEIGHT  [UIApplication sharedApplication].statusBarFrame.size.height
//NavigationBar高度
#define NAVIGATIONBAR_HEIGHT self.navigationController.navigationBar.frame.size.height
//Tabbar高度
#define TABBAR_HEIGHT self.tabBarController.tabBar.frame.size.height


//快速生成弱引用self变量
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
#define StrongSelf(type)  __strong typeof(type) type = weak##type;


//16进制颜色
#define HexColor(hex) [UIColor colorWithHexColorString:@#hex]
#define HexAlphaColor(hex,a) [UIColor colorWithHexString:@#hex alpha:a]


//请求
#define BaseRequest(basePath,subPath) [NetworkTool postWithPath:[basePath stringByAppendingPathComponent:subPath] params:params progress:nil success:success failure:failure]

#define FileUpload(basePath,subPath) [NetworkTool postWithPath:[basePath stringByAppendingPathComponent:subPath] dataParams:dataParams params:params progress:^(NSProgress *uploadProgress) {\
progress ? progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount) : nil;\
} success:success failure:failure];

#define FileUploadWithProgress(basePath,subPath) [NetworkTool postWithPath:[basePath stringByAppendingPathComponent:subPath] dataParams:dataParams params:params progress:progress success:success failure:failure];

/**
 *  Model 打印
 */

#define MODEL_LOG(result) if ([result isKindOfClass:[NSDictionary class]])\
{\
    [result enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {\
        NSString *type;\
        if ([obj isKindOfClass:[NSString class]])  type = @"NSString*";\
        else if ([obj isKindOfClass:[NSArray class]])  type = @"NSArray*";\
        else if ([obj isKindOfClass:[NSNumber class]])  type = @"int";\
        else if ([obj isKindOfClass:[NSDictionary class]])  type = @"NSDictionary*";\
        NSString *str;\
        if ([type isEqualToString:@"NSString*"]) { str = @"copy"; }\
        else if ([type containsString:@"NS"]) { str = @"strong"; }\
        else { str = @"assign"; }\
        NSString*reStr = [NSString stringWithFormat:@"@property (nonatomic, %@) %@ %@;",str,type,key];\
        printf("\n///<#statemet#>\n%s\n",[reStr UTF8String]);\
    }];\
    printf("\n");\
}\
else\
{\
    DLog(@"打印对象不是字典");\
}

//请求打印
#define RequestStartLog NSDate *startDate = nil;\
if (DEBUG)\
{\
startDate = [NSDate date];\
}\
RLog(@"\n**************************************************开始: %@ ***************************************************",[startDate timeStringWithAll]);\
RLog(@"\n参数 == \n%@\n",params ? params.toString : @"无参数");

#define RequestProgressLog RLog(@"进度:%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);

#define RequestSuccessLog RLog(@"\n成功:result == \n%@\n",result ? result.toString : @"结果为空");\
RLog(@"**************************************************结束: %@ ***************************************************",[[NSDate date] timeStringWithAll]);\
RLog(@"**************************************************耗时: %f ***************************************************\n", -[startDate timeIntervalSinceNow]);

#define RequestFailureLog RLog(@"\n失败:error == \n%@\n",error ? error : @"错误为空");\
RLog(@"**************************************************结束: %@ ***************************************************",[[NSDate date] timeStringWithAll]);\
RLog(@"**************************************************耗时: %f ***************************************************\n", -[startDate timeIntervalSinceNow]);


#endif /* SourceMacro_h */
