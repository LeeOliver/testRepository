//
//  SJCategoryListVC.m
//  shijin
//
//  Created by apple on 13-8-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJCategoryListVC.h"

@interface SJCategoryListVC ()

@end

@implementation SJCategoryListVC

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
    [self.view addSubview:[[AppDelegate App]creatNavigationView]];
    _iTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, MAINSCREENWIDTH, MAINSCREENHEIGHT-20-44-50) style:UITableViewStylePlain];
    _iTable.delegate = self;
    _iTable.dataSource = self;
    [self.view addSubview:_iTable];
    
    [[NetWorkEngine shareInstance] asyncGetCategoryListOfComplete:^(NSDictionary *returnData)
     {
         if (returnData &&
             [[returnData objectForKeyNotNull:FLAG] isEqualToString:@"1" ])//发送文本成功
         {
             NSLog(@"%@",[returnData objectForKeyNotNull:RETURNDATA]);
             _dataArr = [returnData objectForKeyNotNull:RETURNDATA];
             [_iTable reloadData];
//             [self performSelectorOnMainThread:@selector(reloadTableData) withObject:nil waitUntilDone:NO];
         }
         else
         {
             NSLog(@"%@",[returnData objectForKeyNotNull:RETURNDATA]);
             _dataArr = nil;
             [_iTable reloadData];
//             [self performSelectorOnMainThread:@selector(reloadTableData) withObject:nil waitUntilDone:NO];
         }
     }];

}
- (void)reloadTableData
{
    [_iTable reloadData];
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
    if (_dataArr && [_dataArr count]>0) {
        return [_dataArr count];
    }
    return 1;
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
    tempLabel.textAlignment = UITextAlignmentLeft;
    tempLabel.font = [UIFont boldSystemFontOfSize:18.0];
    tempLabel.textColor=[UIColor blackColor];
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.tag = 2000;
    [cell.contentView addSubview:tempLabel];
    UILabel *tLabel = (UILabel *)[cell.contentView viewWithTag:2000];
    
    
    if (_dataArr && [_dataArr count]>0) {
        tLabel.text = [[_dataArr objectAtIndex:[indexPath row]]objectForKey:@"cname"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        tLabel.text = @"网络请求，请稍等";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [AppDelegate App].reservationVC.isShowTable = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
