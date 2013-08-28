//
//  UserBalanceVC.m
//  shijin
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJUserBalanceVC.h"

@interface SJUserBalanceVC ()

@end

@implementation SJUserBalanceVC

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    UIView *bgTopView = [[UIView alloc]init];
    bgTopView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"center_bg_top.png"]];
    bgTopView.frame = CGRectMake(0, 0, 320, 99);
    bgTopView.center = CGPointMake(MAINSCREENWIDTH / 2, 100);
    [self.view addSubview:bgTopView];
    
    self.view.backgroundColor = [UIColor colorWithRed:212/255.0f green:212/255.0f blue:212/255.0f alpha:1.0f];
    
    _iTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 295, 80)];
    _iTable.center = CGPointMake(MAINSCREENWIDTH / 2, 257);
    _iTable.layer.cornerRadius = 5;
    _iTable.layer.masksToBounds = YES;
    _iTable.delegate = self;
    _iTable.dataSource = self;
    [_iTable setScrollEnabled:NO];
    [self.view addSubview:_iTable];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"center_save_btn.png"] forState:UIControlStateNormal];
    saveBtn.frame = CGRectMake(0, 0, 81, 28);
    saveBtn.center = CGPointMake(MAINSCREENWIDTH/2, 382);
    [self.view addSubview:saveBtn];
    
}
- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma -Mark Table Delegate
#pragma mark -
#pragma mark - Table View DataSource Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 200, 14)];
    tempLabel.textAlignment = NSTextAlignmentLeft;
    tempLabel.font = [UIFont boldSystemFontOfSize:13.0];
    tempLabel.textColor=[UIColor colorWithRed:70/255.0f green:100/255.0f blue:130/255.0f alpha:1.0f];
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.tag = 2000;
    [cell.contentView addSubview:tempLabel];
    UILabel *sLabel = (UILabel *)[cell.contentView viewWithTag:2000];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch ([indexPath row]){
        case 0:
        {
            sLabel.text = [NSString stringWithFormat:@"当前余额:200"];
        }
            break;
        case 1:
        {
            sLabel.text = [NSString stringWithFormat:@"结算截止于2013年8月9日 10：25：00"];
        }
            break;
            
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


@end
