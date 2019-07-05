//
//  AppDelegate.m
//  Shop
//
//  Created by 朱啸 on 2018/4/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import "GGXXYYHomeVC.h"
#import <UserNotifications/UserNotifications.h>

//推送
#define UMKey @"5d1469d90cafb212ac000bc6"
//友盟安全密钥//quvss8rcpv3jahqyajgeuspa6o1vdeqr
#define SinaAppKey @"2907325059"
#define SinaAppSecret @"6a3cb8cb1164e8b8bb1ee9ac7c674dec"
#define QQAppID @"101585946"
#define QQAppKey @"9a571fa6d596664d503bf6f500e55587"
#define WXAppID @"wx0e716e57dbe83758"
#define WXAppSecret @"8db830e769fab8da9ea028cab4fd718f"




@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    

    self.window.rootViewController=[[GGXXYYHomeVC alloc] init];

//    GGXXYYHomeVC * vc = [[GGXXYYHomeVC alloc] init];
//    self.window.rootViewController = vc;
    
    
    
    [self.window makeKeyAndVisible];
    
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMKey];
    
    [self configUSharePlatforms];
//    [self initUment:launchOptions];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *newUserAgent = [userAgent stringByAppendingString:@"/kyhios/CK 2.0"];//自定义需要拼接的字符串
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    
    [self.window makeKeyAndVisible];
    
    //
//    BOOL isQieHuan = ![self checkProductDate:@"2019-06-19"];
//
//    if (isQieHuan){
//          [self updateApp];
//    }
    return YES;
}

- (BOOL)checkProductDate: (NSString *)tempDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [dateFormatter dateFromString:tempDate];

    if ([date earlierDate:[NSDate date]] != date) {
        
        return true;
    } else {
        
        return false;
    }
    
}

- (void)configUSharePlatforms
{
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppID appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID/*设置QQ平台的appID*/  appSecret:QQAppKey redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
    
}


//- (void)updateApp {
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",@"1468639448"]];
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
//    [request setHTTPMethod:@"POST"];
//
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request
//                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//                                         if (data)
//                                         {
//                                             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//
//                                             if (dic)
//                                             {
//                                                 NSArray * arr = [dic objectForKey:@"results"];
//                                                 if (arr.count>0)
//                                                 {
//                                                     NSDictionary * versionDict = arr.firstObject;
//
//                                                     //服务器版本
//                                                     NSString * version = [[versionDict objectForKey:@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
//                                                     //当前版本
//                                                     NSString * currentVersion = [[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""];
//
//
//
//                                                     dispatch_async(dispatch_get_main_queue(), ^{
//
//                                                         if ([version integerValue] < [currentVersion integerValue]) {
//                                                             BaseNavigationController *nav=[[BaseNavigationController alloc] initWithRootViewController:[[LxmHomeVC alloc] init]];
//                                                             self.window.rootViewController=nav;
//                                                             [self.window makeKeyAndVisible];
//                                                         }else {
//                                                             GGXXYYHomeVC * vc = [[GGXXYYHomeVC alloc] init];
//                                                             self.window.rootViewController = vc;
//                                                             [self.window makeKeyAndVisible];
//                                                         }
//
//
//                                                     });
//
//                                                 }
//                                             }
//                                         }
//                                     }] resume];
//
//
//}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
