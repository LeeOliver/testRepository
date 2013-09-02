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
@interface SJCollectionVC ()<CircularProgressDelegate>

@end

@implementation SJCollectionVC

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
    _iData = aDataSource;
    _topNameLabel.text = [NSString stringWithFormat:@"%@/%@",[_iData objectForKey:@"requester"],[_iData objectForKey:@"email"]];
    _topServiceLabel.text = [NSString stringWithFormat:@"费率:%@/分钟",[_iData objectForKey:@"rate"]];
//    _userFund.text = [NSString stringWithFormat:@"账户当前余额:$%@",_fund];
//    _allTime.text = [NSString stringWithFormat:@"当前可购买的服务时间:%.2f分钟",([_fund doubleValue]/[[_iData objectForKey:@"com_rate"]doubleValue])];

    [self updateViewUI];
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
    
    _topNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 25, 210, 25)];
    _topNameLabel.text = [NSString stringWithFormat:@"等待客户"];
    _topNameLabel.textAlignment = NSTextAlignmentLeft;
    _topNameLabel.textColor = [UIColor whiteColor];
    _topNameLabel.backgroundColor = [UIColor clearColor];
    _topNameLabel.font = [UIFont systemFontOfSize:12.0f];
    [topView addSubview:_topNameLabel];
    
    _topServiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, 210, 25)];
    _topServiceLabel.text = [NSString stringWithFormat:@"暂无请求"];
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
    
    
    UIImageView *boxImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reservation_big_box.png"]];
    boxImg.frame = CGRectMake(0, 0, 287, 261);
    boxImg.center = CGPointMake(MAINSCREENWIDTH / 2, 285);
    [_iUIViewI addSubview:boxImg];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    title.text = @"等待客户";
    title.center = CGPointMake(boxImg.frame.size.width/2, 15);
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [boxImg addSubview:title];
    
    UIImageView *waitImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reservation_wait.png"]];
    waitImg.frame = CGRectMake(0, 0, 153, 100);
    waitImg.center = CGPointMake(boxImg.frame.size.width/2, boxImg.frame.size.height/5*3);
    [boxImg addSubview:waitImg];

    

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
    mainbox.backgroundColor = [UIColor clearColor];
    [_iUIViewIII addSubview:mainbox];
    mainbox.frame = CGRectMake(0, 110, _mainView.frame.size.width, _mainView.frame.size.height-110);

    UIColor *backColor = [UIColor colorWithRed:223.0/255.0 green:220.0/255.0 blue:222.0/255.0 alpha:1.0];
    UIColor *backColor1 = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    UIColor *progressColor = [UIColor colorWithRed:225.0/255.0 green:209.0/255.0 blue:48.0/255.0 alpha:1.0];
    UIColor *progressColor1 = [UIColor colorWithRed:252.0/255.0 green:112.0/255.0 blue:152.0/255.0 alpha:1.0];
    UIColor *progressColor2 = [UIColor colorWithRed:54.0/255.0 green:189.0/255.0 blue:215.0/255.0 alpha:1.0];
    
    _progressCircularView = [[CircularProgressView alloc] initWithFrame:CGRectMake(24, 20, 263, 263) backColor:backColor secountBackColor:backColor1 progressColor:progressColor2 appointmentColor:progressColor1 minuteColor:progressColor lineWidth:15 time:@"600" appointmentProgress:[NSString stringWithFormat:@"%d",[[_iData objectForKey:@"service_time"]intValue]]];
    
    _progressCircularView.delegate = self;
    
    [mainbox addSubview:_progressCircularView];
    
    UIView *progressBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 212, 212)];
    progressBackGroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_time.png"]];
    progressBackGroundView.center = CGPointMake(_progressCircularView.frame.size.width/2, _progressCircularView.frame.size.height/2);
    [_progressCircularView addSubview:progressBackGroundView];
    
    
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
    view3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_rate.png"]];
    [mainbox addSubview:view3];
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 270, 25)];
//    title3.text = [NSString stringWithFormat:@"费率:$%@/每分钟",[_dataDic objectForKey:@"com_rate"]];
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
//    title6.text = [NSString stringWithFormat:@"您共花费%.2f",[_recordTime intValue]/60*[[_dataDic objectForKey:@"com_rate"]floatValue]];
    title6.textAlignment = NSTextAlignmentLeft;
    title6.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title6.backgroundColor = [UIColor clearColor];
    title6.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title6];
}

- (void)updateViewUI
{
    switch ([AppDelegate App].kUIflag) {
        case kCOLLECTIONUI_I:
        {
            [self showUIOne];
        }
            break;
        case kCOLLECTIONUI_II:
        {
            [self showUITwo];
        }
            break;
        case kCOLLECTIONUI_III:
        {
            [self showUIThree];
        }
            break;
        case kCOLLECTIONUI_IV:
        {
            [self showUIFour];
        }
            break;
            
        default:
            [self showUIOne];
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
        [[SJTimeEngine shareInstance]loopTimerByTime:@"3" delegate:self sel:@selector(getReicpient)];
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
//        _timingTitle.text = @"服务状态 ：开始计时";
//        _timingLabel.text = [NSString stringWithFormat:@"服务时间:%@分钟",[iData objectForKey:@"responser_time"]];
        [_progressCircularView play];
    }
    else if((![[iData objectForKey:@"start"] isKindOfClass:[NSNull class]] && [[iData objectForKey:@"start"]isEqualToString:@"S"]) ||
            [[iData objectForKey:@"start"] isKindOfClass:[NSNull class]])
    {
//        [_progressCircularView revert];
        [[SJTimeEngine shareInstance]stopTimer];
        [AppDelegate App].kUIflag = kCOLLECTIONUI_IV;
        [self updateViewUI];
    }
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

@end
