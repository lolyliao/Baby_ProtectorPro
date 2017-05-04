//
//  MusicManager.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/22.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicManager : NSObject
@property (nonatomic, strong) NSArray *musicArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, strong) AVPlayer *player;
// 分享信息
+ (instancetype)shareInfo;
// 播放和暂停
- (void)playAndPause;
// 上一首
- (void)playPrevious;
// 下一首
- (void)playNext;
- (void)replaceItemWithUrlString:(NSString *)urlString;
// 调节音量
- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat;
// 播放进度条
- (void)playerProgressWithProgressFloat:(CGFloat)progressFloat;
@end
