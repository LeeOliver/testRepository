//
//  SJRegisteredVC.m
//  shijin
//
//  Created by apple on 13-7-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJRegisteredVC.h"

@interface SJRegisteredVC ()

@end

@implementation SJRegisteredVC

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
    [self initView];
    [[AppDelegate App] hidenNavigation:self.navigationController];
    [[AppDelegate App] hideTabBar];
    _btnBackGround = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnBackGround.frame = self.view.frame;
    _btnBackGround.backgroundColor = [UIColor clearColor];
    _btnBackGround.userInteractionEnabled = NO;
    [_btnBackGround addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnBackGround];
    [self.view bringSubviewToFront:_btnBackGround];
	// Do any additional setup after loading the view.
}

- (void)initView
{
    //背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[AppDelegate clipImage:[UIImage imageNamed:@"center_bg_iphone4.png"] clipSize:CGSizeMake(MAINSCREENWIDTH, MAINSCREENHEIGHT)]];
    
    //注册面板背景
    UIView *listBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 284, 203)];
    listBGView.center = CGPointMake(MAINSCREENWIDTH/2, MAINSCREENHEIGHT/2);
    listBGView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"center_register_bg.png"]];
    [self.view addSubview:listBGView];
    
    //label 用户名等
    float x = listBGView.frame.size.width / 2.0f;
    float y = listBGView.frame.size.height / 6.0f;
    
    for (int i = 1; i < 5; i++) {
        UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"center_line.png"]];
        line.center = CGPointMake(x, y*i);
        [listBGView addSubview:line];
        
        UILabel *tmpLabel       = [[UILabel alloc]init];
        tmpLabel.frame          = CGRectMake(12, 2+34*(i-1), 65, 28);
        tmpLabel.backgroundColor = [UIColor clearColor];
        tmpLabel.tag = 10000+i;
        tmpLabel.font = [UIFont systemFontOfSize:13.0f];
        tmpLabel.textColor = [UIColor colorWithRed:14/255.0f green:82/255.0f blue:117/255.0f alpha:1.0];
        tmpLabel.textAlignment= NSTextAlignmentRight;
        [listBGView addSubview:tmpLabel];
    }
    
    UILabel *nLabel = (UILabel*)[listBGView viewWithTag:10001];
    nLabel.text = @"用户名:";
    
    UILabel *eLabel = (UILabel*)[listBGView viewWithTag:10002];
    eLabel.text = @"邮箱:";

    UILabel *pLabel = (UILabel*)[listBGView viewWithTag:10003];
    pLabel.text = @"密码:";

    UILabel *repLabel = (UILabel*)[listBGView viewWithTag:10004];
    repLabel.text = @"确认密码:";

    //输入框
    _nikeName           = [[UITextField alloc]init];
    _nikeName.frame     = CGRectMake(85, 3, 190, 28);
    [_nikeName setBorderStyle:UITextBorderStyleNone];
    _nikeName.delegate  = self;
    _nikeName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [listBGView addSubview:_nikeName];

    _email              = [[UITextField alloc]init];
    _email.frame        = CGRectMake(85, 37, 190, 28);
    [_email setBorderStyle:UITextBorderStyleNone];
    _email.delegate     = self;
    _email.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [listBGView addSubview:_email];
    
    _password           = [[UITextField alloc]init];
    _password.frame     = CGRectMake(85, 71, 190, 28);
    [_password setBorderStyle:UITextBorderStyleNone];
    _password.delegate  = self;
    _password.secureTextEntry = YES;
    _password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [listBGView addSubview:_password];
    
    _rePassword         = [[UITextField alloc]init];
    _rePassword.frame   = CGRectMake(85, 104, 190, 28);
    [_rePassword setBorderStyle:UITextBorderStyleNone];
    _rePassword.delegate= self;
    _rePassword.secureTextEntry = YES;
    _rePassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [listBGView addSubview:_rePassword];

    //注册按钮
    UIButton *btnRegistered = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRegistered setBackgroundImage:[UIImage imageNamed:@"center_register_btn.png"] forState:UIControlStateNormal];
    btnRegistered.frame = CGRectMake(0, 0, 248, 27);
    btnRegistered.center = CGPointMake(x, y*5);
    [btnRegistered addTarget:self action:@selector(registeredAction) forControlEvents:UIControlEventTouchUpInside];
    [listBGView addSubview:btnRegistered];

    //注册面板背景
    UIImageView *stringView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"center_register_string.png"]];
    stringView.center = CGPointMake(MAINSCREENWIDTH/2, MAINSCREENHEIGHT/5*4);
    [self.view addSubview:stringView];
    
    //快速登录
    UIButton *changeSigninBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeSigninBtn setBackgroundImage:[UIImage imageNamed:@"center_login_immediately.png"] forState:UIControlStateNormal];
    changeSigninBtn.frame = CGRectMake(0, 0, 74, 24);
    changeSigninBtn.center = CGPointMake(MAINSCREENWIDTH/2-85, MAINSCREENHEIGHT/5*4+35);
    [changeSigninBtn addTarget:[AppDelegate App] action:@selector(signinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeSigninBtn];

    UIButton *sinaSigninBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sinaSigninBtn setBackgroundImage:[UIImage imageNamed:@"center_sina.png"] forState:UIControlStateNormal];
    sinaSigninBtn.frame = CGRectMake(0, 0, 62, 26);
    sinaSigninBtn.center = CGPointMake(MAINSCREENWIDTH/2+91, MAINSCREENHEIGHT/5*4+35);
    [self.view addSubview:sinaSigninBtn];

    UIButton *qqSigninBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqSigninBtn setBackgroundImage:[UIImage imageNamed:@"center_qq.png"] forState:UIControlStateNormal];
    qqSigninBtn.frame = CGRectMake(0, 0, 29, 26);
    qqSigninBtn.center = CGPointMake(MAINSCREENWIDTH/2+45, MAINSCREENHEIGHT/5*4+35);
    [self.view addSubview:qqSigninBtn];

    UIButton *peopleSigninBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [peopleSigninBtn setBackgroundImage:[UIImage imageNamed:@"center_people.png"] forState:UIControlStateNormal];
    peopleSigninBtn.frame = CGRectMake(0, 0, 70, 26);
    peopleSigninBtn.center = CGPointMake(MAINSCREENWIDTH/2-5, MAINSCREENHEIGHT/5*4+35);
    [self.view addSubview:peopleSigninBtn];

}
- (void)registeredAction
{
    if ([self checkUserInfo:_nikeName andMessage:@"请填写用户名"]) {
        return;
    }
    if ([self checkUserInfo:_email andMessage:@"请填写邮箱"]) {
        return;
    }
    if ([self checkUserInfo:_password andMessage:@"请填写密码"]) {
        return;
    }
    if ([self checkUserInfo:_rePassword andMessage:@"请填写确认密码"]) {
        return;
    }

    
    if ([_password.text isEqualToString:_rePassword.text]) {
        [NetWorkEngine shareInstance].personID = _email.text;
        [NetWorkEngine shareInstance].password = _password.text;
        [NetWorkEngine shareInstance].nikename = _nikeName.text;

        NSString *error;
        if ([[NetWorkEngine shareInstance]registerWithName:_nikeName.text error:&error] == 1) {
            [[AppDelegate App] showAlert:@"提示!" andMessage:@"注册成功"];
            [[AppDelegate App]jumpToReservationVC];
        }
        else{
             [[AppDelegate App] showAlert:@"提示!" andMessage:error];
        }
    }
    else
    {
        [[AppDelegate App]showAlert:@"提示!" andMessage:@"密码不一致"];
    }
}
- (BOOL)checkUserInfo:(UITextField *)tmpText andMessage:(NSString*)message
{
    if (!tmpText || !tmpText.text || [tmpText.text isKindOfClass:[NSNull class]]|| [tmpText.text isEqualToString:@""]) {
        [[AppDelegate App]showAlert:@"提示!" andMessage:message];
        return YES;
    }
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_rePassword isFirstResponder])
    {
        _btnBackGround.userInteractionEnabled = NO;

        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 20.0f,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
        [UIView commitAnimations];
        [_rePassword resignFirstResponder];

        [self registeredAction];
    }
    
    if ([_password isFirstResponder])
    {
        [_rePassword becomeFirstResponder];
    }
    
    if ([_email isFirstResponder])
    {
        [_password becomeFirstResponder];
    }
    
    if ([_nikeName isFirstResponder])
    {
        [_email becomeFirstResponder];
    }
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!_btnBackGround.userInteractionEnabled) {
        _btnBackGround.userInteractionEnabled = YES;
    }

    CGRect frame = textField.frame;
    
    int offset = frame.origin.y + 280 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
    return  YES;
}
- (void)hideKeyBoard
{
    _btnBackGround.userInteractionEnabled = NO;
    if ([_email isFirstResponder])
    {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 0,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
        [UIView commitAnimations];
        
        [_email resignFirstResponder];
    }
    
    if ([_nikeName isFirstResponder])
    {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 0,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
        [UIView commitAnimations];
        
        [_nikeName resignFirstResponder];
    }
    
    if ([_password isFirstResponder])
    {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 0,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
        [UIView commitAnimations];
        
        [_password resignFirstResponder];
    }
    
    if ([_rePassword isFirstResponder])
    {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 0,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
        [UIView commitAnimations];
        
        [_rePassword resignFirstResponder];
    }
}
@end
