//
//  SJAddOrUpdateServiceVC.m
//  shijin
//
//  Created by apple on 13-9-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJAddOrUpdateServiceVC.h"

@interface SJAddOrUpdateServiceVC ()

@end

@implementation SJAddOrUpdateServiceVC
@synthesize iDataPerson = _iDataPerson;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (void)initUI
{
    UIView *topView = [[AppDelegate App] creatNavigationView];
    [self.view addSubview:topView];
    
    //查找类别返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"center_back.png"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 44, 32);
    backBtn.center = CGPointMake(MAINSCREENWIDTH-45, 25);
    [backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    [self.view addSubview:topView];
    self.view.backgroundColor = [UIColor colorWithRed:212/255.0f green:212/255.0f blue:212/255.0f alpha:1.0f];

}
- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
