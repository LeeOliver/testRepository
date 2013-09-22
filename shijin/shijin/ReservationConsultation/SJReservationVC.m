//
//  SJReservationVC.m
//  shijin
//
//  Created by apple on 13-7-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJReservationVC.h"
#define KSHOWUIONE      405
#define KSHOWUITWO      406
#define KSHOWUITHREE    407
#define KSHOWUIFOUR     408
@interface SJReservationVC ()
@end

@implementation SJReservationVC
@synthesize dataDic = _dataDic;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *topView = [[AppDelegate App] creatNavigationView];
    //查找类别返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"backbtn.png"] forState:UIControlStateNormal];
    _backBtn.tag = 1002;
    [_backBtn addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
    _backBtn.frame = CGRectMake(9, 7, 40, 30);
    _backBtn.center = CGPointMake(MAINSCREENWIDTH-45, 22);
    [topView addSubview:_backBtn];
    [self.view addSubview: topView];
    
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, MAINSCREENWIDTH, MAINSCREENHEIGHT-50-50-20)];
    _mainView.backgroundColor = [UIColor colorWithRed:224.0/255.0f green:225.0/255.0f blue:218.0/255.0f alpha:1.0f];
    [self.view addSubview:_mainView];
    [self initUIOne];
    [self updateViewUI];
    _fund = @"0";
    [[NetWorkEngine shareInstance] getBalanceByUserID:[NetWorkEngine shareInstance].userID delegate:self sel:@selector(getsumdata:)];
    
    _btnBackGround = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnBackGround.frame = self.view.frame;
    _btnBackGround.backgroundColor = [UIColor clearColor];
    _btnBackGround.userInteractionEnabled = NO;
    [_btnBackGround addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnBackGround];
    [self.view bringSubviewToFront:_btnBackGround];
	// Do any additional setup after loading the view.
}
- (void)getsumdata:(NSString*)idata
{
    _fund = idata;
    _userFund.text = [NSString stringWithFormat:@"账户当前余额:$%@",_fund];
    _allTime.text = [NSString stringWithFormat:@"当前可购买的服务时间:%.2f分钟",([_fund doubleValue]/[[_dataDic objectForKey:@"com_rate"]doubleValue])];
    [self updateViewUI];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//发送请求
- (void)initUIOne
{
    ////////uiview 1
    if (_iUIViewI) {
        return;
    }
    _iUIViewI = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _mainView.frame.size.width, _mainView.frame.size.height)];
    _iUIViewI.backgroundColor = [UIColor clearColor];
    _iUIViewI.tag = KSHOWUIONE;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _mainView.frame.size.width, 110)];
    topView.backgroundColor = [UIColor colorWithRed:38.0/255.0f green:147.0/255.0f blue:176.0/255.0f alpha:1.0f];
    UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(18, 18, 74, 74)];
    imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_image.png"]];
    [topView addSubview:imageView];
    [_iUIViewI addSubview:topView];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 25, 210, 25)];
    title1.text = [NSString stringWithFormat:@"%@/%@",[_dataDic objectForKey:@"nickName"],[_dataDic objectForKey:@"email"] ];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.textColor = [UIColor whiteColor];
    title1.backgroundColor = [UIColor clearColor];
    title1.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:title1];

    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, 210, 25)];
    title2.text = [NSString stringWithFormat:@"服务类别:%@",[_dataDic objectForKey:@"user_commodity"] ];
    title2.textAlignment = NSTextAlignmentLeft;
    title2.textColor = [UIColor whiteColor];
    title2.backgroundColor = [UIColor clearColor];
    title2.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:title2];
    
    UIView *mainbox = [[UIView alloc]init];
    mainbox.backgroundColor = [UIColor clearColor];
    [_iUIViewI addSubview:mainbox];
    mainbox.frame = CGRectMake(0, 110, _mainView.frame.size.width, _mainView.frame.size.height-110);
    for (int i = 1; i < 4; i++) {
        UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reservation_line.png"]];
        line.frame = CGRectMake(0, i*45, 320, 1);
        [mainbox addSubview:line];
    }

    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(13, 10, 26, 26)];
    view3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_rate.png"]];
    [mainbox addSubview:view3];
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 270, 25)];
    title3.text = [NSString stringWithFormat:@"费率:$%@/每分钟",[_dataDic objectForKey:@"com_rate"]];
    title3.textAlignment = NSTextAlignmentLeft;
    title3.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title3.backgroundColor = [UIColor clearColor];
    title3.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title3];

    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(13, 55, 26, 26)];
    view4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_buy_time.png"]];
    [mainbox addSubview:view4];

    _allTime = [[UILabel alloc]initWithFrame:CGRectMake(50, 55, 270, 25)];
    _allTime.text = @"当前可购买的服务时间:0分钟";
    _allTime.textAlignment = NSTextAlignmentLeft;
    _allTime.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    _allTime.backgroundColor = [UIColor clearColor];
    _allTime.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:_allTime];

    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(13, 99, 26, 26)];
    view5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_ appointment_time.png"]];
    [mainbox addSubview:view5];

    UILabel *title5 = [[UILabel alloc]initWithFrame:CGRectMake(50, 99, 270, 25)];
    title5.text = @"预约服务时间(              )hours(              )minutes";
    title5.textAlignment = NSTextAlignmentLeft;
    title5.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title5.backgroundColor = [UIColor clearColor];
    title5.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title5];

    _hours = [[UITextField alloc]initWithFrame:CGRectMake(132, 100, 40, 25)];
    _hours.delegate = self;
    _hours.textAlignment = NSTextAlignmentCenter;
    [mainbox addSubview:_hours];
    _hours.keyboardType = UIKeyboardTypeNumberPad;

    _minutes = [[UITextField alloc]initWithFrame:CGRectMake(215, 100, 40, 25)];
    _minutes.delegate = self;
    _minutes.textAlignment = NSTextAlignmentCenter;
    [mainbox addSubview:_minutes];
    _minutes.keyboardType = UIKeyboardTypePhonePad;
    
    UIView *view6 = [[UIView alloc]initWithFrame:CGRectMake(13, 145, 26, 26)];
    view6.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_account_balance.png"]];
    [mainbox addSubview:view6];

    _userFund = [[UILabel alloc]initWithFrame:CGRectMake(50, 145, 280, 25)];
    _userFund.text = [NSString stringWithFormat:@"账户当前余额:$0"];
    _userFund.textAlignment = NSTextAlignmentLeft;
    _userFund.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    _userFund.backgroundColor = [UIColor clearColor];
    _userFund.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:_userFund];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"reservation_send_request.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(sendTempMeeting) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(67, MAINSCREENHEIGHT-50-30-20-15, 186, 30);
    searchBtn.center = CGPointMake(MAINSCREENWIDTH/2, 345);
    [_iUIViewI addSubview:searchBtn];
}
//等待回应
- (void)initUITwo
{
    ////////uiview 2
    if (_iUIViewII) {
        return;
    }

    _iUIViewII = [[UIView alloc]initWithFrame:_iUIViewI.frame];
    _iUIViewII.backgroundColor = [UIColor clearColor];
    _iUIViewII.tag = KSHOWUITWO;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _mainView.frame.size.width, 110)];
    topView.backgroundColor = [UIColor colorWithRed:38.0/255.0f green:147.0/255.0f blue:176.0/255.0f alpha:1.0f];
    UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(18, 18, 74, 74)];
    imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_image.png"]];
    [topView addSubview:imageView];
    [_iUIViewII addSubview:topView];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 25, 210, 25)];
    title1.text = [NSString stringWithFormat:@"%@/%@",[_dataDic objectForKey:@"nickName"],[_dataDic objectForKey:@"email"] ];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.textColor = [UIColor whiteColor];
    title1.backgroundColor = [UIColor clearColor];
    title1.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:title1];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, 210, 25)];
    title2.text = [NSString stringWithFormat:@"服务类别:%@",[_dataDic objectForKey:@"user_commodity"] ];
    title2.textAlignment = NSTextAlignmentLeft;
    title2.textColor = [UIColor whiteColor];
    title2.backgroundColor = [UIColor clearColor];
    title2.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:title2];
    
    UIView *mainbox = [[UIView alloc]init];
    mainbox.backgroundColor = [UIColor clearColor];
    [_iUIViewII addSubview:mainbox];
    mainbox.frame = CGRectMake(0, 110, _mainView.frame.size.width, _mainView.frame.size.height-110);
    
    for (int i = 1; i < 4; i++) {
        UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reservation_line.png"]];
        line.frame = CGRectMake(0, i*45, 320, 1);
        [mainbox addSubview:line];
    }

    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(13, 10, 26, 26)];
    view3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_rate.png"]];
    [mainbox addSubview:view3];
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 270, 25)];
    title3.text = [NSString stringWithFormat:@"费率:$%@/每分钟",[_dataDic objectForKey:@"com_rate"]];
    title3.textAlignment = NSTextAlignmentLeft;
    title3.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title3.backgroundColor = [UIColor clearColor];
    title3.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title3];
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(13, 55, 26, 26)];
    view4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_buy_time.png"]];
    [mainbox addSubview:view4];
    
    [mainbox addSubview:[_allTime mutableDeepCopy]];

    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(13, 99, 26, 26)];
    view5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_ appointment_time.png"]];
    [mainbox addSubview:view5];
    
    UILabel *title5 = [[UILabel alloc]initWithFrame:CGRectMake(50, 99, 270, 25)];
    title5.text = [NSString stringWithFormat:@"预约服务时间:%@",[NSString formatTime:_selectM]];
    title5.textAlignment = NSTextAlignmentLeft;
    title5.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title5.backgroundColor = [UIColor clearColor];
    title5.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title5];

    UIView *view6 = [[UIView alloc]initWithFrame:CGRectMake(13, 145, 26, 26)];
    view6.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_account_balance.png"]];
    [mainbox addSubview:view6];
    
    [mainbox addSubview:[_userFund mutableDeepCopy]];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"reservation_update_request.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(getTempMeetingReply) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(67, MAINSCREENHEIGHT-50-30-20-15, 186, 30);
    searchBtn.center = CGPointMake(MAINSCREENWIDTH/2, 345);
    [_iUIViewII addSubview:searchBtn];
}
//开始计时
- (void)initUIThree
{
    ////////uiview 3
    if (_iUIViewIII) {
        return;
    }

    _iUIViewIII = [[UIView alloc]initWithFrame:_iUIViewI.frame];
    _iUIViewIII.backgroundColor = [UIColor clearColor];
    _iUIViewIII.tag = KSHOWUITHREE;
    UIView *mainbox = [[UIView alloc]init];
    mainbox.backgroundColor = [UIColor clearColor];
    [_iUIViewIII addSubview:mainbox];
    mainbox.frame = CGRectMake(0, 110, _mainView.frame.size.width, _mainView.frame.size.height-110);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _mainView.frame.size.width, 110)];
    topView.backgroundColor = [UIColor colorWithRed:38.0/255.0f green:147.0/255.0f blue:176.0/255.0f alpha:1.0f];
    UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(18, 18, 74, 74)];
    imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_image.png"]];
    [topView addSubview:imageView];
    [_iUIViewIII addSubview:topView];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, 210, 25)];
    title1.text = [NSString stringWithFormat:@"%@/%@",[_dataDic objectForKey:@"nickName"],[_dataDic objectForKey:@"email"] ];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.textColor = [UIColor whiteColor];
    title1.backgroundColor = [UIColor clearColor];
    title1.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:title1];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 45, 210, 25)];
    title2.text = [NSString stringWithFormat:@"服务类别:%@",[_dataDic objectForKey:@"user_commodity"] ];
    title2.textAlignment = NSTextAlignmentLeft;
    title2.textColor = [UIColor whiteColor];
    title2.backgroundColor = [UIColor clearColor];
    title2.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:title2];
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 210, 25)];
    title3.text = [NSString stringWithFormat:@"费率:$%@/每分钟",[_dataDic objectForKey:@"com_rate"]];
    title3.textAlignment = NSTextAlignmentLeft;
    title3.textColor = [UIColor whiteColor];
    title3.backgroundColor = [UIColor clearColor];
    title3.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:title3];
    
    UIColor *progressColor = [UIColor colorWithRed:125.0/255.0 green:133.0/255.0 blue:8.0/255.0 alpha:1.0];
    UIColor *progressColor1 = [UIColor colorWithRed:13.0/255.0 green:85.0/255.0 blue:111.0/255.0 alpha:1.0];
    UIColor *progressColor2 = [UIColor colorWithRed:120.0/255.0 green:180.0/255.0 blue:24.0/255.0 alpha:1.0];

    UIView *bs = [[UIView alloc]initWithFrame:CGRectMake(24, 15, 273, 275)];
    bs.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clock-bg.png"]];
    [mainbox addSubview:bs];

    _progressCircularView = [[ClockView alloc] initWithFrame:CGRectMake(24, 15, 273, 275) backColor:[UIColor clearColor] secountBackColor:[UIColor clearColor] progressColor:progressColor2 appointmentColor:progressColor1 minuteColor:progressColor lineWidth:11 time:@"600" appointmentProgress:[NSString stringWithFormat:@"%d",_selectM]];
    _progressCircularView.backgroundColor = [UIColor clearColor];
	[_progressCircularView setHourHandImage:nil];
	[_progressCircularView setMinHandImage:[UIImage imageNamed:@"clock-minu.png"].CGImage];
	[_progressCircularView setSecHandImage:[UIImage imageNamed:@"clock-secound.png"].CGImage];
	_progressCircularView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    _progressCircularView.delegate = self;
    
    [mainbox addSubview:_progressCircularView];
    
