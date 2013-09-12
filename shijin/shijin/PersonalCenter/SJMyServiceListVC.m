//
//  SJMyServiceListVC.m
//  shijin
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJMyServiceListVC.h"

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
- (void)initTable
{
    //分类查询邮箱查询结果显示
    _iTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, MAINSCREENWIDTH, MAINSCREENHEIGHT-20-50-50-35) style:UITableViewStylePlain];
    _iTable.delegate = self;//http://devimages.apple.com/maintenance/
    _iTable.dataSource = self;
    _iTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_iTable setBackgroundColor:[UIColor clearColor]];
    //设置透明
    UIView *iView = [[UIView alloc]init];
    [_iTable setBackgroundView:iView];
    self.view.backgroundColor = [UIColor colorWithRed:212/255.0f green:212/255.0f blue:212/255.0f alpha:1.0f];

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
        return 1;
    }
    return [_iDataArr count]+1;
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
    
    switch ([indexPath row]){
        case 0:
            tImage.hidden = NO;
            bgImage.hidden = NO;
            sLabel.text =  [NSString stringWithFormat:@"%@-%@",[[_iDataArr objectAtIndex:[indexPath row]/2]objectForKey:@"nickName"],[[_iDataArr objectAtIndex:[indexPath row]/2]objectForKey:@"user_commodity"]];
            nLabel.text = [NSString stringWithFormat:@"名字:%@",[[_iDataArr objectAtIndex:[indexPath row]/2]objectForKey:@"nickName"]];
            eLabel.text =  [NSString stringWithFormat:@"电子邮件:%@",[[_iDataArr objectAtIndex:[indexPath row]/2]objectForKey:@"email"]];
            fLabel.text =  [NSString stringWithFormat:@"费率:%@元/每分钟",[[_iDataArr objectAtIndex:[indexPath row]/2]objectForKey:@"com_rate"]];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = YES;
            break;
            default:
        {
            tImage.hidden = NO;
            bgImage.hidden = NO;
            sLabel.text =  [NSString stringWithFormat:@"%@-%@",[[_iDataArr objectAtIndex:[indexPath row]/2]objectForKey:@"nickName"],[[_iDataArr objectAtIndex:[indexPath row]/2]objectForKey:@"user_commodity"]];
            nLabel.text = [NSString stringWithFormat:@"名字:%@",[[_iDataArr objectAtIndex:[indexPath row]/2]objectForKey:@"nickName"]];
            eLabel.text =  [NSString stringWithFormat:@"电子邮件:%@",[[_iDataArr objectAtIndex:[indexPath row]/2]objectForKey:@"email"]];
            fLabel.text =  [NSString stringWithFormat:@"费率:%@元/每分钟",[[_iDataArr objectAtIndex:[indexPath row]/2]objectForKey:@"com_rate"]];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = YES;

        }
            break;
    }
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}
@end
