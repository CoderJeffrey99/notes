//
//  WMMediaViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2022/12/21.
//  Copyright © 2022 zali. All rights reserved.
//

#import "WMMediaViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface WMMediaViewController ()<
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
AVAudioPlayerDelegate>

@property (strong, nonatomic) UIImagePickerController *picker;

@end

@implementation WMMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark - UIImagePickerController/选择图片类
-(void)setupImagePickerController {
    // https://blog.csdn.net/qq_36136586/article/details/79074143
    self.picker = [[UIImagePickerController alloc] init];
    // UIImagePickerControllerSourceTypePhotoLibrary从相册选择
    // UIImagePickerControllerSourceTypeCamera照相机
    // UIImagePickerControllerSourceTypeSavedPhotosAlbum
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker.delegate = self;
    // 显示控件
    [self.picker presentViewController:self.picker animated:YES completion:^{
        
    }];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // 当选择一张图片的时候会进入该方法
    UIImage *pickerImage = info[UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(pickerImage, self, nil, NULL);
    // 实现该函数以后需要手动隐藏该控件
    // 隐藏控件
    [self.picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // 隐藏控件
    [self.picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark -MPMoviePlayerController/MPMusicPlayerController
-(void)setupMoviePlayerController {
    // MPMoviePlayerController ==> AVPlayerViewController
    // https://blog.csdn.net/Dreamandpassion/article/details/82459246
    // https://www.jianshu.com/p/d8062b1856f3
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    MPMoviePlayerController *moviePlayer_vc = [[MPMoviePlayerController alloc] initWithContentURL:url];
    moviePlayer_vc.view.frame = self.view.bounds;
    moviePlayer_vc.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    moviePlayer_vc.repeatMode = YES;
    [self.view addSubview:moviePlayer_vc.view];
    [moviePlayer_vc play];
    
    // MPMusicPlayerController
}


#pragma mark - AVAudioPlayer音频播放器
// AVFoundation框架只能播放本地音频，不能在线播放：虽然可以先从网络下载资源到本地再播放，但是必须要整首歌都下载完成后才能播放
// 如果想在线播放，可以选择AudioToolbox框架中的音频队列服务Audio Queue Services：音频队列服务可以完成音频的录制和播放
// 边加载别播放、使用流媒体
/*
 流媒体：流式媒体技术
 1.概念：把连续的影像和声音信息经过压缩处理后放上网站服务器，让用户一边下载一边观看、收听，而不需要等整个压缩文件下载到自己的计算机上才可以看到的网络传输技术
 2.操作：先在使用者端的计算机上创建一个缓冲区，在播放前预先下一段数据作为缓冲
 */
-(void)setupAVAudioPlayer {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    player.delegate = self;
    // 播放之前先准备播放
    if (player.prepareToPlay) {
        // 开始播放
        [player play];
        // 暂停播放
        [player pause];
        // 停止播放
        [player stop];
    }
}
#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    
}


#pragma mark - AVAudioRecorder音频录音机
-(void)setupAVAudioRecorder {
    
}


#pragma mark - 访问相机权限
-(void)showAVCaptureDevice {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    // 用户第一次同意访问相机权限
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                    });
                } else {
                    // 用户第一次拒绝访问相机权限
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) {
            // 用户允许当前应用访问相机
        } else if (status == AVAuthorizationStatusDenied) {
            // 用户拒绝当前应用访问相机
        } else if (status == AVAuthorizationStatusRestricted) {
            // 系统原因无法访问相机
        }
    } else {
        // 未检测到您的摄像头
    }
}

@end