//    UIView *progressBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 212, 212)];
//    progressBackGroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_time.png"]];
//    progressBackGroundView.center = CGPointMake(_progressCircularView.frame.size.width/2, _progressCircularView.frame.size.height/2);
//    [_progressCircularView addSubview:progressBackGroundView];

    _startOrEndBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startOrEndBtn setBackgroundImage:[UIImage imageNamed:@"reservation_start_request.png"] forState:UIControlStateNormal];
    [_startOrEndBtn addTarget:self action:@selector(meetingStart) forControlEvents:UIControlEventTouchUpInside];
    _startOrEndBtn.frame = CGRectMake(0, 0, 40, 40);
    _startOrEndBtn.center = CGPointMake(180, 120);
    [_progressCircularView addSubview:_startOrEndBtn];

    UIView *logoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 193, 30)];
    logoView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_logo_rbg.png"]];
    logoView.center = CGPointMake(MAINSCREENWIDTH/2, 420);
    [_iUIViewIII addSubview:logoView];
}
#pragma mark Circular Progress View Delegate method
- (void)didUpdateProgressView:(NSString *)iCurrentTime{
    //update timelabel
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view
                                              animated:YES];
    HUD.labelText = [NSString stringWithFormat:@"计时:%@",[NSString formatTime:[iCurrentTime intValue]]];
    HUD.mode = MBProgressHUDModeText;
    HUD.margin = 10;
    HUD.yOffset = 150.0f;
    [HUD hide:YES afterDelay:1.5];
    _recordTime = iCurrentTime;
}

