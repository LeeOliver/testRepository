//
//  RumexCustomTabBar.m
//  
//
//  Created by Oliver Farago on 19/06/2010.
//  Copyright 2010 Rumex IT All rights reserved.
//

#import "RXCustomTabBar.h"

@implementation RXCustomTabBar

@synthesize btn1, btn2;
@synthesize flag = _flag , preFlag = _preFlag;

- (id) init
{
    self = [super init];
    if (self) 
    {
        [self hideTabBar];
        _preFlag = YES;
        _flag = YES;
        [self addCustomElements];
        
    }
    return self;
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//	
//    //	[self hideTabBar];
//    //	[self addCustomElements];
//}

- (void)hideTabBar
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

- (void)hideNewTabBar 
{
    self.btn1.hidden = 1;
    self.btn2.hidden = 1;
//    self.btn3.hidden = 1;
}

- (void)ShowNewTabBar 
{
    self.btn1.hidden = 0;
    self.btn2.hidden = 0;
//    self.btn3.hidden = 0;
}

-(void)addCustomElements
{
	// Initialise our two images
	UIImage *btnImage = [UIImage imageNamed:@"tabbar_home.png"];
	UIImage *btnImageSelected = [UIImage imageNamed:@"tabbar_home_selected.png"];
	
	self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom]; //Setup the button
	btn1.frame = CGRectMake(0, MAINSCREENHEIGHT-50, 160, 50); // Set the frame (size and position) of the button)
	[btn1 setBackgroundImage:btnImage forState:UIControlStateNormal]; // Set the image for the normal state of the button
	[btn1 setBackgroundImage:btnImageSelected forState:UIControlStateSelected]; // Set the image for the selected state of the button
	[btn1 setTag:0]; // Assign the button a "tag" so when our "click" event is called we know which button was pressed.
	[btn1 setSelected:true]; // Set this button as selected (we will select the others to false as we only want Tab 1 to be selected initially
	
	// Now we repeat the process for the other buttons
	btnImage = [UIImage imageNamed:@"tabbar_setting.png"];
	btnImageSelected = [UIImage imageNamed:@"tabbar_setting_selected.png"];
	self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn2.frame = CGRectMake(160, MAINSCREENHEIGHT-50, 160, 50);
	[btn2 setBackgroundImage:btnImage forState:UIControlStateNormal];
	[btn2 setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
	[btn2 setTag:1];
	
    /*
	btnImage = [UIImage imageNamed:@"me_3.png"];
	btnImageSelected = [UIImage imageNamed:@"me_3a.png"];
	self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn3.frame = CGRectMake(214, 430, 108, 50);
	[btn3 setBackgroundImage:btnImage forState:UIControlStateNormal];
	[btn3 setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
	[btn3 setTag:2];
	*/
    chatbView = [[UIBadgeView alloc] initWithFrame:CGRectMake(70, 0, 30, 30)];
    [chatbView setBadgeColor:[UIColor redColor]];
    settingbView = [[UIBadgeView alloc] initWithFrame:CGRectMake(70, 0, 30, 30)];
    [settingbView setBadgeColor:[UIColor redColor]];
    
    [btn2 addSubview:chatbView];
    chatbView.hidden = YES;
//    [btn3 addSubview:settingbView];
    settingbView.hidden = YES;
    
	// Add my new buttons to the view
	[self.view addSubview:btn1];
	[self.view addSubview:btn2];
//	[self.view addSubview:btn3];
    
	// Setup event handlers so that the buttonClicked method will respond to the touch up inside event.
	[btn1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[btn2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//	[btn3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setChatBadgeValue:(int)value
{
    if (value<=0)
    {
        chatbView.hidden = YES;
    }else
    {
        chatbView.hidden = NO;
        [chatbView setBadgeString:[NSString stringWithFormat:@"%d",value]];
    }
}
- (void)setSettingBadgeValue:(int)value
{
    if (value<=0)
    {
        settingbView.hidden = YES;
    }else
    {
        settingbView.hidden = NO;
        [settingbView setBadgeString:[NSString stringWithFormat:@"%d",value]];
    }
}
- (void)buttonClicked:(id)sender
{
	int tagNum = [sender tag];
    if (tagNum == 0)
    {
        if (!_preFlag)
        {
            _flag = NO;
        }
        _preFlag = YES;
    }
    else
    {
        _preFlag = NO;
        _flag = YES;
    }
	[self selectTab:tagNum];
}

- (void)selectTab:(int)tabID
{
	switch(tabID)
	{
		case 0:
        {
//            [btn1 removeFromSuperview];
//            [self.view addSubview:btn1];
            [self.view bringSubviewToFront:btn1];
//            [self.view sendSubviewToBack:btn2];
//            [self.view sendSubviewToBack:btn3];
            btn1.frame = CGRectMake(0, MAINSCREENHEIGHT-50, 160, 50);
			[btn1 setSelected:true];
			[btn2 setSelected:false];
            btn2.frame = CGRectMake(160, MAINSCREENHEIGHT-50, 160, 50);
//			[btn3 setSelected:false];
//            btn3.frame = CGRectMake(214, 430, 108, 50);
			break;
        }
		case 1:
        {
			[btn1 setSelected:false];
            btn1.frame = CGRectMake(0, MAINSCREENHEIGHT-50, 160, 50);
//            [btn2 removeFromSuperview];
//            [self.view addSubview:btn2];
//            [btn2 addSubview:chatbView];
            [self.view bringSubviewToFront:btn2];

            btn2.frame = CGRectMake(160, MAINSCREENHEIGHT-50, 160, 50);
			[btn2 setSelected:true];
//			[btn3 setSelected:false];
//            btn3.frame = CGRectMake(214, 430, 108, 50);
			break;
        }
		case 2:
        {
			[btn1 setSelected:false];
            btn1.frame = CGRectMake(0, MAINSCREENHEIGHT-50, 108, 50);
			[btn2 setSelected:false];
            btn2.frame = CGRectMake(107, MAINSCREENHEIGHT-50, 108, 50);
//            [btn3 removeFromSuperview];
//            [self.view addSubview:btn3];
//            [btn3 addSubview:settingbView];
//            [self.view bringSubviewToFront:btn3];
//
//     
//			[btn3 setSelected:true];
//            btn3.frame = CGRectMake(208, 430, 114, 50);
			break;
        }
	}	
	self.selectedIndex = tabID;
}

- (void)dealloc {
	[btn1 release];
	[btn2 release];
//	[btn3 release];
    [super dealloc];
}

@end
