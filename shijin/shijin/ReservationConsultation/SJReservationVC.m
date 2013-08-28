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
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backbtn.png"] forState:UIControlStateNormal];
    backBtn.tag = 1002;
    [backBtn addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(9, 7, 40, 30);
    backBtn.center = CGPointMake(MAINSCREENWIDTH-45, 22);
    [topView addSubview:backBtn];
    [self.view addSubview: topView];
    
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, MAINSCREENWIDTH, MAINSCREENHEIGHT-50-50-20)];
    _mainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reservation_back_pic.png"]];
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
    title1.text = [NSString stringWithFormat:@"服务商:%@/%@",[_dataDic objectForKey:@"nickName"],[_dataDic objectForKey:@"email"] ];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title1.backgroundColor = [UIColor clearColor];
    title1.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title1];

    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 85, 270, 25)];
    title2.text = [NSString stringWithFormat:@"服务类别:%@",[_dataDic objectForKey:@"user_commodity"] ];
    title2.textAlignment = NSTextAlignmentLeft;
    title2.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title2.backgroundColor = [UIColor clearColor];
    title2.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title2];
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, 270, 25)];
    title3.text = [NSString stringWithFormat:@"费率:$%@/每分钟",[_dataDic objectForKey:@"com_rate"]];
    title3.textAlignment = NSTextAlignmentLeft;
    title3.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title3.backgroundColor = [UIColor clearColor];
    title3.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title3];
    
    _allTime = [[UILabel alloc]initWithFrame:CGRectMake(15, 155, 270, 25)];
    _allTime.text = @"当前可购买的服务时间:0分钟";
    _allTime.textAlignment = NSTextAlignmentLeft;
    _allTime.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    _allTime.backgroundColor = [UIColor clearColor];
    _allTime.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:_allTime];

    UILabel *title5 = [[UILabel alloc]initWithFrame:CGRectMake(15, 190, 270, 25)];
    title5.text = @"预约服务时间(              )hours(              )minutes";
    title5.textAlignment = NSTextAlignmentLeft;
    title5.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title5.backgroundColor = [UIColor clearColor];
    title5.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title5];
    
    _hours = [[UITextField alloc]initWithFrame:CGRectMake(97, 191, 40, 25)];
    _hours.delegate = self;
    _hours.textAlignment = NSTextAlignmentCenter;
    [mainbox addSubview:_hours];
    
    _minutes = [[UITextField alloc]initWithFrame:CGRectMake(180, 191, 40, 25)];
    _minutes.delegate = self;
    _minutes.textAlignment = NSTextAlignmentCenter;
    [mainbox addSubview:_minutes];

    _userFund = [[UILabel alloc]initWithFrame:CGRectMake(15, 225, 270, 25)];
    _userFund.text = [NSString stringWithFormat:@"账户当前余额:$0"];
    _userFund.textAlignment = NSTextAlignmentLeft;
    _userFund.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    _userFund.backgroundColor = [UIColor clearColor];
    _userFund.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:_userFund];

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
    title1.text = [NSString stringWithFormat:@"服务商:%@/%@",[_dataDic objectForKey:@"nickName"],[_dataDic objectForKey:@"email"] ];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title1.backgroundColor = [UIColor clearColor];
    title1.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title1];

    UILabel *title5 = [[UILabel alloc]initWithFrame:CGRectMake(15, 85, 270, 25)];
    title5.text = [NSString stringWithFormat:@"预约服务时间:%@分钟",_minutes.text];
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
    title1.text = [NSString stringWithFormat:@"服务商:%@/%@",[_dataDic objectForKey:@"nickName"],[_dataDic objectForKey:@"email"] ];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title1.backgroundColor = [UIColor clearColor];
    title1.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title1];
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 85, 270, 25)];
    title3.text = [NSString stringWithFormat:@"费率:$%@/每分钟",[_dataDic objectForKey:@"com_rate"]];
    title3.textAlignment = NSTextAlignmentLeft;
    title3.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title3.backgroundColor = [UIColor clearColor];
    title3.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title3];
    
    UILabel *title5 = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, 270, 25)];
    title5.text = [NSString stringWithFormat:@"预约服务时间:%@分钟",_minutes.text];
    title5.textAlignment = NSTextAlignmentLeft;
    title5.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title5.backgroundColor = [UIColor clearColor];
    title5.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title5];

    [mainbox addSubview:[_allTime mutableDeepCopy]];
    [mainbox addSubview:[_userFund mutableDeepCopy]];
    
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
    title1.text = [NSString stringWithFormat:@"服务商:%@/%@",[_dataDic objectForKey:@"nickName"],[_dataDic objectForKey:@"email"] ];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title1.backgroundColor = [UIColor clearColor];
    title1.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title1];
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 85, 270, 25)];
    title3.text = [NSString stringWithFormat:@"费率:$%@/每分钟",[_dataDic objectForKey:@"com_rate"]];
    title3.textAlignment = NSTextAlignmentLeft;
    title3.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    title3.backgroundColor = [UIColor clearColor];
    title3.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:title3];

    _serverTime = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, 270, 25)];
    _serverTime.text = [NSString stringWithFormat:@"服务时间:0分钟"];
    _serverTime.textAlignment = NSTextAlignmentLeft;
    _serverTime.textColor = [UIColor colorWithRed:14/255.0f green:68/255.0f blue:82/255.0f alpha:1.0f];
    _serverTime.backgroundColor = [UIColor clearColor];
    _serverTime.font = [UIFont systemFontOfSize:12.0f];
    [mainbox addSubview:_serverTime];

    [mainbox addSubview:[_allTime mutableDeepCopy]];
    [mainbox addSubview:[_userFund mutableDeepCopy]];
    
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
    [[NetWorkEngine shareInstance]creatTempMeetingRequestByRequesterId:[NetWorkEngine shareInstance].userID andResponserId:[_dataDic objectForKey:@"id"] andRate:[_dataDic objectForKey:@"com_rate"] andServicetime:_minutes.text andSum:_fund delegate:self sel:@selector(sendTempMeetingReturn:)];
}
- (void)sendTempMeetingReturn:(NSDictionary*)iDataArr
{
    if ([[iDataArr objectForKey:@"SUCCESS"]isEqualToString:@"SUCCESS"]) {
        [self initUITwo];
        [AppDelegate App].kUIflag = kRESERVATIONUI_II;
        [self updateViewUI];
        [[SJTimeEngine shareInstance]loopTimerByTime:@"3" delegate:self sel:@selector(getTempMeetingReply)];
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
        [[SJTimeEngine shareInstance]stopTimer];
        [self initUIThree];
        [AppDelegate App].kUIflag = kRESERVATIONUI_III;
        [self updateViewUI];
    }else if([[iData objectForKey:@"flag"]isEqualToString:@"E"]) {
        [self stopRequest];
    }
}
- (void)stopRequest
{
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
    [[NetWorkEngine shareInstance]meetingStartByResponserId:[_dataDic objectForKey:@"id"] andRequesterId:[NetWorkEngine shareInstance].userID andMeetingStart:@"Y" delegate:self sel:@selector(meetingStartReturn:)];
}
- (void)meetingStartReturn:(NSDictionary *)iDataArr
{
    if ([[iDataArr objectForKey:@"flag"]isEqualToString:@"Y"]) {
        [self initUIFour];
        [AppDelegate App].kUIflag = kRESERVATIONUI_IV;
        [self updateViewUI];
        _kTotalTimeM = 0;
        _kTotalTimeS = 0;
        _kCountFund  = 0;
        [[SJTimeEngine shareInstance]loopTimerByTime:@"60" delegate:self sel:@selector(meeting)];
    }
}