//结束计时
- (void)initUIFour
{
    ////////uiview 3
    if (_iUIViewIV) {
        return;
    }

    _iUIViewIV = [[UIView alloc]initWithFrame:_iUIViewI.frame];
    _iUIViewIV.backgroundColor = [UIColor clearColor];
    _iUIViewIV.tag = KSHOWUIFOUR;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _mainView.frame.size.width, 110)];
    topView.backgroundColor = [UIColor colorWithRed:38.0/255.0f green:147.0/255.0f blue:176.0/255.0f alpha:1.0f];
    UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(18, 18, 74, 74)];
    imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_image.png"]];
    [topView addSubview:imageView];
    [_iUIViewIV addSubview:topView];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 25, 210, 25)];
    title1.text = [NSString stringWithFormat:@"%@/%@",[_dataDic objectForKey:@"nickName"],[_dataDic objectForKey:@"email"] ];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.textColor = [UIColor whiteColor];
    title1.backgroundColor = [UIColor clearColor];
    title1.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:title1];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, 210, 25)];
    title2.text = [NSString stringWithFormat:@"服务类别:%@",[_dataDic objectForKey:@"user_commodity"] ];
    title2.textAlignment = NSTextAlignmentLeft;
    title2.textColor = [UIColor whiteColor];
    title2.backgroundColor = [UIColor clearColor];
    title2.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:title2];

    
    UIView *mainbox = [[UIView alloc]init];
    mainbox.backgroundColor = [UIColor clearColor];
    [_iUIViewIV addSubview:mainbox];
    mainbox.frame = CGRectMake(0, 110, _mainView.frame.size.width, _mainView.frame.size.height-110);
    
    for (int i = 1; i < 4; i++) {
        UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reservation_line.png"]];
        line.frame = CGRectMake(0, i*45, 320, 1);
        [mainbox addSubview:line];
    }
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(13, 10, 26, 26)];
    view3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_rate.png"]];
    [mainbox addSubview:view3];
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 270, 25)];
    title3.text = [NSString stringWithFormat:@"费率:$%@/每分钟",[_dataDic objectForKey:@"com_rate"]];
    title3.textAlignment = NSTextAlignmentLeft;
    title3.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title3.backgroundColor = [UIColor clearColor];
    title3.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title3];

    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(13, 55, 26, 26)];
    view4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_buy_time.png"]];
    [mainbox addSubview:view4];
    
    [mainbox addSubview:[_allTime mutableDeepCopy]];
    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(13, 99, 26, 26)];
    view5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_ appointment_time.png"]];
    [mainbox addSubview:view5];
    
    UILabel *title5 = [[UILabel alloc]initWithFrame:CGRectMake(50, 99, 270, 25)];
    title5.text = [NSString stringWithFormat:@"总计时%d秒",[_recordTime intValue]];
    title5.textAlignment = NSTextAlignmentLeft;
    title5.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title5.backgroundColor = [UIColor clearColor];
    title5.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title5];

    UIView *view6 = [[UIView alloc]initWithFrame:CGRectMake(13, 145, 26, 26)];
    view6.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_account_balance.png"]];
    [mainbox addSubview:view6];
    
    UILabel *title6 = [[UILabel alloc]initWithFrame:CGRectMake(50, 145, 280, 25)];
    title6.text = [NSString stringWithFormat:@"您共花费%.2f",[_recordTime intValue]/60*[[_dataDic objectForKey:@"com_rate"]floatValue]];
    title6.textAlignment = NSTextAlignmentLeft;
    title6.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title6.backgroundColor = [UIColor clearColor];
    title6.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title6];
    
}

