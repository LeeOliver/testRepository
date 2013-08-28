//
//  SJReservationVCViewController.h
//  shijin
//
//  Created by apple on 13-7-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJReservationVC.h"
#import "SVSegmentedControl.h"

@interface SJReservationVCViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_iTable;//分类浏览
    UITextField *_emailSerch;//邮件搜索框
    BOOL isShowTable;//是否显示分类浏览
    UIView *_paymentView;//付款界面
    UIView *_receive;//收款界面
    NSArray *_dataArr;//分类浏览数据
    NSArray *_tabviewdata;//查找类别数据
    UIScrollView *_reservationList;//主要分类界面
    
    BOOL isShowWaitView;//是否显示等待界面，yes显示等待界面
    UIView *_requestView;//收款请求界面
    UIView *_waitView;//收款等待界面
    UIView *_timingView;//计时界面
    
    NSString *_serviceTime;//预约服务时间
    NSString *_requesterStr;//付款名+email
    UILabel *_requestServer;
    UILabel *_requestTime;
    
    NSDictionary *_iDataForResponstor;//收款人预约数据
    BOOL isCountTimeView;//是否显示计时界面
    UILabel *_timingTitle;//服务器状态
    UILabel *_timingTimeStr;//服务商
    UILabel *_timingLabel;//计时显示
    
    UIButton    *_btnBackGround;
}
@property (nonatomic) BOOL isShowTable;
- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl;

@end
