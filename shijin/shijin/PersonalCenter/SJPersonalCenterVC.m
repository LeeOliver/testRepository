//
//  SJPersonalCenterVC.m
//  shijin
//
//  Created by apple on 13-7-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJPersonalCenterVC.h"
#import "LEffectLabel.h"
#import "SJAlipayVC.h"
#import "SJMutableListVC.h"
#import "SJMutableCollectionListVC.h"
@interface SJPersonalCenterVC ()

@end

@implementation SJPersonalCenterVC

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

    [self initSelfFirst];
    [[AppDelegate App] hidenNavigation:self.navigationController];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_iTable reloadData];
    [[AppDelegate App] showTabBar];
}

- (void)initSelfFirst
{
    //顶部navi
    UIView *topView = [[AppDelegate App] creatNavigationView];
    [self.view addSubview:topView];
#if 0
    //测试字体特效
    LEffectLabel *effectLabel = [[LEffectLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 160)];
    [self.view addSubview:effectLabel];
    effectLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    effectLabel.font = [UIFont boldSystemFontOfSize:28];
    effectLabel.text = @"test 测试字体";
    
    effectLabel.textColor = [UIColor whiteColor];
    effectLabel.effectColor = [UIColor blueColor];
    effectLabel.effectDirection = EffectDirectionLeftToRight;
    
    effectLabel.center = CGPointMake(160, 400);
    
    for (int i = 0; i < 8; i++)
    {
        int64_t delayInSeconds = 3 * i;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            effectLabel.effectDirection = i;
            [effectLabel performEffectAnimation];
        });
    }
#endif
    
    [self initTable];
}

- (void)initTable
{
    _iTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, MAINSCREENWIDTH, MAINSCREENHEIGHT-20-50-50) style:UITableViewStyleGrouped];
    _iTable.delegate = self;
    _iTable.dataSource = self;
    [self.view addSubview:_iTable];

    UIView *iView = [[UIView alloc]init];
    [_iTable setBackgroundView:iView];

    self.view.backgroundColor = [UIColor colorWithRed:212/255.0f green:212/255.0f blue:212/255.0f alpha:1.0f];

}

#pragma -Mark Table Delegate
#pragma mark -
#pragma mark - Table View DataSource Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 1;
            break;
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //    if (cell == nil)
    //    {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    //      用於顯示各設定標簽的label
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 40)];
    tempLabel.textAlignment = NSTextAlignmentLeft;
    tempLabel.font = [UIFont boldSystemFontOfSize:18.0];
    tempLabel.textColor=[UIColor blackColor];
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.tag = 2000;
    [cell.contentView addSubview:tempLabel];
    UILabel *tLabel = (UILabel *)[cell.contentView viewWithTag:2000];
    tLabel.hidden = YES;

    
    
    if ([indexPath section]==0){
        
        switch ([indexPath row]){
            case 0:
                tLabel.hidden = NO;
                tLabel.text = @"个人资料";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.userInteractionEnabled = YES;
                break;
            case 1:
                tLabel.hidden = NO;
                tLabel.text = @"用户余额";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.userInteractionEnabled = YES;
                break;
        }
    }
    else if ([indexPath section]==1){
        tLabel.text = @"时金服務條款 ";
        tLabel.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.userInteractionEnabled = YES;
    }
    else if([indexPath section]==2){
        tLabel.hidden = NO;
        tLabel.text = @"用户充值";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.userInteractionEnabled = YES;

    }
    else if([indexPath section]==3){
        switch ([indexPath row]){
            case 0:
                tLabel.hidden = NO;
                tLabel.text = @"付款人列表";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.userInteractionEnabled = YES;
                break;
            case 1:
                tLabel.hidden = NO;
                tLabel.text = @"收款人列表";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.userInteractionEnabled = YES;
                break;
        }
    }
    else if ([indexPath section]==4)
    {
        tLabel.hidden = NO;
        tLabel.text = @"服务类别管理";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.userInteractionEnabled = YES;
    }
    
    //    cell.textLabel.text = ((Chapter *)[self.iDataArray objectAtIndex:[indexPath row]]).title;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    //    cell.selectionStyle = UITableViewCellEditingStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section// custom view for header. will be adjusted to default or specified header height
{
    if (section == 2)
    {
        return [self loginView:[NetWorkEngine shareInstance].isFlag];
    }
    return  nil;
}

