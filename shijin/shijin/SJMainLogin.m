//
//  SJMainLogin.m
//  shijin
//
//  Created by apple on 13-8-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJMainLogin.h"

@interface SJMainLogin ()

@end

@implementation SJMainLogin

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
    [self initMain];
	// Do any additional setup after loading the view.
}

- (void)initMain
{
    if (IS_IPHONE_4) {
        [self.view setBackgroundColor:[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"main_back_iphone4.png"]]];
    }
    else if (IS_IPHONE_5){
        [self.view setBackgroundColor:[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"main_back_iphone5.png"]]];
    }
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogin setBackgroundImage:[UIImage imageNamed:@"main_btn_login.png"] forState:UIControlStateNormal];
    btnLogin.frame = CGRectMake(74, 265, 88, 40);
    [btnLogin addTarget:[AppDelegate App] action:@selector(signinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];

    UIButton *btnRegistered = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRegistered setBackgroundImage:[UIImage imageNamed:@"main_btn_registered.png"] forState:UIControlStateNormal];
    [btnRegistered addTarget:[AppDelegate App] action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    btnRegistered.frame = CGRectMake(160, 265, 88, 40);
    [self.view addSubview:btnRegistered];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
