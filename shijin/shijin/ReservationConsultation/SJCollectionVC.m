//
//  SJCollectionVC.m
//  shijin
//
//  Created by apple on 13-8-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJCollectionVC.h"
#define KVIEWSHOWONE    20001
#define KVIEWSHOWTWO    20002
#define KVIEWSHOWTHREE  20003
#define KVIEWSHOWFOUR   20004
@interface SJCollectionVC ()

@end

@implementation SJCollectionVC
@synthesize topCopyView = _topCopyView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)setDataSource:(NSDictionary *)aDataSource
{
    if (!aDataSource) {
        _topNameLabel.text = [NSString stringWithFormat:@"等待客户"];
        _topFundLabel.text = [NSString stringWithFormat:@"暂无请求"];
        _topServiceLabel.text = [NSString stringWithFormat:@"服务器状态:等待请求"];
    }
    else{
        _iData = aDataSource;
        _topNameLabel.text = [NSString stringWithFormat:@"%@/%@",[_iData objectForKey:@"requester"],[_iData objectForKey:@"email"]];
        _topFundLabel.text = [NSString stringWithFormat:@"费率:%@/分钟\t预约时间:%@分钟",[_iData objectForKey:@"rate"],[_iData objectForKey:@"service_time"]];
    }
    [self updateViewUI];
}
- (void)setTopService:(NSString *)aString
{
    _topServiceLabel.text = aString;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateViewUI];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [AppDelegate App].kUIflag = kCOLLECTIONUI_I;
    [[NetWorkEngine shareInstance] getRequestInfoByResponserId:@"" delegate:self sel:@selector(qqq)];
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAINSCREENWIDTH, MAINSCREENHEIGHT-50-50-20)];
    _mainView.backgroundColor = [UIColor colorWithRed:224.0/255.0f green:225.0/255.0f blue:218.0/255.0f alpha:1.0f];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _mainView.frame.size.width, 110)];
    topView.backgroundColor = [UIColor colorWithRed:38.0/255.0f green:147.0/255.0f blue:176.0/255.0f alpha:1.0f];
    UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(18, 18, 74, 74)];
    imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_image.png"]];
    [topView addSubview:imageView];
    [_mainView addSubview:topView];
    
    _topNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 210, 25)];
    _topNameLabel.text = [NSString stringWithFormat:@"等待客户"];
    _topNameLabel.textAlignment = NSTextAlignmentLeft;
    _topNameLabel.textColor = [UIColor whiteColor];
    _topNameLabel.backgroundColor = [UIColor clearColor];
    _topNameLabel.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:_topNameLabel];
    
    _topFundLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 45, 210, 25)];
    _topFundLabel.text = [NSString stringWithFormat:@"暂无请求"];
    _topFundLabel.textAlignment = NSTextAlignmentLeft;
    _topFundLabel.textColor = [UIColor whiteColor];
    _topFundLabel.backgroundColor = [UIColor clearColor];
    _topFundLabel.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:_topFundLabel];

    _topServiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 210, 25)];
    _topServiceLabel.text = [NSString stringWithFormat:@"服务器状态:等待请求"];
    _topServiceLabel.textAlignment = NSTextAlignmentLeft;
    _topServiceLabel.textColor = [UIColor whiteColor];
    _topServiceLabel.backgroundColor = [UIColor clearColor];
    _topServiceLabel.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:_topServiceLabel];

    [self.view addSubview:_mainView];
    [self updateViewUI];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initViewOne
{
    ////////uiview 1
    if (_iUIViewI) {
        return;
    }
    _iUIViewI = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _mainView.frame.size.width, _mainView.frame.size.height)];
    _iUIViewI.backgroundColor = [UIColor clearColor];
    _iUIViewI.tag = KVIEWSHOWONE;
    
        
    UIImageView *waitImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reservation_wait.png"]];
    waitImg.frame = CGRectMake(0, 0, 153, 100);
    waitImg.center = CGPointMake(MAINSCREENWIDTH/2, MAINSCREENHEIGHT/5*2);
    [_iUIViewI addSubview:waitImg];

    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"reservation_update_request.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(67, MAINSCREENHEIGHT-50-30-20-15, 186, 30);
    searchBtn.center = CGPointMake(MAINSCREENWIDTH/2, 345);
    [_iUIViewI addSubview:searchBtn];


}
//请求界面
- (void)initViewTwo
{
    ////////uiview 2
    if (_iUIViewII) {
        return;
    }
    
    _iUIViewII = [[UIView alloc]initWithFrame:_iUIViewI.frame];
    _iUIViewII.backgroundColor = [UIColor clearColor];
    _iUIViewII.tag = KVIEWSHOWTWO;
    
    UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 145, 110)];
    imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_receive_request.png"]];
    imageView.center = CGPointMake(MAINSCREENWIDTH / 2, 200);
    [_iUIViewII addSubview:imageView];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"reservation_end.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(acceptAction) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(67, MAINSCREENHEIGHT-50-30-20-15, 186, 30);
    searchBtn.center = CGPointMake(MAINSCREENWIDTH/2, 345);
    [_iUIViewII addSubview:searchBtn];
}
- (void)initViewThree
{
    ////////uiview 3
    if (_iUIViewIII) {
        return;
    }
    
    _iUIViewIII = [[UIView alloc]initWithFrame:_iUIViewI.frame];
    _iUIViewIII.backgroundColor = [UIColor clearColor];
    _iUIViewIII.tag = KVIEWSHOWTHREE;
    UIView *mainbox = [[UIView alloc]init];
    mainbox.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clock_big_bg.png"]];
    [_iUIViewIII addSubview:mainbox];
    mainbox.frame = CGRectMake(0, 110, _mainView.frame.size.width, _mainView.frame.size.height-110);

//    UIColor *backColor = [UIColor colorWithRed:223.0/255.0 green:220.0/255.0 blue:222.0/255.0 alpha:1.0];
//    UIColor *backColor1 = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
//    
//    UIColor *progressColor = [UIColor colorWithRed:225.0/255.0 green:209.0/255.0 blue:48.0/255.0 alpha:1.0];
//    UIColor *progressColor1 = [UIColor colorWithRed:252.0/255.0 green:112.0/255.0 blue:152.0/255.0 alpha:1.0];
//    UIColor *progressColor2 = [UIColor colorWithRed:54.0/255.0 green:189.0/255.0 blue:215.0/255.0 alpha:1.0];
//    
//    _progressCircularView = [[CircularProgressView alloc] initWithFrame:CGRectMake(24, 20, 263, 263) backColor:backColor secountBackColor:backColor1 progressColor:progressColor2 appointmentColor:progressColor1 minuteColor:progressColor lineWidth:15 time:@"600" appointmentProgress:[NSString stringWithFormat:@"%d",[[_iData objectForKey:@"service_time"]intValue]]];
    UIColor *progressColor = [UIColor colorWithRed:125.0/255.0 green:133.0/255.0 blue:8.0/255.0 alpha:1.0];
    UIColor *progressColor1 = [UIColor colorWithRed:13.0/255.0 green:85.0/255.0 blue:111.0/255.0 alpha:1.0];
    UIColor *progressColor2 = [UIColor colorWithRed:120.0/255.0 green:180.0/255.0 blue:24.0/255.0 alpha:1.0];
    
    UIView *bs = [[UIView alloc]initWithFrame:CGRectMake(24, 15, 273, 275)];
    bs.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clock-bbg.png"]];
    [mainbox addSubview:bs];
    
    _progressCircularView = [[ClockView alloc] initWithFrame:CGRectMake(24, 15, 273, 275) backColor:[UIColor clearColor] secountBackColor:[UIColor clearColor] progressColor:progressColor2 appointmentColor:progressColor1 minuteColor:progressColor lineWidth:11 time:@"600" appointmentProgress:[NSString stringWithFormat:@"%d",[[_iData objectForKey:@"service_time"]intValue]]];
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
    
    
    UIView *logoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 193, 30)];
    logoView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_logo_rbg.png"]];
    logoView.center = CGPointMake(MAINSCREENWIDTH/2, 420);
    [_iUIViewIII addSubview:logoView];
}
- (void)initViewFour
{
    ////////uiview 3
    if (_iUIViewIV) {
        return;
    }
    
    _iUIViewIV = [[UIView alloc]initWithFrame:_iUIViewI.frame];
    _iUIViewIV.backgroundColor = [UIColor clearColor];
    _iUIViewIV.tag = KVIEWSHOWFOUR;
    
    
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
    view3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_ appointment_time.png"]];
    [mainbox addSubview:view3];
    
    _servertimeViewIV = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 270, 25)];
    _servertimeViewIV.text = [NSString stringWithFormat:@"总计时%d秒",[_recordTime intValue]];
    _servertimeViewIV.textAlignment = NSTextAlignmentLeft;
    _servertimeViewIV.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    _servertimeViewIV.backgroundColor = [UIColor clearColor];
    _servertimeViewIV.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:_servertimeViewIV];
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(13, 55, 26, 26)];
    view4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_rate.png"]];
    [mainbox addSubview:view4];
            
    _incomeViewIV = [[UILabel alloc]initWithFrame:CGRectMake(50, 55, 270, 25)];
    _incomeViewIV.text = [NSString stringWithFormat:@"您共花费0.00"];
    _incomeViewIV.textAlignment = NSTextAlignmentLeft;
    _incomeViewIV.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    _incomeViewIV.backgroundColor = [UIColor clearColor];
    _incomeViewIV.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:_incomeViewIV];
    
    UIView *view6 = [[UIView alloc]initWithFrame:CGRectMake(13, 99, 26, 26)];
    view6.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_account_balance.png"]];
    [mainbox addSubview:view6];
    
    _fundViewIV = [[UILabel alloc]initWithFrame:CGRectMake(50, 99, 280, 25)];
    _fundViewIV.text = [NSString stringWithFormat:@"预约时间:%@分钟",[_iData objectForKey:@"service_time"]];
    
    _fundViewIV.textAlignment = NSTextAlignmentLeft;
    _fundViewIV.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    _fundViewIV.backgroundColor = [UIColor clearColor];
    _fundViewIV.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:_fundViewIV];
}

