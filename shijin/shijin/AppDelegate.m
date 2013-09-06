//
//  AppDelegate.m
//  shijin
//
//  Created by apple on 13-7-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "SJMainLogin.h"
#import "SJSigninVC.h"
#import "SJRegisteredVC.h"
@implementation AppDelegate
@synthesize tabBarController    = _tabBarController;
@synthesize personalVC          = _personalVC;
@synthesize reservationVC       = _reservationVC;
@synthesize kUIflag             = _kUIflag;
@synthesize circularCountTime   = _circularCountTime;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
//    [self StartTimer];
    [UIApplication sharedApplication].idleTimerDisabled = YES;//防止锁屏
    stopTime = 0;
    _circularCountTime = @"0";
    [NetWorkEngine shareInstance].isPayment = YES;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = [[SJPersonalCenterVC alloc]init];
    [self autoLogin];
    [self.window makeKeyAndVisible];
    return YES;
}
 
- (BOOL)testLocalWiFi
{
    //檢測網絡鏈接狀況
    if (([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable) &&
        ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable))
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)autoLogin
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        SJGuideVC *mainView = [[SJGuideVC alloc]init];
        self.window.rootViewController = mainView;

    }
    else{
        if ([self testLocalWiFi]) {
            if ([self isLoginInfo]) {
                [self mainAction];
            }
            else{
                SJMainLogin *mainView = [[SJMainLogin alloc]init];
                self.window.rootViewController = mainView;
            }
        }else{
            [self showAlert:@"提醒!" andMessage:@"您没开网，请联网继续!"];
        }
    }
}

