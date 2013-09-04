//
//  SJCollectionVC.h
//  shijin
//
//  Created by apple on 13-8-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularProgressView.h"
@interface SJCollectionVC : UIViewController
{
    UIView          *_mainView;
    UILabel         *_allTime;
    UILabel         *_userFund;

    NSDictionary    *_iData;
    //请求4页面
    UIView          *_iUIViewI;
    UIView          *_iUIViewII;
    UIView          *_iUIViewIII;
    UIView          *_iUIViewIV;
    
    UILabel         *_topNameLabel;
    UILabel         *_topFundLabel;
    UILabel         *_topServiceLabel;

    CircularProgressView *_progressCircularView;
    UIButton        *_startOrEndBtn;//开始结束按钮
    NSString        *_recordTime;//记录计时时间
    
    UILabel         *_servertimeViewIV;
    UILabel         *_incomeViewIV;
    UILabel         *_fundViewIV;

}
- (void)setDataSource:(NSDictionary *)aDataSource;
- (void)updateViewUI;
@end
