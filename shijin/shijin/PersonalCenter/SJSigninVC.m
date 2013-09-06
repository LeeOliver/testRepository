//
//  SJSigninVCViewController.m
//  shijin
//
//  Created by apple on 13-7-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJSigninVC.h"

@interface SJSigninVC ()

@end

@implementation SJSigninVC

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
    _btnBackGround = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnBackGround.frame = self.view.frame;
    _btnBackGround.backgroundColor = [UIColor clearColor];
    _btnBackGround.userInteractionEnabled = NO;
    [_btnBackGround addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnBackGround];
    
    [self initMain];
	
    [self.view bringSubviewToFront:_btnBackGround];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)initMain
{
    
    //背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[AppDelegate clipImage:[UIImage imageNamed:@"center_bg_iphone4.png"] clipSize:CGSizeMake(MAINSCREENWIDTH, MAINSCREENHEIGHT)]];
    
    //注册面板背景
    UIView *listBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 283, 150)];
    listBGView.center = CGPointMake(MAINSCREENWIDTH/2, MAINSCREENHEIGHT/2);
    listBGView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"center_login_bg.png"]];
    [self.view addSubview:listBGView];
    
    //label 用户名等
    float x = listBGView.frame.size.width / 2.0f;
    float y = listBGView.frame.size.height / 4.0f;
    
    for (int i = 1; i < 3; i++) {
        UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"center_line.png"]];
        line.center = CGPointMake(x, y*i);
        [listBGView addSubview:line];
        
        UILabel *tmpLabel       = [[UILabel alloc]init];
        tmpLabel.frame          = CGRectMake(12, 3+38*(i-1), 65, 28);
        tmpLabel.backgroundColor = [UIColor clearColor];
        tmpLabel.tag = 10000+i;
        tmpLabel.font = [UIFont systemFontOfSize:13.0f];
        tmpLabel.textColor = [UIColor colorWithRed:14/255.0f green:82/255.0f blue:117/255.0f alpha:1.0];
        tmpLabel.textAlignment= NSTextAlignmentRight;
        [listBGView addSubview:tmpLabel];
    }
    
    UILabel *nLabel = (UILabel*)[listBGView viewWithTag:10001];
    nLabel.text = @"用户名:";
        
    UILabel *pLabel = (UILabel*)[listBGView viewWithTag:10002];
    pLabel.text = @"密码:";
        
    //输入框
    _tfLoginID           = [[UITextField alloc]init];
    _tfLoginID.frame     = CGRectMake(85, 5, 190, 28);
    [_tfLoginID setBorderStyle:UITextBorderStyleNone];
    _tfLoginID.delegate  = self;
    _tfLoginID.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [listBGView addSubview:_tfLoginID];
    
    _tfPassWord              = [[UITextField alloc]init];
    _tfPassWord.frame        = CGRectMake(85, 43, 190, 28);
    [_tfPassWord setBorderStyle:UITextBorderStyleNone];
    _tfPassWord.delegate     = self;
    _tfPassWord.tag          = 100012;
    _tfPassWord.secureTextEntry = YES;
    _tfPassWord.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [listBGView addSubview:_tfPassWord];
    
    
    //注册按钮
    UIButton *btnRegistered = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRegistered setBackgroundImage:[UIImage imageNamed:@"center_login_btn.png"] forState:UIControlStateNormal];
    btnRegistered.frame = CGRectMake(0, 0, 248, 27);
    btnRegistered.center = CGPointMake(x, y*3);
    btnRegistered.tag = 1002;
    [btnRegistered addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [listBGView addSubview:btnRegistered];
    
    //注册面板背景
    UIImageView *stringView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"center_login_strig.png"]];
    stringView.center = CGPointMake(MAINSCREENWIDTH/2, MAINSCREENHEIGHT/5*4);
    [self.view addSubview:stringView];
    
    //快速登录
    UIButton *changeSigninBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeSigninBtn setBackgroundImage:[UIImage imageNamed:@"center_register_immediately.png"] forState:UIControlStateNormal];
    changeSigninBtn.frame = CGRectMake(0, 0, 74, 24);
    changeSigninBtn.center = CGPointMake(MAINSCREENWIDTH/2-85, MAINSCREENHEIGHT/5*4+35);
    [changeSigninBtn addTarget:[AppDelegate App] action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
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

- (void)actionBtn:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    if (btn.tag == 1000) {
        [NetWorkEngine shareInstance].isPayment = YES;
        [_tfPassWord resignFirstResponder];
        [_tfLoginID resignFirstResponder];
    }
    else if(btn.tag == 1001){
        [NetWorkEngine shareInstance].isPayment = NO;
        [_tfPassWord resignFirstResponder];
        [_tfLoginID resignFirstResponder];
    }
    else if(btn.tag == 1002){
        [NetWorkEngine shareInstance].personID = _tfLoginID.text;
        [NetWorkEngine shareInstance].password = _tfPassWord.text;
        NSString *error;
        if ([[NetWorkEngine shareInstance]chkIDExistIfError:&error] == 1) {
            [NetWorkEngine shareInstance].isFlag = YES;
            [[AppDelegate App]saveUserInfoByEmail:[NetWorkEngine shareInstance].personID andPassword:[NetWorkEngine shareInstance].password andPayment:[NetWorkEngine shareInstance].isPayment andName:[NetWorkEngine shareInstance].nikename];
            
            [[AppDelegate App]jumpToReservationVC];
        }else
        {
            [[AppDelegate App]showAlert:@"提示!" andMessage:@"请输入正确的账号密码"];
        }
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_tfPassWord isFirstResponder])
    {
        _btnBackGround.userInteractionEnabled = NO;
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 0,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
        [UIView commitAnimations];

        [_tfPassWord resignFirstResponder];
        [NetWorkEngine shareInstance].personID = _tfLoginID.text;
        [NetWorkEngine shareInstance].password = _tfPassWord.text;
        NSString *error;
        if ([[NetWorkEngine shareInstance]chkIDExistIfError:&error] == 1) {
            [NetWorkEngine shareInstance].isFlag = YES;
            [[AppDelegate App]saveUserInfoByEmail:[NetWorkEngine shareInstance].personID andPassword:[NetWorkEngine shareInstance].password andPayment:[NetWorkEngine shareInstance].isPayment andName:[NetWorkEngine shareInstance].nikename];

            [[AppDelegate App]jumpToReservationVC];
        }else
        {
            [[AppDelegate App]showAlert:@"提示!" andMessage:@"请输入正确的账号密码"];
        }
    }

    if ([_tfLoginID isFirstResponder])
    {
        [_tfPassWord becomeFirstResponder];
    }

    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if ([_tfPassWord isFirstResponder])
    {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 0,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
        [UIView commitAnimations];
        
        [_tfPassWord resignFirstResponder];
    }
    
    if ([_tfLoginID isFirstResponder])
    {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 0,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
        [UIView commitAnimations];

        [_tfLoginID resignFirstResponder];
    }

}
@end
