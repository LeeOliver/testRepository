//
//  SJMutableCollectionListVC.m
//  shijin
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJMutableCollectionListVC.h"

@interface SJMutableCollectionListVC ()

@end

@implementation SJMutableCollectionListVC

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
	// Do any additional setup after loading the view.
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NetWorkEngine shareInstance] getRequestByRequestId:[NetWorkEngine shareInstance].userID orResponseId:nil ddelegate:self sel:@selector(updateUI:)];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view
                                              animated:YES];
    HUD.labelText = @"正在加載";

}
- (void)initUI
{
    UIView *topView = [[AppDelegate App]creatNavigationView];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLable.text = @"收款人列表";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.center = CGPointMake(MAINSCREENWIDTH / 2, topView.frame.size.height / 2);
    [topView addSubview:titleLable];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"center_back.png"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 44, 32);
    backBtn.center = CGPointMake(MAINSCREENWIDTH-45, 25);
    [backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    [self.view addSubview:topView];
    
    //    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, MAINSCREENHEIGHT-50-50-20)];
    //    _mainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"center_alipay_bg.png"]];
    //    [self.view addSubview:_mainView];
    
    //分类scroll
    _mainList = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, MAINSCREENWIDTH, MAINSCREENHEIGHT-20-50-50)];
    _mainList.pagingEnabled = YES;
    [self.view addSubview:_mainList];
    
    self.view.backgroundColor = [UIColor colorWithRed:212/255.0f green:212/255.0f blue:212/255.0f alpha:1.0f];
    
//    [self updateScrollView];
}
- (void)updateUI:(NSArray*)iData
{
    _dataArr = iData;
    [self updateScrollView];
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}

- (void)updateScrollView
{
    int hang;
    
    for (int i=0; i<[_dataArr count]; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [btn setBackgroundImage:[UIImage imageNamed:[dic objectForKey:[[_dataArr objectAtIndex:i]objectForKey:@"cid"]]] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:103.0f/255.0f green:191.0f/255.0f blue:212.0f/255.0f alpha:1.0f]];
        btn.tag = [[[[_dataArr objectAtIndex:i]allKeys] objectAtIndex:0]intValue];
        hang = i / 3;
        NSString *btnTitle = [[[_dataArr objectAtIndex:i]objectForKey:[NSString stringWithFormat:@"%d",btn.tag]]objectForKey:@"name"];
        [btn setTitle:btnTitle forState:UIControlStateNormal];

        btn.layer.cornerRadius = 96/2;
        btn.layer.masksToBounds = YES;
        [[btn layer] setBorderWidth:2];
        [[btn layer] setBorderColor:[UIColor whiteColor].CGColor];
        
        
        int lie  = i % 3;
        btn.frame = CGRectMake(10+(lie)*5+96*(lie), 10+hang*5+96*hang, 96, 96);
        [btn addTarget:self action:@selector(enterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_mainList addSubview:btn];
    }
    _mainList.contentSize = CGSizeMake(MAINSCREENWIDTH, 5+hang*10+96*hang+96+10);
    
}
- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)enterBtnAction:(id)sender
{
    //    UIButton *btn = (UIButton*)sender;
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view
                                              animated:YES];
    HUD.labelText = @"正在加載";
    [HUD hide:YES afterDelay:3];
    switch ([AppDelegate App].kUIflag) {
        case kRESERVATIONUI_I:
        case kRESERVATIONUI_II:
        case kRESERVATIONUI_III:
        case kRESERVATIONUI_IV:
        case kRESERVATIONUI_V:
        {
            [[AppDelegate App]enterReservation:self.navigationController andData:nil andUIFlag:kRESERVATIONUI_I];
        }
            break;
        case kCOLLECTIONUI_I:
        case kCOLLECTIONUI_II:
        case  kCOLLECTIONUI_III:
        case kCOLLECTIONUI_IV:
        {
            [[AppDelegate App]enterCollection:self.navigationController andData:nil andUIFlag:kCOLLECTIONUI_I];
        }
            break;
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
