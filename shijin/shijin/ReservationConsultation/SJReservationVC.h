//
//  SJReservationVC.h
//  shijin
//
//  Created by apple on 13-7-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJReservationVC : UIViewController<UITextFieldDelegate>
{
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
}
@property (nonatomic, strong) NSDictionary *dataDic;
@end
