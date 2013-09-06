//
//  AppDelegate.h
//  shijin
//
//  Created by apple on 13-7-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJPersonalCenterVC.h"
#import "RXCustomTabBar.h"
#import "SJPersonalCenterVC.h"
#import "SJReservationVCViewController.h"
#import "Reachability.h"
#import "SJGuideVC.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>
{
    RXCustomTabBar                  *_tabBarController;///根控制器
    SJReservationVCViewController   *_reservationVC;//咨询主页
    SJPersonalCenterVC              *_personalVC;//个人中心
    NSTimer                         *_codeTimer;//计时器
    int                             mTime;//时间
    int                             stopTime;//计时上限
    NSString                        *_circularCountTime;//计时器计时
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RXCustomTabBar                *tabBarController;///根控制器
@property (strong, nonatomic) SJPersonalCenterVC            *personalVC;
@property (strong, nonatomic) SJReservationVCViewController *reservationVC;
@property (strong ,nonatomic) NSTimer *codeTimer;
@property (nonatomic) int kUIflag;
@property (nonatomic) int kSystemFlag;
@property (strong ,nonatomic) NSString                      *circularCountTime;//计时器计时
///數據共享
+(AppDelegate *)App;
///网络测试
- (BOOL)testLocalWiFi;
///tabbar隐藏显示
- (void)hideTabBar;
- (void)showTabBar;

///登陆
- (BOOL)isLoginInfo;
- (void)saveUserInfoByEmail:(NSString *)sEmail
                andPassword:(NSString *)sPassword
                 andPayment:(BOOL)payment
                    andName:(NSString *)sName;

- (void)deleteUserInfo;


- (void)hidenNavigation:(UINavigationController *)nav;
- (void)showNavigation:(UINavigationController *)nav;

- (UIView *)creatNavigationView;

- (void)showAlert:(NSString *)title andMessage:(NSString *)message;

///定时器开始
- (void)StartTimer;
- (void)setStopTime:(int)stopTime;
- (void)stopCodeTimer;

- (void)autoLogin;
- (void)signinAction;
- (void)registerAction;
- (void)jumpToReservationVC;

/** 壓縮到指定的尺寸，完全填充不會有空白 */
+ (UIImage *) clipImage: (UIImage *)image clipSize:(CGSize)clipSize;
+ (UIImageView*)fullCellBackground;

@end
