//
//  CommonDefines.h
//  shijin
//
//  Created by apple on 13-7-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#ifndef shijin_CommonDefines_h
#define shijin_CommonDefines_h

/**
 SJNetworkService
 常量定义
 */
#define WEBAPI      @"http://www.shijinzhifu.com/ios/"
#define CALLBACK_TARGET     @"target"
#define CALLBACK_SUC_SEL    @"successSelector"
#define CALLBACK_FAIL_SEL   @"errorSelector"
#define REQUEST             @"request"

/**
 用户信息
 */
#define PERSONID        @"email"
#define PASSWORD        @"password"
#define NIKENAME        @"view_name"
#define ISPAYMANT       @"ispayment"
#define USERID          @"user_id"
/**
 网络请求回传参数
 */
#define FLAG            @"flag"
#define RETURNDATA      @"data"
#define MSG             @"msg"

/**
 获取屏幕的大小
 */
#define MAINSCREENRECT      [[UIScreen mainScreen] bounds]
#define MAINSCREENWIDTH     [[UIScreen mainScreen] bounds].size.width
#define MAINSCREENHEIGHT    [[UIScreen mainScreen] bounds].size.height

/**
 文件路径
 */
#define  DOCUMENT               [NSHomeDirectory() stringByAppendingString:@"/Documents/"]
#define  CACHES                 [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/"]
#define  USER_PATH              [DOCUMENT stringByAppendingPathComponent:@"user.plist"]
/**
 设备判断
 */
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)

enum updateReservationUIFlag{
    kRESERVATIONUI_I         =   0,
    kRESERVATIONUI_II,
    kRESERVATIONUI_III,
    kRESERVATIONUI_IV,
    kRESERVATIONUI_V,
    kCOLLECTIONUI_I,
    kCOLLECTIONUI_II,
    kCOLLECTIONUI_III,
    kCOLLECTIONUI_IV,
};

enum systemFlag{
    kCOLLECTION_NORMAL         =   0,
    kCOLLECTION_REQUEST,
    kCOLLECTION_START,
    kCOLLECTION_END,
    kRESERVATION_SEND,
    kRESERVATION_UPDATA,
    kRESERVATION_START,
    kRESERVATION_END,
};
#endif