- (void)showViewI
{
    if ([self.view viewWithTag:KSHOWUITWO]){
        [_iUIViewII removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUITHREE]) {
        [_iUIViewIII removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUIFOUR]) {
        [_iUIViewIV removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUIONE]) {
        return;
    }
    [self changeBackBtnActionToBack];
    [_mainView addSubview:_iUIViewI];
}
- (void)showViewII
{
    if ([self.view viewWithTag:KSHOWUIONE]){
        [_iUIViewI removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUITHREE]) {
        [_iUIViewIII removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUIFOUR]) {
        [_iUIViewIV removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUITWO]) {
        return;
    }
    [self changeBackBtnActionToStop];
    [_mainView addSubview:_iUIViewII];
}
- (void)showViewIII
{
    if ([self.view viewWithTag:KSHOWUIONE]){
        [_iUIViewI removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUITWO]) {
        [_iUIViewII removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUIFOUR]) {
        [_iUIViewIV removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUITHREE]) {
        return;
    }
    [self changeBackBtnActionToBack];
    [_mainView addSubview:_iUIViewIII];
}
- (void)showViewIV
{
    if ([self.view viewWithTag:KSHOWUIONE]){
        [_iUIViewI removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUITWO]) {
        [_iUIViewII removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUITHREE]) {
        [_iUIViewIII removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUIFOUR]) {
        return;
    }
    [self changeBackBtnActionToBack];
    [_mainView addSubview:_iUIViewIV];
}
- (void)updateViewUI
{
    //更新状态按钮

    switch ([AppDelegate App].kUIflag) {
        case kRESERVATIONUI_I:
        {
            [self showViewI];
        }
            break;
        case kRESERVATIONUI_II:
        {
            [self showViewII];
        }
            break;
        case kRESERVATIONUI_III:
        {
            [self showViewIII];
        }
            break;
        case kRESERVATIONUI_IV:
        {
            [self showViewIV];
        }
            break;

        default:
            [self showViewI];
            break;
    }
}
- (void)popView
{
    if ([self.view viewWithTag:KSHOWUIONE]){
        [_iUIViewI removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUITWO]) {
        [_iUIViewII removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUITHREE]) {
        [_iUIViewIII removeFromSuperview];
    }
    if ([self.view viewWithTag:KSHOWUIFOUR]) {
        [_iUIViewIV removeFromSuperview];
    }
    _iUIViewI = nil;
    _iUIViewII = nil;
    _iUIViewIII = nil;
    _iUIViewIV = nil;
    [[SJTimeEngine shareInstance]stopTimer];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!_btnBackGround.userInteractionEnabled) {
        _btnBackGround.userInteractionEnabled = YES;
    }

    CGRect frame = textField.frame;
    
    int offset = frame.origin.y + 160 - (MAINSCREENHEIGHT - 70 - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,MAINSCREENWIDTH,MAINSCREENHEIGHT-70);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
    return  YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _btnBackGround.userInteractionEnabled = NO;
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0,MAINSCREENWIDTH,MAINSCREENHEIGHT-70);
    self.view.frame = rect;
    [UIView commitAnimations];

    if ([_minutes isFirstResponder])
    {        
        [_minutes resignFirstResponder];
    }
    
    if ([_hours isFirstResponder])
    {
        [_hours resignFirstResponder];
    }
    
    return YES;
}
- (void)hideKeyBoard
{
    float kSelectCountMinutes = [_minutes.text floatValue] + [_hours.text floatValue] * 60;
    if (kSelectCountMinutes>([_fund doubleValue]/[[_dataDic objectForKey:@"com_rate"]doubleValue])) {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view
                                                  animated:YES];
        HUD.labelText = @"您的余额不足";
        HUD.detailsLabelText = @"请您输入可预约时间";
        HUD.mode = MBProgressHUDModeText;
        HUD.margin = 10;
        HUD.yOffset = 110.0f;
        [HUD hide:YES afterDelay:3];
        _minutes.text = @"";
        _hours.text = @"";
    }
    _btnBackGround.userInteractionEnabled = NO;
    if ([_minutes isFirstResponder])
    {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 0,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
        [UIView commitAnimations];
        
        [_minutes resignFirstResponder];
    }
    
    if ([_hours isFirstResponder])
    {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 0,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
        [UIView commitAnimations];
        
        [_hours resignFirstResponder];
    }
}
- (void)sendTempMeeting
{
    _selectM = 0;
    if ([_minutes.text intValue]>0) {
        _selectM = [_minutes.text intValue];
    }
    if ([_hours.text intValue]>0) {
        _selectM += [_hours.text intValue] * 60;
    }
    
    if (_selectM > 0) {
        NSString *name = [NSString stringWithFormat:@"%@向您发送了预约请求",[NetWorkEngine shareInstance].nikename];
        [self pushMessage:name andState:kRESERVATION_SEND];
        [[NetWorkEngine shareInstance]creatTempMeetingRequestByRequesterId:[NetWorkEngine shareInstance].userID andResponserId:[_dataDic objectForKey:@"id"] andRate:[_dataDic objectForKey:@"com_rate"] andServicetime:[NSString stringWithFormat:@"%d",_selectM] andSum:_fund delegate:self sel:@selector(sendTempMeetingReturn:)];
    }
    else{
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view
                                                  animated:YES];
        HUD.labelText = @"请输入预约时间";
        HUD.mode = MBProgressHUDModeText;
        HUD.margin = 10;
        HUD.yOffset = 110.0f;
        [HUD hide:YES afterDelay:3];
    }
}
- (void)sendTempMeetingReturn:(NSDictionary*)iDataArr
{
    if ([[iDataArr objectForKey:@"SUCCESS"]isEqualToString:@"SUCCESS"]) {
        [self initUITwo];
        [AppDelegate App].kUIflag = kRESERVATIONUI_II;
        [self updateViewUI];
//        [[SJTimeEngine shareInstance]loopTimerByTime:@"3" delegate:self sel:@selector(getTempMeetingReply)];
        [self getTempMeetingReply];
    }
    NSLog(@"%@",iDataArr);
}

