//
//  SJReservationVCViewController.m
//  shijin
//
//  Created by apple on 13-7-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJReservationVCViewController.h"

#define PAYMENTVIEWTAG 0x10001
#define RECEIVEVIEWTAG 0x10011
#define SCROLLVIEWTAG  0x10111
#define TABLEVIEWTAG   0x11111
#define WAITINGVIEW    0x10100
#define REQUESTVIEW    0x10101
#define TIMINGVIEW     0x11001
@interface SJReservationVCViewController ()

@end

@implementation SJReservationVCViewController
@synthesize isShowTable;
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
    self.view.backgroundColor = [UIColor colorWithRed:212/255.0f green:212/255.0f blue:212/255.0f alpha:1.0f];
    isShowTable = NO;
    isCountTimeView = NO;
    
    [self initPayment];
    [self initReceive];
    [self showViewByISPayment:[NetWorkEngine shareInstance].isPayment];

    UIView *topView = [[AppDelegate App] creatNavigationView];
    SVSegmentedControl *navSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"付款", @"收款", nil]];
    navSC.selectedIndex = [NetWorkEngine shareInstance].isPayment?0:1;
    navSC.changeHandler = ^(NSUInteger newIndex) {
        if (newIndex == 0) {
            [NetWorkEngine shareInstance].isPayment = YES;
        }
        else{
            [NetWorkEngine shareInstance].isPayment = NO;
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view
                                                      animated:YES];
            HUD.labelText = @"正在加載";

            [[NetWorkEngine shareInstance]getRequestInfoByResponserId:[NetWorkEngine shareInstance].userID delegate:self sel:@selector(updateUI:)];
        }
        [self showViewByISPayment:[NetWorkEngine shareInstance].isPayment];
    };
    
	[topView addSubview:navSC];
    navSC.textShadowOffset = CGSizeMake(0, 0);
    navSC.textColor = [UIColor whiteColor];
	navSC.backgroundImage = [UIImage imageNamed:@"segmented.png"];
    navSC.thumb.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"segmented_selected.png"]];
    navSC.thumb.textShadowOffset = CGSizeMake(0, 0);
	navSC.center = CGPointMake(160, 25);
    
    [self.view addSubview:topView];
    //查找类别返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backbtn.png"] forState:UIControlStateNormal];
    backBtn.tag = 1002;
    [backBtn addTarget:self action:@selector(backScrollView) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(9, 7, 40, 30);
    backBtn.center = CGPointMake(MAINSCREENWIDTH-45, 25);
    [topView addSubview:backBtn];
    backBtn.hidden = !isShowTable;
	// Do any additional setup after loading the view.
    
    _btnBackGround = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnBackGround.frame = self.view.frame;
    _btnBackGround.backgroundColor = [UIColor clearColor];
    _btnBackGround.userInteractionEnabled = NO;
    [_btnBackGround addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnBackGround];
    [self.view bringSubviewToFront:_btnBackGround];
}
- (void)backScrollView
{
    isShowTable = NO;
    [self showViewByISPayment:[NetWorkEngine shareInstance].isPayment];
}
//付款界面
- (void)initPayment
{
    _paymentView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, MAINSCREENWIDTH, MAINSCREENHEIGHT-20-50-50)];
    _paymentView.tag = PAYMENTVIEWTAG;
    
    //分类scroll
    _reservationList = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, MAINSCREENWIDTH, MAINSCREENHEIGHT-20-50-50-35)];
    _reservationList.pagingEnabled = YES;
    _reservationList.tag = SCROLLVIEWTAG;
    
    //网络获取分类列表
    [[NetWorkEngine shareInstance] asyncGetCategoryListOfComplete:^(NSDictionary *returnData)
     {
         if (returnData &&
             [[returnData objectForKeyNotNull:FLAG] isEqualToString:@"1" ])//发送文本成功
         {
             _dataArr = [returnData objectForKeyNotNull:RETURNDATA];
             [self initReservationList];
         }
         else
         {
             _dataArr = nil;
         }
     }];

    //邮箱查询输入框
    UIView *viewEmail = [[UIView alloc]initWithFrame:CGRectMake(10, 5, 270, 30)];
    viewEmail.backgroundColor = [UIColor whiteColor];
    [_paymentView addSubview:viewEmail];
    
    //邮箱查询按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"reservation_search_btn.png"] forState:UIControlStateNormal];
    searchBtn.tag = 1001;
    [searchBtn addTarget:self action:@selector(searchEmailAction) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(280, 5, 30, 30);
    [_paymentView addSubview:searchBtn];

    _emailSerch = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, 270, 30)];
    _emailSerch.placeholder = @"邮箱地址查找";
    _emailSerch.delegate = self;
    [_emailSerch setBorderStyle:UITextBorderStyleNone];
    _emailSerch.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _emailSerch.backgroundColor = [UIColor clearColor];
    [_paymentView addSubview:_emailSerch];
    
    //分类查询邮箱查询结果显示
    _iTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, MAINSCREENWIDTH, MAINSCREENHEIGHT-20-50-50-35) style:UITableViewStylePlain];
    _iTable.delegate = self;//http://devimages.apple.com/maintenance/
    _iTable.dataSource = self;
    _iTable.tag = TABLEVIEWTAG;
    _iTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_iTable setBackgroundColor:[UIColor clearColor]];
    //设置透明
    UIView *iView = [[UIView alloc]init];
    [_iTable setBackgroundView:iView];
}
//邮箱查询方法
- (void)searchEmailAction
{
    if (!_emailSerch.text || [_emailSerch.text isEqualToString:@""]) {
        [[AppDelegate App]showAlert:@"提示!" andMessage:@"请输入邮箱地址"];
    }
    else
    {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view
                                                  animated:YES];
        HUD.labelText = @"正在加載";
        [[NetWorkEngine shareInstance] userListSearchByEmail:_emailSerch.text delegate:self sel:@selector(returnData:)];
    }
}
//邮箱查询成功回调
- (void)returnData:(NSArray *)iDataArr
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    if (iDataArr && ![iDataArr isKindOfClass:[NSNull class]] && [iDataArr count]>0) {
        _tabviewdata = iDataArr;
        [_iTable reloadData];
        isShowTable = YES;
        [self showViewByISPayment:[NetWorkEngine shareInstance].isPayment];
    }
    else{
        [[AppDelegate App]showAlert:@"提示！" andMessage:@"没有找到您要找的用户"];
    }
}
//显示分类按钮图标
- (void)initReservationList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"reservationList" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    int hang;
    for (int i=0; i<[_dataArr count]; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:[dic objectForKey:[[_dataArr objectAtIndex:i]objectForKey:@"cid"]]] forState:UIControlStateNormal];
        btn.tag = [[[_dataArr objectAtIndex:i]objectForKey:@"cid"]intValue];
        hang = i / 3;
        int lie  = i % 3;
        btn.frame = CGRectMake(10+(lie)*5+96*(lie), 5+hang*5+96*hang, 96, 96);
        [btn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
        [_reservationList addSubview:btn];
    }
    _reservationList.contentSize = CGSizeMake(MAINSCREENWIDTH, 5+hang*10+96*hang+96+10);
}
//类别查询
- (void)searchAction:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    int selectID = btn.tag;
    NSString *strID = [NSString stringWithFormat:@"%d",selectID];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view
                                              animated:YES];
    HUD.labelText = @"正在加載";
    [[NetWorkEngine shareInstance]userListSearchByCategories:strID delegate:self sel:@selector(returnData:)];
}
//收费界面
- (void)initReceive
{
    _receive = [[UIView alloc]initWithFrame:CGRectMake(0, 30, MAINSCREENWIDTH, MAINSCREENHEIGHT-20-30-50)];
    _receive.tag = RECEIVEVIEWTAG;
}
- (void)updateViewUI
{
    //请求界面    
    _requestServer.text = [NSString stringWithFormat:@"服务商:%@", _requesterStr];
    
    _requestTime.text = [NSString stringWithFormat:@"预约服务时间:%@分钟", _serviceTime];
}
- (void)acceptAction
{
    //收款人请求按钮
    [[NetWorkEngine shareInstance]sendreceiveRequestByResponserId:[NetWorkEngine shareInstance].userID andRequesterId:[_iDataForResponstor objectForKey:@"requester_id"] andServiceTime:[_iDataForResponstor objectForKey:@"service_time"] delegate:self sel:@selector(acceptReturn:)];
}
- (void)acceptReturn:(NSDictionary*)iData
{
    //切换界面
    if (iData && [iData objectForKey:@"flag"]) {
        isCountTimeView = YES;
        [self showViewByISPayment:[NetWorkEngine shareInstance].isPayment];
        [[SJTimeEngine shareInstance]loopTimerByTime:@"3" delegate:self sel:@selector(getReicpient)];
    }
}
- (void)checkMeeting
{
    [[NetWorkEngine shareInstance]checkMeetingByResponserId:[NetWorkEngine shareInstance].userID andRequesterId:[_iDataForResponstor objectForKey:@"requester_id"] delegate:self sel:@selector(checkMeetingReturn:)];
}
- (void)checkMeetingReturn:(NSDictionary *)iData
{
    if ([[iData objectForKey:@"fund_flag"] isEqualToString:@"N"]) {
        [[SJTimeEngine shareInstance]stopTimer];
        isCountTimeView = NO;
        [self showViewByISPayment:[NetWorkEngine shareInstance].isPayment];
    }else{
        [[NetWorkEngine shareInstance]getReicpientByResponserId:[NetWorkEngine shareInstance].userID andRequesterId:[_iDataForResponstor objectForKey:@"requester_id"] andFund:[_iDataForResponstor objectForKey:@"rate"] andShowTime:[_iDataForResponstor objectForKey:@"service_time"] delegate:self sel:@selector(getReicpientReturn:)];
    }
}
- (void)getReicpient
{
    [[NetWorkEngine shareInstance]getReicpientByResponserId:[NetWorkEngine shareInstance].userID andRequesterId:[_iDataForResponstor objectForKey:@"requester_id"] andFund:[_iDataForResponstor objectForKey:@"rate"] andShowTime:[_iDataForResponstor objectForKey:@"service_time"] delegate:self sel:@selector(getReicpientReturn:)];

}
- (void)getReicpientReturn:(NSDictionary *)iData
{
    _timingTimeStr.text = [NSString stringWithFormat:@"服务商:%@", _requesterStr];
    if (![[iData objectForKey:@"start"] isKindOfClass:[NSNull class]] && [[iData objectForKey:@"start"]isEqualToString:@"Y"]) {
        _timingTitle.text = @"服务状态 ：开始计时";
        _timingLabel.text = [NSString stringWithFormat:@"服务时间:%@分钟",[iData objectForKey:@"responser_time"]];
    }
    else if((![[iData objectForKey:@"start"] isKindOfClass:[NSNull class]] && [[iData objectForKey:@"start"]isEqualToString:@"S"]) ||
            [[iData objectForKey:@"start"] isKindOfClass:[NSNull class]])
    {
        [[SJTimeEngine shareInstance]stopTimer];
        isCountTimeView = NO;
        [self showViewByISPayment:[NetWorkEngine shareInstance].isPayment];
    }
}

