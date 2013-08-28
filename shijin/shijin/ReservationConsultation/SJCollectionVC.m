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
    [AppDelegate App].kUIflag = kCOLLECTIONUI_I;
    [[NetWorkEngine shareInstance] getRequestInfoByResponserId:@"" delegate:self sel:@selector(qqq)];
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
    _iUIViewI = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _iUIViewI.backgroundColor = [UIColor clearColor];
    _iUIViewI.tag = KVIEWSHOWONE;
    UIView *mainbox = [[UIView alloc]init];
    mainbox.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_big_box.png"]];
    [_iUIViewI addSubview:mainbox];
    mainbox.frame = CGRectMake(0, 53, 287, 261);
    mainbox.center = CGPointMake(MAINSCREENWIDTH / 2, 228);
    for (int i = 1; i < 6; i++) {
        UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reservation_line.png"]];
        line.frame = CGRectMake(1, 45+i*35, 285, 1);
        [mainbox addSubview:line];
    }
    
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(44, 5, 200, 25)];
    title.text = @"服务状态:发送请求";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, 270, 25)];
    title1.text = [NSString stringWithFormat:@"服务商:%@/%@",[_iData objectForKey:@"nickName"],[_iData objectForKey:@"email"] ];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title1.backgroundColor = [UIColor clearColor];
    title1.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title1];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 85, 270, 25)];
    title2.text = [NSString stringWithFormat:@"服务类别:%@",[_iData objectForKey:@"user_commodity"] ];
    title2.textAlignment = NSTextAlignmentLeft;
    title2.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title2.backgroundColor = [UIColor clearColor];
    title2.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title2];
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, 270, 25)];
    title3.text = [NSString stringWithFormat:@"费率:$%@/每分钟",[_iData objectForKey:@"com_rate"]];
    title3.textAlignment = NSTextAlignmentLeft;
    title3.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title3.backgroundColor = [UIColor clearColor];
    title3.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title3];
    
//    _allTime = [[UILabel alloc]initWithFrame:CGRectMake(15, 155, 270, 25)];
//    _allTime.text = @"当前可购买的服务时间:0分钟";
//    _allTime.textAlignment = NSTextAlignmentLeft;
//    _allTime.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
//    _allTime.backgroundColor = [UIColor clearColor];
//    _allTime.font = [UIFont systemFontOfSize:12.0f];
//    [mainbox addSubview:_allTime];
    
    UILabel *title5 = [[UILabel alloc]initWithFrame:CGRectMake(15, 190, 270, 25)];
    title5.text = @"预约服务时间(              )hours(              )minutes";
    title5.textAlignment = NSTextAlignmentLeft;
    title5.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title5.backgroundColor = [UIColor clearColor];
    title5.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title5];
    
//    _hours = [[UITextField alloc]initWithFrame:CGRectMake(97, 191, 40, 25)];
//    _hours.delegate = self;
//    _hours.textAlignment = NSTextAlignmentCenter;
//    [mainbox addSubview:_hours];
//    
//    _minutes = [[UITextField alloc]initWithFrame:CGRectMake(180, 191, 40, 25)];
//    _minutes.delegate = self;
//    _minutes.textAlignment = NSTextAlignmentCenter;
//    [mainbox addSubview:_minutes];
//    
//    _userFund = [[UILabel alloc]initWithFrame:CGRectMake(15, 225, 270, 25)];
//    _userFund.text = [NSString stringWithFormat:@"账户当前余额:$0"];
//    _userFund.textAlignment = NSTextAlignmentLeft;
//    _userFund.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
//    _userFund.backgroundColor = [UIColor clearColor];
//    _userFund.font = [UIFont systemFontOfSize:12.0f];
//    [mainbox addSubview:_userFund];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"reservation_accept.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(sendTempMeeting) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(67, MAINSCREENHEIGHT-50-30-20-15, 186, 30);
    searchBtn.center = CGPointMake(MAINSCREENWIDTH/2, 385);
    [_iUIViewI addSubview:searchBtn];
    
    UILabel *btnTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 166, 30)];
    btnTitle.text = @"发送请求";
    btnTitle.textAlignment = NSTextAlignmentCenter;
    [searchBtn addSubview:btnTitle];
    btnTitle.backgroundColor = [UIColor clearColor];
    btnTitle.textColor = [UIColor whiteColor];
    btnTitle.font = [UIFont systemFontOfSize:12];

}
- (void)initViewTwo
{
    ////////uiview 2
    if (_iUIViewII) {
        return;
    }
    
    _iUIViewII = [[UIView alloc]initWithFrame:_iUIViewI.frame];
    _iUIViewII.backgroundColor = [UIColor clearColor];
    _iUIViewII.tag = KVIEWSHOWTWO;
    UIView *mainbox = [[UIView alloc]init];
    mainbox.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_box.png"]];
    [_iUIViewII addSubview:mainbox];
    mainbox.frame = CGRectMake(0, 0, 287, 175);
    mainbox.center = CGPointMake(MAINSCREENWIDTH / 2, 188);
    
    UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reservation_line.png"]];
    line.frame = CGRectMake(1, 45+35, 285, 1);
    [mainbox addSubview:line];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(44, 5, 200, 25)];
    title.text = @"服务状态:请求";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, 270, 25)];
//    title1.text = [NSString stringWithFormat:@"服务商:%@/%@",[_dataDic objectForKey:@"nickName"],[_dataDic objectForKey:@"email"] ];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title1.backgroundColor = [UIColor clearColor];
    title1.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title1];
    
    UILabel *title5 = [[UILabel alloc]initWithFrame:CGRectMake(15, 85, 270, 25)];
