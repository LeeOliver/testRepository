//
//  SJGuideVC.m
//  shijin
//
//  Created by apple on 13-8-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJGuideVC.h"

@interface SJGuideVC ()

@end

@implementation SJGuideVC

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
    _kCount = 0;
    _mainGuide = [[UIScrollView alloc]initWithFrame:MAINSCREENRECT];
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=[UIColor colorWithRed:237.0/255.0f green:235.0/255.0f blue:220.0/255.0f alpha:1.0f];
    _mainGuide.pagingEnabled=YES;
    _mainGuide.scrollEnabled=YES;

    _mainGuide.delegate=self;
    _mainGuide.contentSize = CGSizeMake(960, 460);
    [self.view addSubview:_mainGuide];
    
    UIImageView *one;
    if (IS_IPHONE_4) {
        one = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_guide_one.png"]];
    }
    else if (IS_IPHONE_5){
        one = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_guide_one5.png"]];
    }

    one.frame = MAINSCREENRECT;
    [_mainGuide addSubview:one];
    
    UIImageView *two;
    if (IS_IPHONE_4) {
        two = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_guide_two.png"]];
    }
    else if (IS_IPHONE_5){
        two = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_guide_two5.png"]];
    }
    
    two.frame = CGRectMake(320, 0, MAINSCREENWIDTH, MAINSCREENHEIGHT);
    [_mainGuide addSubview:two];
    
    UIImageView *three;
    if (IS_IPHONE_4) {
        three = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_guide_three.png"]];
    }
    else if (IS_IPHONE_5){
        three = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_guide_three5.png"]];
    }
    
    three.frame = CGRectMake(640, 0, MAINSCREENWIDTH, MAINSCREENHEIGHT);
    [_mainGuide addSubview:three];

	// Do any additional setup after loading the view.
}
- (void)scrollViewDidScroll:(UIScrollView *)sender  //scollView的委托方法用于改变PageControl的page值
{
    CGFloat pageWidth = _mainGuide.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"%dsender.contentOffset.x=%f",page,sender.contentOffset.x);
    if (page == 2 && sender.contentOffset.x>660.0) {
        _kCount++;
        if (_kCount==1) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
            [[AppDelegate App]autoLogin];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