//显示界面
- (void)showViewByISPayment:(BOOL)iPayment
{
    if (iPayment) {

        UIButton *btn = (UIButton*)[self.view viewWithTag:1002];
        btn.hidden = !isShowTable;

        //显示table或者scrollview
        if (isShowTable) {
            //查找类别
            if ([self.view viewWithTag:SCROLLVIEWTAG]){
                [_reservationList removeFromSuperview];
            }
            if ([self.view viewWithTag:TABLEVIEWTAG]) {
                return;
            }
            [_paymentView addSubview:_iTable];
        }
        else{
            //浏览类别
            if ([self.view viewWithTag:TABLEVIEWTAG]){
                [_iTable removeFromSuperview];
            }
            if ([self.view viewWithTag:SCROLLVIEWTAG]) {
                return;
            }
            [_paymentView addSubview:_reservationList];
        }
    
        //付款 界面
        if ([self.view viewWithTag:RECEIVEVIEWTAG]){
            [_receive removeFromSuperview];
        }
        if ([self.view viewWithTag:PAYMENTVIEWTAG]){
            return;
        }

        [self.view addSubview:_paymentView];
        
        [self.view bringSubviewToFront:_btnBackGround];
    }
    else
    {
        //收款界面
        if ([self.view viewWithTag:PAYMENTVIEWTAG]){
            [_paymentView removeFromSuperview];
        }
        if ([self.view viewWithTag:RECEIVEVIEWTAG]){
            return;
        }
        [self.view addSubview:_receive];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _btnBackGround.userInteractionEnabled = NO;

    if ([_emailSerch isFirstResponder])
    {
        [_emailSerch resignFirstResponder];
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!_btnBackGround.userInteractionEnabled) {
        _btnBackGround.userInteractionEnabled = YES;
    }
    return  YES;
}
- (void)hideKeyBoard
{
    _btnBackGround.userInteractionEnabled = NO;
    if ([_emailSerch isFirstResponder])
    {
        [_emailSerch resignFirstResponder];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    UIButton *btn = (UIButton*)[self.view viewWithTag:1002];
    btn.hidden = !isShowTable;
    

    [super viewWillAppear:animated];
    [[AppDelegate App] showTabBar];
    [[AppDelegate App] hidenNavigation:self.navigationController];
    [self showViewByISPayment:[NetWorkEngine shareInstance].isPayment];
}
- (void)updateUI:(NSDictionary*)iDic
{
    UIButton *btn = (UIButton*)[self.view viewWithTag:1002];
    btn.hidden = YES;
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    _iDataForResponstor = iDic;
    if (!_receiveCollectionVC) {
        _receiveCollectionVC = [[SJCollectionVC alloc]init];
        [_receive addSubview:_receiveCollectionVC.view];
    }
    if (iDic &&
        ![iDic isKindOfClass:[NSNull class]] &&
        [iDic count]>0 &&
        [iDic objectForKey:@"service_time"] &&
        ![[iDic objectForKey:@"service_time"]isKindOfClass:[NSNull class]]) {
        [AppDelegate App].kUIflag = kCOLLECTIONUI_II;
        [_receiveCollectionVC setDataSource:iDic];
    }
    else{
        [AppDelegate App].kUIflag = kCOLLECTIONUI_I;
        [_receiveCollectionVC setDataSource:nil];
    }
    [self showViewByISPayment:[NetWorkEngine shareInstance].isPayment];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (!_tabviewdata || [_tabviewdata isKindOfClass:[NSNull class]] || [_tabviewdata count] < 1) {
        return 0;
    }
    return [_tabviewdata count]*2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    //      用於顯示各設定標簽的label
    
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
    bgView.frame = CGRectMake(0, 0, 320, 85);
    [cell.contentView addSubview:bgView];
    bgView.hidden = YES;
    bgView.tag = 2003;
    UIImageView *bgImage = (UIImageView *)[cell.contentView viewWithTag:2003];
        
    UIImageView *picView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reservation_pic.png"]];
    picView.frame = CGRectMake(25, 10, 65, 64);
    [cell.contentView addSubview:picView];
    picView.hidden = YES;
    picView.tag = 2005;
    UIImageView *tImage = (UIImageView *)[cell.contentView viewWithTag:2005];

    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 8, 200, 14)];
    tempLabel.textAlignment = NSTextAlignmentLeft;
    tempLabel.font = [UIFont boldSystemFontOfSize:13.0];
    tempLabel.textColor=[UIColor colorWithRed:70/255.0f green:100/255.0f blue:130/255.0f alpha:1.0f];
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.tag = 2000;
    [cell.contentView addSubview:tempLabel];
    UILabel *sLabel = (UILabel *)[cell.contentView viewWithTag:2000];
    
    UILabel *tempLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 25, 200, 14)];
    tempLabel2.textAlignment = NSTextAlignmentLeft;
    tempLabel2.font = [UIFont boldSystemFontOfSize:13.0];
    tempLabel2.textColor=[UIColor colorWithRed:70/255.0f green:100/255.0f blue:130/255.0f alpha:1.0f];
    tempLabel2.backgroundColor = [UIColor clearColor];
    tempLabel2.tag = 3000;
    [cell.contentView addSubview:tempLabel2];
    UILabel *nLabel = (UILabel *)[cell.contentView viewWithTag:3000];
    
    UILabel *tempLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(100, 43, 200, 14)];
    tempLabel3.textAlignment = NSTextAlignmentLeft;
    tempLabel3.font = [UIFont boldSystemFontOfSize:13.0];
    tempLabel3.textColor=[UIColor colorWithRed:70/255.0f green:100/255.0f blue:130/255.0f alpha:1.0f];
    tempLabel3.backgroundColor = [UIColor clearColor];
    tempLabel3.tag = 4000;
    [cell.contentView addSubview:tempLabel3];
    UILabel *eLabel = (UILabel *)[cell.contentView viewWithTag:4000];

    UILabel *tempLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, 200, 14)];
    tempLabel4.textAlignment = NSTextAlignmentLeft;
    tempLabel4.font = [UIFont boldSystemFontOfSize:13.0];
    tempLabel4.textColor=[UIColor colorWithRed:70/255.0f green:100/255.0f blue:130/255.0f alpha:1.0f];
    tempLabel4.backgroundColor = [UIColor clearColor];
    tempLabel4.tag = 5000;
    [cell.contentView addSubview:tempLabel4];
    UILabel *fLabel = (UILabel *)[cell.contentView viewWithTag:5000];

    switch ([indexPath row]%2){
        case 0:
            tImage.hidden = NO;
            bgImage.hidden = NO;
            sLabel.text =  [NSString stringWithFormat:@"%@-%@",[[_tabviewdata objectAtIndex:[indexPath row]/2]objectForKey:@"nickName"],[[_tabviewdata objectAtIndex:[indexPath row]/2]objectForKey:@"user_commodity"]];
            nLabel.text = [NSString stringWithFormat:@"名字:%@",[[_tabviewdata objectAtIndex:[indexPath row]/2]objectForKey:@"nickName"]];
            eLabel.text =  [NSString stringWithFormat:@"电子邮件:%@",[[_tabviewdata objectAtIndex:[indexPath row]/2]objectForKey:@"email"]];
            fLabel.text =  [NSString stringWithFormat:@"费率:%@元/每分钟",[[_tabviewdata objectAtIndex:[indexPath row]/2]objectForKey:@"com_rate"]];


            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = YES;
            break;
        case 1:
            tImage.hidden = YES;
            cell.userInteractionEnabled = NO;
            break;
    }
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row]%2==0) {
        return 85.0f;
    }
    else{
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [AppDelegate App].kUIflag = kRESERVATIONUI_I;
    SJReservationVC *next = [[SJReservationVC alloc]init];
    next.dataDic = [_tabviewdata objectAtIndex:[indexPath row]/2];
    
    [self.navigationController pushViewController:next animated:YES];
}
@end
