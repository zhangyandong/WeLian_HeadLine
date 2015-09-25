//
//  AppDelegate.m
//  WeLian_HeadLine
//
//  Created by weLian on 15/6/6.
//  Copyright (c) 2015年 杭州传送门网络科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsListViewController.h"
#import "ShareEngine.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate

//设置数据库转移
- (void)copyDefaultStoreIfNecessary
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:kStoreName];
    
    // If the expected store doesn't exist, copy the default store.
    if (![fileManager fileExistsAtPath:[storeURL path]])
    {
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:[kStoreName stringByDeletingPathExtension] ofType:[kStoreName pathExtension]];
        if (defaultStorePath)
        {
            NSError *error;
            BOOL success = [fileManager copyItemAtPath:defaultStorePath toPath:[storeURL path] error:&error];
            if (!success)
            {
                DLog(@"Failed to install default recipe store");
            }
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //数据库操作
    [self copyDefaultStoreIfNecessary];
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelVerbose];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:kStoreName];
    
    // 友盟统计
    [self umengTrack];
    
    // [2]:注册APNS
//    [self registerRemoteNotification];
    // 添加微信分享
    [[ShareEngine sharedShareEngine] registerApp];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    // 设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //统一导航条样式
    UIFont* font = [UIFont boldSystemFontOfSize:20.f];
    NSDictionary* textAttributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:RGB(43.f, 94.f, 171.f)];
    
    //登录
    NewsListViewController *newsListVC = [[NewsListViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:newsListVC];
    self.window.rootViewController = nav;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //启动效果
    //iOS6 默认图片
    UIImage *launchImage = [UIImage imageNamed:@"LaunchImage"];
    if(Iphone5) {//iPhone5/5s/5c
        launchImage = [UIImage imageNamed:@"LaunchImage-700-568h"];
    }else if (Iphone6) {//iPhone6：
        launchImage = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (Iphone6plus) {//iPhone6 plus 竖屏
        launchImage = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h"];
    }else {//iPhone4/4s:
        launchImage = [UIImage imageNamed:@"LaunchImage-700"];
    }
    UIImageView *launchView = [[UIImageView alloc] initWithImage:launchImage];
    [self.window addSubview:launchView];
    CGAffineTransform oldTransform = self.window.rootViewController.view.transform;
    self.window.rootViewController.view.transform = CGAffineTransformScale(oldTransform, 1.6f, 1.6f);
    
    [UIView animateWithDuration:.6f delay:.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        launchView.alpha = .0f;
        self.window.rootViewController.view.transform = oldTransform;
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
    
    return YES;
}

#pragma mark - 友盟统计
- (void)umengTrack {
    
    [MobClick setCrashReportEnabled:YES]; // 如果不需要捕捉异常，注释掉此行
    //    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:UMENG_ChannelId];
}

- (void)registerRemoteNotification
{
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}


//注册用户通知设置
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}


-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.description rangeOfString:@"wechat"].length>0) {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.description rangeOfString:@"wechat"].length>0) {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

- (void) onResp:(BaseResp *)resp
{
    //    WXSuccess           = 0,    /**< 成功    */
    //    WXErrCodeCommon     = -1,   /**< 普通错误类型    */
    //    WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
    //    WXErrCodeSentFail   = -3,   /**< 发送失败    */
    //    WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
    //    WXErrCodeUnsupport  = -5,   /**< 微信不支持    */
    int64_t delayInSeconds = 1.0;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        if([resp isKindOfClass:[SendMessageToWXResp class]]){
            switch (resp.errCode) {
                case WXSuccess:
                    [WLHUDView showSuccessHUD:@"分享成功！"];
                    break;
                case WXErrCodeCommon:
                    [WLHUDView showErrorHUD:@"分享失败！"];
                    break;
                case WXErrCodeUserCancel:
                    [WLHUDView showErrorHUD:@"取消分享！"];
                    break;
                default:
                    break;
            }
        }
    });
}

- (void)onReq:(BaseReq *)req
{
    DLog(@"%@",req);
}

@end