- (void)mainAction
{
    [[NetWorkEngine shareInstance]addLastLoginTimeByUserId:[NetWorkEngine shareInstance].personID];
    //预约咨询
    UINavigationController *reservationNavi;
    UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTitle:@"预约咨询"
                                                            image:[UIImage imageNamed:@"tabbar_01.png"]
                                                              tag:0];
    reservationNavi.tabBarItem = firstItem;
    if (_reservationVC == nil)
    {
        _reservationVC = [[SJReservationVCViewController alloc]init];
        reservationNavi = [[UINavigationController alloc]initWithRootViewController:_reservationVC];
    }
    
    //个人中心
    UINavigationController *centerNavi;
    UITabBarItem *secondItem = [[UITabBarItem alloc] initWithTitle:@"个人中心"
                                                             image:[UIImage imageNamed:@"tabbar_02.png"]
                                                               tag:1];
    centerNavi.tabBarItem = secondItem;
    centerNavi.navigationBar.tintColor = [UIColor colorWithRed:0.27 green:0.38 blue:0.36 alpha:1.0f];
    if (_personalVC == nil)
    {
        _personalVC = [[SJPersonalCenterVC alloc]init];
        centerNavi = [[UINavigationController alloc]initWithRootViewController:_personalVC];
    }

    self.tabBarController = [[RXCustomTabBar alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:reservationNavi,centerNavi,nil];
    self.window.rootViewController = nil;
    self.window.rootViewController = self.tabBarController;
//    [self.window makeKeyAndVisible];

}
#pragma -Mark tabbar Set
///重置tabitem
-(void)replaceFirdtNavicontroller:(UINavigationController *)newNavi  withFri:(SJPersonalCenterVC *)fvc
{
    _personalVC = (SJPersonalCenterVC *)fvc;
    UINavigationController *theNavi = (UINavigationController *)newNavi;
    theNavi.navigationBar.tintColor = [UIColor colorWithRed:0.27 green:0.38 blue:0.36 alpha:1.0f];
    NSMutableArray *midArr = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
    [midArr replaceObjectAtIndex:0 withObject:theNavi];
    NSArray *newArr = [NSArray arrayWithArray:midArr];
    self.tabBarController.viewControllers = newArr;
}
///是否從fri模塊返回
-(BOOL)getBackFlag
{
    BOOL flag = self.tabBarController.flag;
    return flag;
}
- (void)hideTabBar
{
    [self.tabBarController hideNewTabBar];
}
- (void)showTabBar
{
    [self.tabBarController ShowNewTabBar];
}
+(AppDelegate *)App
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"1111");
    self.kSystemFlag = kRESERVATION_END;
    switch (self.kSystemFlag) {
        case kRESERVATION_SEND:
        case kCOLLECTION_START:
        {
            [[NetWorkEngine shareInstance]meetingEndByResponserId:[NetWorkEngine shareInstance].userID andRequesterId:[NetWorkEngine shareInstance].userID andMeetingStart:@"S" delegate:self sel:@selector(aa)];

        }
            break;
        case kRESERVATION_UPDATA:
        {
            
        }
            break;
        case kRESERVATION_START:
        {
            
        }
            break;
        case kRESERVATION_END:
        {
            [[NetWorkEngine shareInstance]stopRequestByResponserId:[NetWorkEngine shareInstance].userID andRequesterId:[NetWorkEngine shareInstance].userID delegate:self sel:@selector(aa)];

        }
            break;
        default:
            break;
    }
    [[NetWorkEngine shareInstance] meetingStartByResponserId:[NetWorkEngine shareInstance].userID andRequesterId:[NetWorkEngine shareInstance].userID andMeetingStart:@"Y" delegate:self sel:@selector(aaa)];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"2222");
    
    switch (self.kSystemFlag) {
        case kCOLLECTION_END:
        case kCOLLECTION_NORMAL:
        case kCOLLECTION_REQUEST:
        case kCOLLECTION_START:
        {
            self.kUIflag = kCOLLECTIONUI_I;
        }
            break;
        case kRESERVATION_END:
        case kRESERVATION_SEND:
        case kRESERVATION_START:
        case kRESERVATION_UPDATA:
        {
            self.kUIflag = kRESERVATIONUI_I;
        }
            break;
        default:
            break;
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)isLoginInfo
{
    NSFileManager *fileMng = [NSFileManager defaultManager];
    BOOL  plistExist = [fileMng fileExistsAtPath:USER_PATH];
    NSMutableDictionary *dic;
    if (plistExist)
    {
        dic = [[NSMutableDictionary alloc]initWithContentsOfFile:USER_PATH];
        if (dic && ![dic isKindOfClass:[NSNull class]]) {
            [NetWorkEngine shareInstance].personID = [dic objectForKey:PERSONID];
            [NetWorkEngine shareInstance].password = [dic objectForKey:PASSWORD];
            [NetWorkEngine shareInstance].isPayment = [[dic objectForKey:ISPAYMANT] boolValue];
            [NetWorkEngine shareInstance].nikename = [dic objectForKey:NIKENAME];
            [NetWorkEngine shareInstance].userID = [dic objectForKey:USERID];
            [NetWorkEngine shareInstance].isFlag = YES;
            return YES;
        }
    }
    return NO;
}

- (void)saveUserInfoByEmail:(NSString *)sEmail
                andPassword:(NSString *)sPassword
                 andPayment:(BOOL)payment
                    andName:(NSString *)sName
{
    NSNumber *npayment = [[NSNumber alloc]initWithBool:payment];
    if (!sName || [sName isKindOfClass:[NSNull class]]) {
        if ([NetWorkEngine shareInstance].nikename && ![[NetWorkEngine shareInstance].nikename isKindOfClass:[NSNull class]]) {
            sName = [NetWorkEngine shareInstance].nikename;
        }else{
            sName = @"";
        }

    }
    NSDictionary *dic = @{PERSONID: sEmail, PASSWORD: sPassword, ISPAYMANT: npayment, NIKENAME: sName, USERID: [NetWorkEngine shareInstance].userID};
    [dic writeToFile:USER_PATH atomically:NO];
}

