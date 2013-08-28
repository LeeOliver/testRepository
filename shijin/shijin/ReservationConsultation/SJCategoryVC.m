//
//  categoryVC.m
//  shijin
//
//  Created by apple on 13-7-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJCategoryVC.h"

@interface SJCategoryVC ()

@end

@implementation SJCategoryVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y+44, self.tableView.frame.size.width, self.tableView.frame.size.height);

    [[NetWorkEngine shareInstance] asyncGetCategoryListOfComplete:^(NSDictionary *returnData)
     {
         if (returnData &&
             [[returnData objectForKeyNotNull:FLAG] isEqualToString:@"1" ])//发送文本成功
         {
             NSLog(@"%@",[returnData objectForKeyNotNull:RETURNDATA]);
             dataArr = [returnData objectForKeyNotNull:RETURNDATA];
             [self.tableView reloadData];
         }
         else
         {
             NSLog(@"%@",[returnData objectForKeyNotNull:RETURNDATA]);
             dataArr = nil;
             [self.tableView reloadData];
         }
     }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.view addSubview:[[AppDelegate App] creatNavigationView]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    if (dataArr && [dataArr count]>0) {
        return [dataArr count];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    // Configure the cell...
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 40)];
    tempLabel.textAlignment = UITextAlignmentLeft;
    tempLabel.font = [UIFont boldSystemFontOfSize:18.0];
    tempLabel.textColor=[UIColor blackColor];
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.tag = 2000;
    [cell.contentView addSubview:tempLabel];
    UILabel *tLabel = (UILabel *)[cell.contentView viewWithTag:2000];
    tLabel.hidden = YES;
    
    
    tLabel.hidden = NO;
    tLabel.text = @"网络请求，请稍等";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.userInteractionEnabled = YES;

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

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