- (void)getTempMeetingReply
{
    [[NetWorkEngine shareInstance]getTempMeetingReplyByResponserId:[_dataDic objectForKey:@"id"] andRequesterId:[NetWorkEngine shareInstance].userID andRate:[_dataDic objectForKey:@"com_rate"] delegate:self sel:@selector(getTempMeetingReplyReturn:)];
}
- (void)getTempMeetingReplyReturn:(NSDictionary *)iData
{
    if ([[iData objectForKey:@"flag"]isEqualToString:@"Y"]) {
        [self initUIThree];
        [AppDelegate App].kUIflag = kRESERVATIONUI_III;
        [self updateViewUI];
    }else if([[iData objectForKey:@"flag"]isEqualToString:@"E"]) {
        [self stopRequest];
    }
}
- (void)stopRequest
{
    NSString *name = [NSString stringWithFormat:@"%@取消了预约请求",[NetWorkEngine shareInstance].nikename];
    [self pushMessage:name andState:kRESERVATION_STOP];

    [[SJTimeEngine shareInstance]stopTimer];
    [[NetWorkEngine shareInstance]stopRequestByResponserId:[_dataDic objectForKey:@"id"] andRequesterId:[NetWorkEngine shareInstance].userID delegate:self sel:@selector(stopRequestReturn:)];
}
- (void)stopRequestReturn:(NSDictionary *)iDataArr
{
    if ([[iDataArr objectForKey:@"SUCCESS"]isEqualToString:@"SUCCESS"]) {
        [self initUIOne];
        [AppDelegate App].kUIflag = kRESERVATIONUI_I;
        [self updateViewUI];
    }
}

