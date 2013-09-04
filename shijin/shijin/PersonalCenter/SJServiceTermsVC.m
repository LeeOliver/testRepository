//
//  SJServiceTermsVC.m
//  shijin
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJServiceTermsVC.h"

@interface SJServiceTermsVC ()

@end

@implementation SJServiceTermsVC

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
- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    _iTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, MAINSCREENWIDTH, MAINSCREENHEIGHT-20-50-50) style:UITableViewStylePlain];
    _iTable.delegate = self;
    _iTable.dataSource = self;
    [self.view addSubview:_iTable];
    _iTable.backgroundColor = [UIColor clearColor];
    UIView *iView = [[UIView alloc]init];
    [_iTable setBackgroundView:iView];
    _iTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    NSString *path = [[NSBundle mainBundle] pathForResource:@"serviceTerms" ofType:@"plist"];
    _dataArr = [NSArray arrayWithContentsOfFile:path];

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
    return 8*2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    //      用於顯示各設定標簽的label
    cell.userInteractionEnabled = NO;

    UIImageView *bgView = [AppDelegate fullCellBackground];
    [cell.contentView addSubview:bgView];
    bgView.hidden = NO;
    bgView.tag = 2003;
    UIImageView *bgImage = (UIImageView *)[cell.contentView viewWithTag:2003];

    
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 2, 280, 70)];
    tempLabel.textAlignment = NSTextAlignmentLeft;
    tempLabel.textColor=[UIColor colorWithRed:70/255.0f green:100/255.0f blue:130/255.0f alpha:1.0f];
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.tag = 2000;
    tempLabel.textAlignment = NSTextAlignmentLeft;
    tempLabel.numberOfLines = 0;
    [cell.contentView addSubview:tempLabel];
    UILabel *sLabel = (UILabel *)[cell.contentView viewWithTag:2000];
        
    switch ([indexPath row]){
        case 0:
        {
            sLabel.font = [UIFont boldSystemFontOfSize:[[[_dataArr objectAtIndex:0] objectForKey:@"textFont"]floatValue]];
            sLabel.frame = CGRectMake(20, 2, 280, [[[_dataArr objectAtIndex:0] objectForKey:@"height"]floatValue]-4);
            sLabel.text = [[_dataArr objectAtIndex:0] objectForKey:@"contentStr"];
            bgImage.hidden = YES;
            tempLabel.textColor=[UIColor blackColor];

        }
            break;
        case 2:
        {
            sLabel.font = [UIFont boldSystemFontOfSize:[[[_dataArr objectAtIndex:1] objectForKey:@"textFont"]floatValue]];
            sLabel.frame = CGRectMake(20, 2, 280, [[[_dataArr objectAtIndex:1] objectForKey:@"height"]floatValue]-4);
            sLabel.text = [[_dataArr objectAtIndex:1] objectForKey:@"contentStr"];
            bgImage.frame = CGRectMake(10, 0, 300, [[[_dataArr objectAtIndex:1] objectForKey:@"height"]floatValue]);
            tempLabel.textColor=[UIColor colorWithRed:97/255.0f green:97/255.0f blue:97/255.0f alpha:1.0f];

        }
            break;
        case 4:
        {
            sLabel.font = [UIFont boldSystemFontOfSize:[[[_dataArr objectAtIndex:2] objectForKey:@"textFont"]floatValue]];
            sLabel.frame = CGRectMake(20, 2, 280, [[[_dataArr objectAtIndex:2] objectForKey:@"height"]floatValue]-4);
            sLabel.text = [[_dataArr objectAtIndex:2] objectForKey:@"contentStr"];
            bgImage.frame = CGRectMake(10, 0, 300, [[[_dataArr objectAtIndex:2] objectForKey:@"height"]floatValue]);

        }
            break;
        case 6:
        {
            sLabel.font = [UIFont boldSystemFontOfSize:[[[_dataArr objectAtIndex:3] objectForKey:@"textFont"]floatValue]];
            sLabel.frame = CGRectMake(20, 2, 280, [[[_dataArr objectAtIndex:3] objectForKey:@"height"]floatValue]-4);
            sLabel.text = [[_dataArr objectAtIndex:3] objectForKey:@"contentStr"];
            bgImage.frame = CGRectMake(10, 0, 300, [[[_dataArr objectAtIndex:3] objectForKey:@"height"]floatValue]);
            tempLabel.textColor=[UIColor colorWithRed:97/255.0f green:97/255.0f blue:97/255.0f alpha:1.0f];

        }
            break;
        case 8:
        {
            sLabel.font = [UIFont boldSystemFontOfSize:[[[_dataArr objectAtIndex:4] objectForKey:@"textFont"]floatValue]];
            sLabel.frame = CGRectMake(20, 2, 280, [[[_dataArr objectAtIndex:4] objectForKey:@"height"]floatValue]-4);
            sLabel.text = [[_dataArr objectAtIndex:4] objectForKey:@"contentStr"];
            bgImage.frame = CGRectMake(10, 0, 300, [[[_dataArr objectAtIndex:4] objectForKey:@"height"]floatValue]);
            tempLabel.textColor=[UIColor colorWithRed:97/255.0f green:97/255.0f blue:97/255.0f alpha:1.0f];

        }
            break;
        case 10:
        {
            sLabel.font = [UIFont boldSystemFontOfSize:[[[_dataArr objectAtIndex:5] objectForKey:@"textFont"]floatValue]];
            sLabel.frame = CGRectMake(20, 2, 280, [[[_dataArr objectAtIndex:5] objectForKey:@"height"]floatValue]-4);
            sLabel.text = [[_dataArr objectAtIndex:5] objectForKey:@"contentStr"];
            bgImage.frame = CGRectMake(10, 0, 300, [[[_dataArr objectAtIndex:5] objectForKey:@"height"]floatValue]);
            tempLabel.textColor=[UIColor colorWithRed:97/255.0f green:97/255.0f blue:97/255.0f alpha:1.0f];

        }
            break;
        case 12:
        {
            sLabel.font = [UIFont boldSystemFontOfSize:[[[_dataArr objectAtIndex:6] objectForKey:@"textFont"]floatValue]];
            sLabel.frame = CGRectMake(20, 2, 280, [[[_dataArr objectAtIndex:6] objectForKey:@"height"]floatValue]-4);
            sLabel.text = [[_dataArr objectAtIndex:6] objectForKey:@"contentStr"];
            bgImage.frame = CGRectMake(10, 0, 300, [[[_dataArr objectAtIndex:6] objectForKey:@"height"]floatValue]);

        }
            break;
        case 14:
        {
            sLabel.font = [UIFont boldSystemFontOfSize:[[[_dataArr objectAtIndex:7] objectForKey:@"textFont"]floatValue]];
            sLabel.frame = CGRectMake(20, 2, 280, [[[_dataArr objectAtIndex:7] objectForKey:@"height"]floatValue]-4);
            sLabel.text = [[_dataArr objectAtIndex:7] objectForKey:@"contentStr"];
            bgImage.frame = CGRectMake(10, 0, 300, [[[_dataArr objectAtIndex:7] objectForKey:@"height"]floatValue]);
            tempLabel.textColor=[UIColor colorWithRed:97/255.0f green:97/255.0f blue:97/255.0f alpha:1.0f];

        }
            break;
        default:
        {
            bgImage.hidden = YES;
        }
            break;

    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row]%2==0) {
        
        return [[[_dataArr objectAtIndex:[indexPath row]/2] objectForKey:@"height"]floatValue];
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


@end