- (UIView *)showUserInfo
{
    return nil;
}

- (UIView *)showLoginBtn
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 2)
    {
        return 55.0f;
    }
    return 12.0f;
}
#pragma mark -
#pragma mark Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==0){
        
        switch ([indexPath row]){
            case 0:
            {
                SJPersonalInfoVC *personalInfoVC = [[SJPersonalInfoVC alloc]init];
                [self.navigationController pushViewController:personalInfoVC animated:YES];
            }
                break;
            case 1:
            {
                SJUserBalanceVC *userVC = [[SJUserBalanceVC alloc]init];
                [self.navigationController pushViewController:userVC animated:YES];
            }
                break;
        }
    }
    else if ([indexPath section]==1){
        SJServiceTermsVC *serviceVC = [[SJServiceTermsVC alloc]init];
        [self.navigationController pushViewController:serviceVC animated:YES];
//        tLabel.text = @"时金服務條款 ";
//        tLabel.hidden = NO;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.userInteractionEnabled = YES;
    }
    else if ([indexPath section]==2){
//        tLabel.text = @"";
//        tLabel.hidden = NO;
//        tLabel.text = @"用户充值";
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.userInteractionEnabled = NO;
        SJAlipayVC *next = [[SJAlipayVC alloc]init];
        [self.navigationController pushViewController:next animated:YES];
        
    }
    else if ([indexPath section]==3){
        switch ([indexPath row]){
            case 0:
            {
                SJMutableListVC *next = [[SJMutableListVC alloc]init];
                [self.navigationController pushViewController:next animated:YES];
            }
                break;
            case 1:
            {
                SJMutableCollectionListVC *next = [[SJMutableCollectionListVC alloc]init];
                [self.navigationController pushViewController:next animated:YES];

            }
                break;
        }
    }
    else if([indexPath section]==4){
        SJMyServiceListVC *next = [[SJMyServiceListVC alloc]init];
        [self.navigationController pushViewController:next animated:YES];
    }
}

- (void)loginAction
{
//    SJSigninVC *signinVC = [[SJSigninVC alloc]init];
//    [self.navigationController pushViewController:signinVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)loginView:(BOOL)islogin
{
    UIView *iView;
    if (!islogin) {
        iView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAINSCREENWIDTH, 40)];
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [tempBtn setTitle: @"登陆" forState: UIControlStateNormal];
        tempBtn.frame = CGRectMake(20, 2, 80, 36);
        [tempBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        [iView addSubview:tempBtn];
        
        
        UIButton *tempBtn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [tempBtn1 setTitle: @"注册" forState: UIControlStateNormal];
        tempBtn1.frame = CGRectMake(120, 2, 80, 36);
        [tempBtn1 addTarget:self action:@selector(registered) forControlEvents:UIControlEventTouchUpInside];
        [iView addSubview:tempBtn1];
    }
    else{
        iView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAINSCREENWIDTH, 40)];
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 2, 200, 36)];
        tempLabel.text = [NetWorkEngine shareInstance].personID;
        tempLabel.backgroundColor = [UIColor clearColor];
        [iView addSubview:tempLabel];
        
        UIButton *tempBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [tempBtn1 setBackgroundImage:[UIImage imageNamed:@"center_sign_out.png"] forState:UIControlStateNormal];
        [tempBtn1 addTarget:self action:@selector(zhuxiao) forControlEvents:UIControlEventTouchUpInside];
        tempBtn1.frame = CGRectMake(0, 0, 57, 28);
        tempBtn1.center = CGPointMake(MAINSCREENWIDTH-38, 20);
        [iView addSubview:tempBtn1];
    }
    return iView;
}

- (void)registered
{
//    SJRegisteredVC *registered = [[SJRegisteredVC alloc]init];
//    [self.navigationController pushViewController:registered animated:YES];
}

- (void)zhuxiao
{
    [NetWorkEngine shareInstance].isFlag = NO;
    [[AppDelegate App] deleteUserInfo];
    [[AppDelegate App] autoLogin];
}


- (UIView *)tableView:(BOOL)islogin
{
    UIView *tView;
    if (islogin) {
        tView = [[UIView alloc]init];
        
    }
    return tView;
}
@end