- (void)meetingStart
{
    NSString *name = [NSString stringWithFormat:@"%@与您预约开始计时",[NetWorkEngine shareInstance].nikename];
    [self pushMessage:name andState:kRESERVATION_START];

    [[NetWorkEngine shareInstance]meetingStartByResponserId:[_dataDic objectForKey:@"id"] andRequesterId:[NetWorkEngine shareInstance].userID andMeetingStart:@"Y" delegate:self sel:@selector(meetingStartReturn:)];
}
- (void)meetingStartReturn:(NSDictionary *)iDataArr
{
    if ([[iDataArr objectForKey:@"flag"]isEqualToString:@"Y"]) {
        [_progressCircularView start];
//        [[SJTimeEngine shareInstance]loopTimerByTime:@"60" delegate:self sel:@selector(meeting)];

        [_startOrEndBtn setBackgroundImage:[UIImage imageNamed:@"reservation_end_request.png"] forState:UIControlStateNormal];
        
        [_startOrEndBtn removeTarget:self action:@selector(meetingStart) forControlEvents:UIControlEventTouchUpInside];
        [_startOrEndBtn addTarget:self action:@selector(meetingEnd) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)meeting 
{
    _serverTime.text = [NSString stringWithFormat:@"服务时间:%@分钟",[AppDelegate App].circularCountTime];
    _kCountFund = [[_dataDic objectForKey:@"com_rate"]doubleValue] * [[AppDelegate App].circularCountTime integerValue];
    
    NSLog(@"\ns - %d \nm - %d \nf - %.2f \n",_kTotalTimeS,_kTotalTimeM,_kCountFund);
    [[NetWorkEngine shareInstance]meetingByResponserId:[_dataDic objectForKey:@"id"] andRequesterId:[NetWorkEngine shareInstance].userID andCountFund:[NSString stringWithFormat:@"%.2f",_kCountFund] andTotalTime:[NSString stringWithFormat:@"%d",[[AppDelegate App].circularCountTime intValue]] delegate:self sel:@selector(meetingReturn:)];
}
- (void)meetingReturn:(NSDictionary*)iData
{
}

- (void)meetingEnd
{
    NSString *name = [NSString stringWithFormat:@"%@结束与您的计时",[NetWorkEngine shareInstance].nikename];
    [self pushMessage:name andState:kRESERVATION_END];

    [[SJTimeEngine shareInstance]stopTimer];
    [[NetWorkEngine shareInstance]meetingEndByResponserId:[_dataDic objectForKey:@"id"] andRequesterId:[NetWorkEngine shareInstance].userID andMeetingStart:@"S" delegate:self sel:@selector(meetingEndReturn:)];
}
- (void)meetingEndReturn:(NSDictionary *)iDataArr
{
    if ([[iDataArr objectForKey:@"flag"]isEqualToString:@"Y"]) {
        [_progressCircularView stop];
        [_startOrEndBtn setBackgroundImage:[UIImage imageNamed:@"reservation_start_request.png"] forState:UIControlStateNormal];
        
        [_startOrEndBtn removeTarget:self action:@selector(meetingEnd) forControlEvents:UIControlEventTouchUpInside];
        [_startOrEndBtn addTarget:self action:@selector(meetingStart) forControlEvents:UIControlEventTouchUpInside];

        /////////////////////显示ui4 报告界面   {}
        [self initUIFour];
        [AppDelegate App].kUIflag = kRESERVATIONUI_IV;
        [self updateViewUI];
    }
}
- (void)changeBackBtnActionToBack
{
    [_backBtn removeTarget:self action:@selector(stopRequest) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
}
- (void)changeBackBtnActionToStop
{
    [_backBtn removeTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn addTarget:self action:@selector(stopRequest) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pushMessage:(NSString*)message andState:(int)state
{
    if ([[_dataDic objectForKey:@"is_phone"]isEqualToString:@"Y"]&&
        [_dataDic objectForKey:@"shebei"]&&
        ![[_dataDic objectForKey:@"shebei"]isKindOfClass:[NSNull class]]&&
        [[_dataDic objectForKey:@"shebei"]length]>0&&
        [[_dataDic objectForKey:@"is_online"]isEqualToString:@"N"]) {
        [[SJPushEngine shareInstance]pushWithAlert:message andOtherTokenStr:[_dataDic objectForKey:@"shebei"] andBody:[[AppDelegate App] pushBody:state]];
    }
    else if([[_dataDic objectForKey:@"is_phone"]isEqualToString:@"Y"]&&
            [_dataDic objectForKey:@"shebei"]&&
            ![[_dataDic objectForKey:@"shebei"]isKindOfClass:[NSNull class]]&&
            [[_dataDic objectForKey:@"shebei"]length]>0&&
            [[_dataDic objectForKey:@"is_online"]isEqualToString:@"Y"]){
        [[SJPushEngine shareInstance]pushWithAlert:message andOtherTokenStr:[_dataDic objectForKey:@"shebei"] andBody:[[AppDelegate App] pushBody:state]];
        
    }

}
@end