- (void)deleteUserInfo
{
    _reservationVC = nil;
    _personalVC = nil;
    DeleteSingleFile(USER_PATH);
}
/** Delete a file **/
BOOL DeleteSingleFile(NSString *filePath){
    NSError *err = nil;
    
    if (nil == filePath) {
        return NO;
    }
    
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    
    if (![appFileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    
    if (![appFileManager isDeletableFileAtPath:filePath]) {
        return NO;
    }
    
    return [appFileManager removeItemAtPath:filePath error:&err];
}

- (void)hidenNavigation:(UINavigationController *)nav
{
    nav.navigationBarHidden = YES;
}
- (void)showNavigation:(UINavigationController *)nav
{
    nav.navigationBarHidden = NO;
}

- (UIView *)creatNavigationView
{
    UIView *retView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    retView.backgroundColor = [[UIColor alloc]initWithRed:22/255.0f green:121/255.0f blue:146/255.0f alpha:1.0f];
    
    UIImageView *logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"center_logo.png"]];
    logo.frame = CGRectMake(0, 0, 77, 32);
    logo.center = CGPointMake(44, 25);
    [retView addSubview:logo];
    
    return retView;
}

- (void)showAlert:(NSString *)title andMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alert show];
}

///啓動計時器
- (void)StartTimer
{
    _codeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];//*//300
    mTime = 0;
}
- (void)timerAdvanced:(NSTimer *)timer
{
    
    NSLog(@"%d",mTime);
    if(mTime >= stopTime){
        [self stopCodeTimer];
    }
    mTime++;

    //处理某些逻辑
    //在某处将 mTime重设为0
}

- (void)setStopTime:(int)iStopTime
{
    stopTime = iStopTime;
}

///停止計時器
- (void)stopCodeTimer
{
    mTime = 0;
    stopTime = 0;
//    if (_codeTimerTarget)
//        [_codeTimerTarget  performSelector:_codeTimerAction];
    if([_codeTimer isValid])
        [_codeTimer invalidate];
}

- (void)signinAction
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromLeft;
    [self.window.layer addAnimation:animation forKey:@"animation"];

    SJSigninVC *signinView = [[SJSigninVC alloc]init];
    self.window.rootViewController = signinView;
}
- (void)registerAction
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromRight;
    [self.window.layer addAnimation:animation forKey:@"animation"];

    SJRegisteredVC *registerView = [[SJRegisteredVC alloc]init];
    self.window.rootViewController = registerView;
}

- (void)jumpToReservationVC
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromTop;
    [self.window.layer addAnimation:animation forKey:@"animation"];


    [self mainAction];
    [self.tabBarController selectTab:0];
}

/**
 根據給定的壓縮比例進行圖片壓縮
 @param  image 需要壓縮的圖片
 @param  scaleFloat 制定的壓縮比例
 @return UIImage* 壓縮后的圖片
 */
+ (UIImage *) clipImage: (UIImage *)image clipSize:(CGSize)clipSize
{
    float clipFloatX=clipSize.width/image.size.width;
    float clipFloatY=clipSize.height/image.size.height;
    float clipFloat = clipFloatX>clipFloatY ? clipFloatX : clipFloatY;
    
    CGSize size = clipSize;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    transform = CGAffineTransformScale(transform, clipFloat, clipFloat);
    CGContextConcatCTM(context, transform);
    
    // Draw the image into the transformed context and return the image
    //20121204Modify移动图片到中间显示
    if((image.size.height-(((image.size.height*clipFloat-clipSize.height)/2.0)/clipFloat)*clipFloat) > clipSize.height&&clipFloatY<clipFloat)
    {
        [image drawAtPoint:CGPointMake(0.0f, -((image.size.height*clipFloat-clipSize.height)/2.0)/clipFloat)];
    }
    else if((image.size.width*clipFloat-(((image.size.width*clipFloat-clipSize.width)/2.0)/clipFloat)*clipFloat) > clipSize.width&&clipFloatX<clipFloat)
    {
        [image drawAtPoint:CGPointMake(-((image.size.width*clipFloat-clipSize.width)/2.0)/clipFloat,0.0f)];
    }
    else
    {
        [image drawAtPoint:CGPointMake(0.0f,0.0f)];
    }
    //20121204Modify
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

+ (UIImageView*)fullCellBackground
{
    UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cell_background" ofType:@"png"]];
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:9 topCapHeight:9]];
    return bubbleImageView;
}

@end