//    title5.text = [NSString stringWithFormat:@"预约服务时间:%@分钟",_minutes.text];
    title5.textAlignment = NSTextAlignmentLeft;
    title5.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title5.backgroundColor = [UIColor clearColor];
    title5.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title5];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"reservation_send.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(stopRequest) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(67, MAINSCREENHEIGHT-50-30-20-15, 186, 30);
    searchBtn.center = CGPointMake(MAINSCREENWIDTH/2, 300);
    [_iUIViewII addSubview:searchBtn];
    
    UILabel *btnTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 166, 30)];
    btnTitle.text = @"返  回";
    btnTitle.textAlignment = NSTextAlignmentCenter;
    [searchBtn addSubview:btnTitle];
    btnTitle.backgroundColor = [UIColor clearColor];
    btnTitle.textColor = [UIColor whiteColor];
    btnTitle.font = [UIFont systemFontOfSize:12];
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
    mainbox.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_big_box.png"]];
    [_iUIViewIII addSubview:mainbox];
    mainbox.frame = CGRectMake(0, 0, 287, 261);
    mainbox.center = CGPointMake(MAINSCREENWIDTH / 2, 228);
    
    for (int i = 1; i < 5; i++) {
        UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reservation_line.png"]];
        line.frame = CGRectMake(1, 45+i*35, 285, 1);
        [mainbox addSubview:line];
    }
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(44, 5, 200, 25)];
    title.text = @"服务状态:发送请求";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, 270, 25)];
//    title1.text = [NSString stringWithFormat:@"服务商:%@/%@",[_dataDic objectForKey:@"nickName"],[_dataDic objectForKey:@"email"] ];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title1.backgroundColor = [UIColor clearColor];
    title1.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title1];
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 85, 270, 25)];
//    title3.text = [NSString stringWithFormat:@"费率:$%@/每分钟",[_dataDic objectForKey:@"com_rate"]];
    title3.textAlignment = NSTextAlignmentLeft;
    title3.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title3.backgroundColor = [UIColor clearColor];
    title3.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title3];
    
    UILabel *title5 = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, 270, 25)];
//    title5.text = [NSString stringWithFormat:@"预约服务时间:%@分钟",_minutes.text];
    title5.textAlignment = NSTextAlignmentLeft;
    title5.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title5.backgroundColor = [UIColor clearColor];
    title5.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title5];
    
//    [mainbox addSubview:[_allTime mutableDeepCopy]];
//    [mainbox addSubview:[_userFund mutableDeepCopy]];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"reservation_start.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(meetingStart) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(67, MAINSCREENHEIGHT-50-30-20-15, 186, 30);
    searchBtn.center = CGPointMake(MAINSCREENWIDTH/2, 385);
    [_iUIViewIII addSubview:searchBtn];
    
    UILabel *btnTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 166, 30)];
    btnTitle.text = @"开始计时";
    btnTitle.textAlignment = NSTextAlignmentCenter;
    [searchBtn addSubview:btnTitle];
    btnTitle.backgroundColor = [UIColor clearColor];
    btnTitle.textColor = [UIColor whiteColor];
    btnTitle.font = [UIFont systemFontOfSize:12];
    
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
    mainbox.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_big_box.png"]];
    [_iUIViewIV addSubview:mainbox];
    mainbox.frame = CGRectMake(0, 0, 287, 261);
    mainbox.center = CGPointMake(MAINSCREENWIDTH / 2, 228);
    
    for (int i = 1; i < 5; i++) {
        UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reservation_line.png"]];
        line.frame = CGRectMake(1, 45+i*35, 285, 1);
        [mainbox addSubview:line];
    }
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(44, 5, 200, 25)];
    title.text = @"服务状态:发送请求";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, 270, 25)];
//    title1.text = [NSString stringWithFormat:@"服务商:%@/%@",[_dataDic objectForKey:@"nickName"],[_dataDic objectForKey:@"email"] ];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title1.backgroundColor = [UIColor clearColor];
    title1.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title1];
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 85, 270, 25)];
//    title3.text = [NSString stringWithFormat:@"费率:$%@/每分钟",[_dataDic objectForKey:@"com_rate"]];
    title3.textAlignment = NSTextAlignmentLeft;
    title3.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title3.backgroundColor = [UIColor clearColor];
    title3.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title3];
    
//    _serverTime = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, 270, 25)];
//    _serverTime.text = [NSString stringWithFormat:@"服务时间:0分钟"];
//    _serverTime.textAlignment = NSTextAlignmentLeft;
//    _serverTime.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
//    _serverTime.backgroundColor = [UIColor clearColor];
//    _serverTime.font = [UIFont systemFontOfSize:12.0f];
//    [mainbox addSubview:_serverTime];
    
//    [mainbox addSubview:[_allTime mutableDeepCopy]];
//    [mainbox addSubview:[_userFund mutableDeepCopy]];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"reservation_end.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(meetingEnd) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(67, MAINSCREENHEIGHT-50-30-20-15, 186, 30);
    searchBtn.center = CGPointMake(MAINSCREENWIDTH/2, 385);
    [_iUIViewIV addSubview:searchBtn];
    
    UILabel *btnTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 166, 30)];
    btnTitle.text = @"结束计时";
    btnTitle.textAlignment = NSTextAlignmentCenter;
    [searchBtn addSubview:btnTitle];
    btnTitle.backgroundColor = [UIColor clearColor];
    btnTitle.textColor = [UIColor whiteColor];
    btnTitle.font = [UIFont systemFontOfSize:12];
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


@end
