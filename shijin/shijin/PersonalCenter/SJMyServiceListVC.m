//
//  SJMyServiceListVC.m
//  shijin
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJMyServiceListVC.h"
#import "SJAddOrUpdateServiceVC.h"
@interface SJMyServiceListVC ()

@end

@implementation SJMyServiceListVC

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
    [self initTable];
	// Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [[NetWorkEngine shareInstance]getMyServiceListByUserId:[NetWorkEngine shareInstance].userID delegate:self sel:@selector(getDataArrRetrun:)];
}
- (void)getDataArrRetrun:(NSArray*)iDataArr
{
    _iDataArr = [NSMutableArray arrayWithArray:iDataArr];
    [_iTable reloadData];
}
- (void)initTable
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
    
    
    _iTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, MAINSCREENWIDTH, MAINSCREENHEIGHT-20-50-50-35) style:UITableViewStylePlain];
    _iTable.delegate = self;//http://devimages.apple.com/maintenance/
    _iTable.dataSource = self;
    _iTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_iTable setBackgroundColor:[UIColor clearColor]];
    //设置透明
    UIView *iView = [[UIView alloc]init];
    [_iTable setBackgroundView:iView];
    self.view.backgroundColor = [UIColor colorWithRed:212/255.0f green:212/255.0f blue:212/255.0f alpha:1.0f];
    [self.view addSubview:_iTable];
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
#pragma -Mark Table Delegate
#pragma mark -
#pragma mark - Table View DataSource Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_iDataArr || [_iDataArr isKindOfClass:[NSNull class]] || [_iDataArr count] < 1) {
        return 2;
    }
    return [_iDataArr count]+2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    //      用於顯示各設定標簽的label
    
    ///第一行背景
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"consulting_top.png"]];
    bgView.frame = CGRectMake(0, 0, 320, 40);
    [cell.contentView addSubview:bgView];
    bgView.hidden = YES;
    bgView.tag = 2003;
    UIImageView *bgImage = (UIImageView *)[cell.contentView viewWithTag:2003];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 200, 20)];
    topLabel.textAlignment = NSTextAlignmentLeft;
    topLabel.font = [UIFont boldSystemFontOfSize:13.0];
    topLabel.textColor=[UIColor colorWithRed:70/255.0f green:100/255.0f blue:130/255.0f alpha:1.0f];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.tag = 1000;
    topLabel.center = CGPointMake(140, 20);
    [cell.contentView addSubview:topLabel];
    UILabel *sTopLabel = (UILabel *)[cell.contentView viewWithTag:1000];

    //竖线分割线
    UIImageView *shuxianView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"consulting_bigline.png"]];
    shuxianView.frame = CGRectMake(60, 0, 1, 40);
    [cell.contentView addSubview:shuxianView];
    shuxianView.hidden = YES;
    shuxianView.tag = 2004;
    UIImageView *shuxianImage = (UIImageView *)[cell.contentView viewWithTag:2004];

    UIImageView *shuxianView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"consulting_bigline.png"]];
    shuxianView1.frame = CGRectMake(120, 0, 1, 40);
    [cell.contentView addSubview:shuxianView1];
    shuxianView1.hidden = YES;
    shuxianView1.tag = 2005;
    UIImageView *shuxianImage1 = (UIImageView *)[cell.contentView viewWithTag:2005];

    UIImageView *shuxianView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"consulting_bigline.png"]];
    shuxianView2.frame = CGRectMake(180, 0, 1, 40);
    [cell.contentView addSubview:shuxianView2];
    shuxianView2.hidden = YES;
    shuxianView2.tag = 2006;
    UIImageView *shuxianImage2 = (UIImageView *)[cell.contentView viewWithTag:2006];

    UIImageView *shuxianView3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"consulting_bigline.png"]];
    shuxianView3.frame = CGRectMake(220, 0, 1, 40);
    [cell.contentView addSubview:shuxianView3];
    shuxianView3.hidden = YES;
    shuxianView3.tag = 2007;
    UIImageView *shuxianImage3 = (UIImageView *)[cell.contentView viewWithTag:2007];
    
    ///序号服务号
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, 60, 14)];
    tempLabel.textAlignment = NSTextAlignmentLeft;
    tempLabel.font = [UIFont boldSystemFontOfSize:12.0];
    tempLabel.textColor=[UIColor colorWithRed:70/255.0f green:100/255.0f blue:130/255.0f alpha:1.0f];
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.textAlignment = NSTextAlignmentCenter;
    tempLabel.tag = 2000;
    [cell.contentView addSubview:tempLabel];
    UILabel *sLabel = (UILabel *)[cell.contentView viewWithTag:2000];
    
    UILabel *tempLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(60, 12, 60, 14)];
    tempLabel2.textAlignment = NSTextAlignmentLeft;
    tempLabel2.font = [UIFont boldSystemFontOfSize:12.0];
    tempLabel2.textColor=[UIColor colorWithRed:70/255.0f green:100/255.0f blue:130/255.0f alpha:1.0f];
    tempLabel2.backgroundColor = [UIColor clearColor];
    tempLabel2.textAlignment = NSTextAlignmentCenter;
    tempLabel2.tag = 3000;
    [cell.contentView addSubview:tempLabel2];
    UILabel *sLabel2 = (UILabel *)[cell.contentView viewWithTag:3000];
    
    UILabel *tempLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(120, 12, 60, 14)];
    tempLabel3.textAlignment = NSTextAlignmentLeft;
    tempLabel3.font = [UIFont boldSystemFontOfSize:12.0];
    tempLabel3.textColor=[UIColor colorWithRed:70/255.0f green:100/255.0f blue:130/255.0f alpha:1.0f];
    tempLabel3.backgroundColor = [UIColor clearColor];
    tempLabel3.textAlignment = NSTextAlignmentCenter;
    tempLabel3.tag = 4000;
    [cell.contentView addSubview:tempLabel3];
    UILabel *sLabel3 = (UILabel *)[cell.contentView viewWithTag:4000];
    
    UILabel *tempLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(180, 12, 40, 14)];
    tempLabel4.textAlignment = NSTextAlignmentLeft;
    tempLabel4.font = [UIFont boldSystemFontOfSize:12.0];
    tempLabel4.textColor=[UIColor colorWithRed:70/255.0f green:100/255.0f blue:130/255.0f alpha:1.0f];
    tempLabel4.backgroundColor = [UIColor clearColor];
    tempLabel4.textAlignment = NSTextAlignmentCenter;
    tempLabel4.tag = 5000;
    [cell.contentView addSubview:tempLabel4];
    UILabel *sLabel4 = (UILabel *)[cell.contentView viewWithTag:5000];
    
    UILabel *tempLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(220, 12, 100, 14)];
    tempLabel5.textAlignment = NSTextAlignmentLeft;
    tempLabel5.font = [UIFont boldSystemFontOfSize:12.0];
    tempLabel5.textColor=[UIColor colorWithRed:70/255.0f green:100/255.0f blue:130/255.0f alpha:1.0f];
    tempLabel5.backgroundColor = [UIColor clearColor];
    tempLabel5.textAlignment = NSTextAlignmentCenter;
    tempLabel5.tag = 6000;
    [cell.contentView addSubview:tempLabel5];
    UILabel *sLabel5 = (UILabel *)[cell.contentView viewWithTag:6000];

    UIImageView *shuxianView9 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"consulting_line.png"]];
    shuxianView9.frame = CGRectMake(270, 10, 1, 20);
    [cell.contentView addSubview:shuxianView9];
    shuxianView9.hidden = YES;
    shuxianView9.tag = 2009;
    UIImageView *shuxianImage9 = (UIImageView *)[cell.contentView viewWithTag:2009];

    
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setTitle:@"修改" forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(updateMessage:) forControlEvents:UIControlEventTouchUpInside];
    [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tempBtn.frame = CGRectMake(220, 0, 50, 40);
    tempBtn.tag = 7000;
    tempBtn.hidden = YES;
    [cell.contentView addSubview:tempBtn];
    UIButton *sBtn = (UIButton*)[cell.contentView viewWithTag:7000];
    
    UIButton *tempBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn1 setTitle:@"删除" forState:UIControlStateNormal];
    [tempBtn1 addTarget:self action:@selector(addMessage:) forControlEvents:UIControlEventTouchUpInside];
    [tempBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tempBtn1.frame = CGRectMake(270, 0, 50, 40);
    tempBtn1.tag = 7001;
    tempBtn1.hidden = YES;
    [cell.contentView addSubview:tempBtn1];
    UIButton *sBtn1 = (UIButton*)[cell.contentView viewWithTag:7001];
    
    UIButton *tempBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn2 setTitle:@"添加" forState:UIControlStateNormal];
    [tempBtn2 addTarget:self action:@selector(addMessage:) forControlEvents:UIControlEventTouchUpInside];
    [tempBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tempBtn2.frame = CGRectMake(270, 0, 50, 40);
    tempBtn2.tag = 7002;
    tempBtn2.hidden = YES;
    [cell.contentView addSubview:tempBtn2];
    UIButton *sBtn2 = (UIButton*)[cell.contentView viewWithTag:7002];

    switch ([indexPath row]){
        case 0:
        {
            shuxianImage.hidden = YES;
            shuxianImage1.hidden = YES;
            shuxianImage2.hidden = YES;
            shuxianImage3.hidden = YES;
            shuxianImage9.hidden = YES;
            sBtn.hidden = YES;
            sBtn1.hidden = YES;
            sBtn2.hidden = NO;
            bgImage.hidden = NO;
            bgImage.image = [UIImage imageNamed:@"consulting_top.png"];
            sTopLabel.hidden = NO;
            sTopLabel.text = @"我的服务";
            sLabel.hidden = YES;
        }
            break;
            
        case 1:
        {
            shuxianImage.hidden = NO;
            shuxianImage1.hidden = NO;
            shuxianImage2.hidden = NO;
            shuxianImage3.hidden = NO;
            shuxianImage9.hidden = YES;
            sBtn1.hidden = YES;

            sBtn.hidden = YES;
            bgImage.hidden = NO;
            bgImage.image = [UIImage imageNamed:@"consulting_name.png"];
            sLabel.text =  @"服务名称";
            sLabel2.text = @"服务类别";
            sLabel3.text = @"￥/min";
            sLabel4.text = @"状态";
            sLabel5.text = @"管理";
        }
            break;
            default:
        {
            shuxianImage.hidden = NO;
            shuxianImage1.hidden = NO;
            shuxianImage2.hidden = NO;
            shuxianImage3.hidden = NO;
            shuxianImage9.hidden = NO;
            sBtn1.hidden = NO;

            sBtn.hidden = NO;
            
            bgImage.hidden = NO;
            bgImage.image = [UIImage imageNamed:@"consulting_body.png"];
            sLabel.text = [NSString stringWithFormat:@"%@",[[[_iDataArr objectAtIndex:[indexPath row]-2] objectForKey:[NSString stringWithFormat:@"%d",[indexPath row]-1]] objectForKey:@"NAME"]];
            sLabel2.text = [NSString stringWithFormat:@"%@",[[[_iDataArr objectAtIndex:[indexPath row]-2] objectForKey:[NSString stringWithFormat:@"%d",[indexPath row]-1]] objectForKey:@"TYPE"]];
            sLabel3.text = [NSString stringWithFormat:@"%@",[[[_iDataArr objectAtIndex:[indexPath row]-2] objectForKey:[NSString stringWithFormat:@"%d",[indexPath row]-1]] objectForKey:@"CATE"]];
            sLabel4.text = [NSString stringWithFormat:@"%@",[[[_iDataArr objectAtIndex:[indexPath row]-2] objectForKey:[NSString stringWithFormat:@"%d",[indexPath row]-1]] objectForKey:@"STATUS"]];
            
            sBtn1.tag = [indexPath row]-2;
            sBtn.tag = [indexPath row]-2;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.userInteractionEnabled = YES;

        }
            break;
    }
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (void)updateMessage:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    SJAddOrUpdateServiceVC *next = [[SJAddOrUpdateServiceVC alloc]init];
    next.iDataPerson = [[_iDataArr objectAtIndex:btn.tag]objectForKey:[NSString stringWithFormat:@"%d",btn.tag+1]];
    [self.navigationController pushViewController:next animated:YES];
}
- (void)addMessage:(id)sender
{
    SJAddOrUpdateServiceVC *next = [[SJAddOrUpdateServiceVC alloc]init];
    [self.navigationController pushViewController:next animated:YES];
}
- (void)deleteMessage:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    [[NetWorkEngine shareInstance] deleteMyServiceByComId:[[[_iDataArr objectAtIndex:btn.tag]objectForKey:[NSString stringWithFormat:@"%d",btn.tag+1]]objectForKey:@"COMID"] delegate:nil sel:nil];
    [_iDataArr removeObjectAtIndex:btn.tag];
    [_iTable reloadData];
}
@end
