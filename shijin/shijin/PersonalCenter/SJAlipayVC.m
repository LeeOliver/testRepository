//
//  SJAlipayVC.m
//  shijin
//
//  Created by apple on 13-9-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJAlipayVC.h"

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
    [self initUI];
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
    
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 50, 320, MAINSCREENHEIGHT-50-50-20)];
    _webView.backgroundColor = [UIColor clearColor];
    NSString *path = [NSString stringWithFormat:@"http://www.shijinzhifu.com/alipay/alipayapi2.php?alipay_amount=0.01&userid=%@",[NetWorkEngine shareInstance].userID];
    
    NSString *str = [NSString stringWithFormat:@"%@",[NetWorkEngine shareInstance].userID];
    NSURL *url = [NSURL URLWithString:path];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    [_webView setDelegate:self];
    [_webView setOpaque:NO];//使网页透明

    [self.view addSubview:_webView];
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

@end