- (void)updateViewUI
{
    switch ([AppDelegate App].kUIflag) {
        case kCOLLECTIONUI_I:
        {
            [self showUIOne];
            [self hideBackButton];
        }
            break;
        case kCOLLECTIONUI_II:
        {
            [self showUITwo];
            [self addBackButton];
            [self changeButtonAction:@selector(backAction) andNewAction:@selector(stopAction) andButton:[_topCopyView viewWithTag:10021]];
        }
            break;
        case kCOLLECTIONUI_III:
        {
            [self showUIThree];
            [self hideBackButton];
        }
            break;
        case kCOLLECTIONUI_IV:
        {
            [self showUIFour];
            [self addBackButton];
            [self changeButtonAction:@selector(stopAction) andNewAction:@selector(backAction) andButton:[_topCopyView viewWithTag:10021]];
        }
            break;
            
        default:
            [self showUIOne];
            [self hideBackButton];
            break;
    }
}

- (void)showUIOne
{
    [self initViewOne];
    if ([self.view viewWithTag:KVIEWSHOWTWO]){
        [_iUIViewII removeFromSuperview];
    }
    if ([self.view viewWithTag:KVIEWSHOWTHREE]) {
        [_iUIViewIII removeFromSuperview];
    }
    if ([self.view viewWithTag:KVIEWSHOWFOUR]) {
        [_iUIViewIV removeFromSuperview];
    }
    if ([self.view viewWithTag:KVIEWSHOWONE]) {
        return;
    }
    [self.view addSubview:_iUIViewI];

}
- (void)showUITwo
{
    [self initViewTwo];
    if ([self.view viewWithTag:KVIEWSHOWONE]){
        [_iUIViewI removeFromSuperview];
    }
    if ([self.view viewWithTag:KVIEWSHOWTHREE]) {
        [_iUIViewIII removeFromSuperview];
    }
    if ([self.view viewWithTag:KVIEWSHOWFOUR]) {
        [_iUIViewIV removeFromSuperview];
    }
    if ([self.view viewWithTag:KVIEWSHOWTWO]) {
        return;
    }
    [self.view addSubview:_iUIViewII];

}
- (void)showUIThree
{
    [self initViewThree];
    if ([self.view viewWithTag:KVIEWSHOWONE]){
        [_iUIViewI removeFromSuperview];
    }
    if ([self.view viewWithTag:KVIEWSHOWTWO]) {
        [_iUIViewII removeFromSuperview];
    }
    if ([self.view viewWithTag:KVIEWSHOWFOUR]) {
        [_iUIViewIV removeFromSuperview];
    }
    if ([self.view viewWithTag:KVIEWSHOWTHREE]) {
        return;
    }
    [self.view addSubview:_iUIViewIII];

}
- (void)showUIFour
{
    [self initViewFour];
    if ([self.view viewWithTag:KVIEWSHOWONE]){
        [_iUIViewI removeFromSuperview];
    }
    if ([self.view viewWithTag:KVIEWSHOWTWO]) {
        [_iUIViewII removeFromSuperview];
    }
    if ([self.view viewWithTag:KVIEWSHOWTHREE]) {
        [_iUIViewIII removeFromSuperview];
    }
    if ([self.view viewWithTag:KVIEWSHOWFOUR]) {
        return;
    }
    [self.view addSubview:_iUIViewIV];

}
- (void)updateAction
{
    [[NetWorkEngine shareInstance]getRequestInfoByResponserId:[NetWorkEngine shareInstance].userID delegate:self sel:@selector(updateUI:)];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    HUD.labelText = @"正在加載";
}
- (void)updateUI:(NSDictionary*)iDic
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (iDic &&
        ![iDic isKindOfClass:[NSNull class]] &&
        [iDic count]>0 &&
        [iDic objectForKey:@"service_time"] &&
        ![[iDic objectForKey:@"service_time"]isKindOfClass:[NSNull class]]) {
        [AppDelegate App].kUIflag = kCOLLECTIONUI_II;
        [self setDataSource:iDic];
        [self setTopService:[NSString stringWithFormat:@"服务器状态:请求"]];
    }
    else{
        [AppDelegate App].kUIflag = kCOLLECTIONUI_I;
        [self setDataSource:nil];
    }

}