- (void)meeting
{
    _kTotalTimeS++;
    if (_kTotalTimeS == 1) {
        _kTotalTimeS = 0;
        _kTotalTimeM++;
        _serverTime.text = [NSString stringWithFormat:@"服务时间:%d分钟",_kTotalTimeM];
        _kCountFund = [[_dataDic objectForKey:@"com_rate"]doubleValue] * _kTotalTimeM;
    }
    NSLog(@"\ns - %d \nm - %d \nf - %.2f \n",_kTotalTimeS,_kTotalTimeM,_kCountFund);
    [[NetWorkEngine shareInstance]meetingByResponserId:[_dataDic objectForKey:@"id"] andRequesterId:[NetWorkEngine shareInstance].userID andCountFund:[NSString stringWithFormat:@"%.2f",_kCountFund] andTotalTime:[NSString stringWithFormat:@"%d",_kTotalTimeM] delegate:self sel:@selector(meetingReturn:)];
}
- (void)meetingReturn:(NSDictionary*)iData
{
}

- (void)meetingEnd
{
    [[SJTimeEngine shareInstance]stopTimer];
    [[NetWorkEngine shareInstance]meetingEndByResponserId:[_dataDic objectForKey:@"id"] andRequesterId:[NetWorkEngine shareInstance].userID andMeetingStart:@"S" delegate:self sel:@selector(meetingEndReturn:)];
}
- (void)meetingEndReturn:(NSDictionary *)iDataArr
{
    if ([[iDataArr objectForKey:@"flag"]isEqualToString:@"Y"]) {
        [self initUIOne];
        [AppDelegate App].kUIflag = kRESERVATIONUI_I;
        [self updateViewUI];
    }
}

@end
