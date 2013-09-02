//
//  SJReservationVC.h
//  shijin
//
//  Created by apple on 13-7-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularProgressView.h"
@interface SJReservationVC : UIViewController<UITextFieldDelegate>
{
    UIButton        *_backBtn;//返回按钮
    
    UIView          *_mainView;
    NSDictionary    *_dataDic;
    NSString        *_fund;
    UILabel         *_userFund;
    UILabel         *_allTime;
    UITextField     *_hours;
    UITextField     *_minutes;
    //请求4页面
    UIView          *_iUIViewI;
    UIView          *_iUIViewII;
    UIView          *_iUIViewIII;
    UIView          *_iUIViewIV;

    UILabel         *_serverTime;
    int             _kTotalTimeS;//秒
    int             _kTotalTimeM;//分
    double          _kCountFund;//金额
    
    UIButton    *_btnBackGround;
    
    int             _selectM;//选测预约分钟
    
    CircularProgressView *_progressCircularView;
    UIButton        *_startOrEndBtn;//开始结束按钮
    NSString        *_recordTime;//记录计时时间
}
@property (nonatomic, strong) NSDictionary *dataDic;
@end
