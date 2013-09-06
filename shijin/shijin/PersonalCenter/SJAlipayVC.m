//
//  SJAlipayVC.m
//  shijin
//
//  Created by apple on 13-9-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJAlipayVC.h"
#import "SJAlipayWebVC.h"
@interface SJAlipayVC ()

@end

@implementation SJAlipayVC

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

    bAlipay = NO;
    [self initUI];
    [self.view bringSubviewToFront:_btnBackGround];

	// Do any additional setup after loading the view.
}
- (void)initUI
{
    UIView *topView = [[AppDelegate App]creatNavigationView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"center_back.png"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 44, 32);
    backBtn.center = CGPointMake(MAINSCREENWIDTH-45, 25);
    [backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setBackgroundImage:[UIImage imageNamed:@"center_title.png"] forState:UIControlStateNormal];
    titleBtn.frame = CGRectMake(0, 0, 82, 32);
    titleBtn.center = CGPointMake(MAINSCREENWIDTH/2, 25);
    [topView addSubview:titleBtn];
    
    [self.view addSubview:topView];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"center_alipay_bg.png"]];
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, MAINSCREENHEIGHT-50-50-20)];
    mainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"center_alipay_bg.png"]];
    [self.view addSubview:mainView];
    
    UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 49)];
    selectView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"center_alipay_select.png"]];
    selectView.center = CGPointMake(MAINSCREENWIDTH/2, 100);
    [mainView addSubview:selectView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 23)];
    line.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"center_alipay_line.png"]];
    line.center = CGPointMake(selectView.frame.size.width/2, selectView.frame.size.height/2);
    [selectView addSubview:line];
    
    UIButton *diankaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [diankaBtn addTarget:self action:@selector(diankaAction) forControlEvents:UIControlEventTouchUpInside];
    [diankaBtn setTitle:@"点卡支付" forState:UIControlStateNormal];
    [diankaBtn setTitleColor:[UIColor colorWithRed:220.0/255.0f green:70.0/255.0f blue:7.0/255.0f alpha:1.0] forState:UIControlStateNormal];
    diankaBtn.frame = CGRectMake(0, 0, 115, 48);
    diankaBtn.center = CGPointMake(57, selectView.frame.size.height/2);
    [selectView addSubview:diankaBtn];

    UIButton *alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [alipayBtn addTarget:self action:@selector(alipayAction) forControlEvents:UIControlEventTouchUpInside];
    [alipayBtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [alipayBtn setTitleColor:[UIColor colorWithRed:220.0/255.0f green:70.0/255.0f blue:7.0/255.0f alpha:1.0] forState:UIControlStateNormal];
    alipayBtn.frame = CGRectMake(0, 0, 115, 48);
    alipayBtn.center = CGPointMake(selectView.frame.size.width-60, selectView.frame.size.height/2);
    [selectView addSubview:alipayBtn];

    _fundText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 250, 49)];
    [_fundText setBorderStyle:UITextBorderStyleNone];
    _fundText.delegate  = self;
    _fundText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _fundText.placeholder = @"点卡支付金额";
    _fundText.backgroundColor = [UIColor whiteColor];
    _fundText.center = CGPointMake(MAINSCREENWIDTH/2, 200);
    _fundText.keyboardType = UIKeyboardTypePhonePad;
    [mainView addSubview:_fundText];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"center_alipay_btn.png"] forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(0, 0, 250, 42);
    sureBtn.center = CGPointMake(MAINSCREENWIDTH/2, 300);
    [mainView addSubview:sureBtn];


}
- (void)diankaAction
{
    bAlipay = NO;
    _fundText.placeholder = @"点卡支付金额";
    NSLog(@"dianka");
}
- (void)alipayAction
{
    bAlipay = YES;
    _fundText.placeholder = @"支付宝支付金额";
    NSLog(@"alipay");
}
- (void)sureAction
{
    if ([_fundText.text length]<=0) {
        [[AppDelegate App]showAlert:@"提示" andMessage:@"请点写充值金额"];
    }
    else{
        if (bAlipay) {
            SJAlipayWebVC *next = [[SJAlipayWebVC alloc]init];
            next.fundStr = _fundText.text;
            [self.navigationController pushViewController:next animated:YES];
        }
        else{
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view
                                                      animated:YES];
            HUD.labelText = [NSString stringWithFormat:@"暂无此功能"];
            HUD.mode = MBProgressHUDModeText;
            HUD.margin = 10;
            HUD.yOffset = 150.0f;
            [HUD hide:YES afterDelay:3];
        }
    }
}
- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
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
    if ([_fundText isFirstResponder])
    {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 0,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
        [UIView commitAnimations];
        
        [_fundText resignFirstResponder];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_fundText isFirstResponder])
    {
        _btnBackGround.userInteractionEnabled = NO;
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 0,MAINSCREENWIDTH,MAINSCREENHEIGHT);
        self.view.frame = rect;
        [UIView commitAnimations];
        
        [_fundText resignFirstResponder];
    }
    return YES;
}

@end