- (void)acceptAction
{
    //收款人请求按钮
    [[NetWorkEngine shareInstance]sendreceiveRequestByResponserId:[NetWorkEngine shareInstance].userID andRequesterId:[_iData objectForKey:@"requester_id"] andServiceTime:[_iData objectForKey:@"service_time"] delegate:self sel:@selector(acceptReturn:)];
}
- (void)acceptReturn:(NSDictionary*)iData
{
    //切换界面
    if (iData && [iData objectForKey:@"flag"]) {
        [AppDelegate App].kUIflag = kCOLLECTIONUI_III;
        [self updateViewUI];
        [self setTopService:[NSString stringWithFormat:@"服务器状态:接受"]];
        [[SJTimeEngine shareInstance]loopTimerByTime:@"3" delegate:self sel:@selector(getReicpient)];
        [self changeButtonAction:@selector(backAction) andNewAction:@selector(stopAction) andButton:[_topCopyView viewWithTag:10021]];
    }
}

- (void)getReicpient
{
    [[NetWorkEngine shareInstance]getReicpientByResponserId:[NetWorkEngine shareInstance].userID andRequesterId:[_iData objectForKey:@"requester_id"] andFund:[_iData objectForKey:@"rate"] andShowTime:[_iData objectForKey:@"service_time"] delegate:self sel:@selector(getReicpientReturn:)];
    
    
}
- (void)getReicpientReturn:(NSDictionary *)iData
{
//    _timingTimeStr.text = [NSString stringWithFormat:@"服务商:%@", _requesterStr];
    if (![[iData objectForKey:@"start"] isKindOfClass:[NSNull class]] && [[iData objectForKey:@"start"]isEqualToString:@"Y"]) {
        [self setTopService:[NSString stringWithFormat:@"服务器状态:正在服务中"]];
        [self hideBackButton];
        [_progressCircularView start];
    }
    else if((![[iData objectForKey:@"start"] isKindOfClass:[NSNull class]] &&
             [[iData objectForKey:@"start"]isEqualToString:@"S"]) ||
                    [[iData objectForKey:@"start"] isKindOfClass:[NSNull class]])
    {
        [self addBackButton];
        [self changeButtonAction:@selector(stopAction) andNewAction:@selector(backAction) andButton:[_topCopyView viewWithTag:10021]];

        [self setTopService:[NSString stringWithFormat:@"服务器状态:服务终止"]];
        [_progressCircularView stop];
        [[SJTimeEngine shareInstance]stopTimer];
        [AppDelegate App].kUIflag = kCOLLECTIONUI_IV;
        [self updateViewUI];
        if ([[iData objectForKey:@"start"] isKindOfClass:[NSNull class]]) {
            return;
        }
        [self setViewIVLabel:[iData mutableDeepCopy]];
    }
}
- (void)setViewIVLabel:(NSDictionary *)dicData
{
    _servertimeViewIV.text = [NSString stringWithFormat:@"总计时:%@分",[dicData objectForKey:@"responser_time"]];
    _incomeViewIV.text = [NSString stringWithFormat:@"您收入金额:%@",[dicData objectForKey:@"responser_fund"]];
}
#pragma mark Circular Progress View Delegate method
- (void)didUpdateProgressView:(NSString *)iCurrentTime{
    //update timelabel
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    HUD.labelText = [NSString stringWithFormat:@"计时:%@",[NSString formatTime:[iCurrentTime intValue]]];
    HUD.mode = MBProgressHUDModeText;
    HUD.margin = 10;
    HUD.yOffset = 150.0f;
    [HUD hide:YES afterDelay:1.5];
    _recordTime = iCurrentTime;
}
- (void)addBackButton
{
    //查找类别返回按钮
    if ([_topCopyView viewWithTag:10021]) {
        UIButton *backBtnTemp = (UIButton*)[_topCopyView viewWithTag:10021];
        backBtnTemp.hidden = NO;
        return;
    }
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backbtn.png"] forState:UIControlStateNormal];
    backBtn.tag = 10021;
    backBtn.hidden = NO;
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(9, 7, 40, 30);
    backBtn.center = CGPointMake(MAINSCREENWIDTH-45, 25);
    [_topCopyView addSubview:backBtn];
}
- (void)hideBackButton
{
    if ([_topCopyView viewWithTag:10021]) {
        UIButton *backBtnTemp = (UIButton*)[_topCopyView viewWithTag:10021];
        backBtnTemp.hidden = YES;
        [backBtnTemp removeFromSuperview];
    }
}
- (void)changeButtonAction:(SEL)oldAction andNewAction:(SEL)newAction andButton:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (!btn || [btn isKindOfClass:[NSNull class]]) {
        return;
    }
    [btn removeTarget:self action:oldAction forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:newAction forControlEvents:UIControlEventTouchUpInside];
}
- (void)backAction
{
    [[SJTimeEngine shareInstance]stopTimer];
    [AppDelegate App].kUIflag = kCOLLECTIONUI_I;
    [self setDataSource:nil];
}
- (void)stopAction
{
    [self stopRequest];
}
- (void)stopRequest
{
    [[SJTimeEngine shareInstance]stopTimer];
    [[NetWorkEngine shareInstance]stopRequestByResponserId:[_iData objectForKey:@"id"] andRequesterId:[NetWorkEngine shareInstance].userID delegate:self sel:@selector(stopRequestReturn:)];
}
- (void)stopRequestReturn:(NSDictionary *)iDataArr
{
    if ([[iDataArr objectForKey:@"SUCCESS"]isEqualToString:@"SUCCESS"]) {
        [AppDelegate App].kUIflag = kCOLLECTIONUI_I;
        [self updateViewUI];
    }
}

@end
