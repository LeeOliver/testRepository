//
//  RumexCustomTabBar.h
//  
//
//  Created by Oliver Farago on 19/06/2010.
//  Copyright 2010 Rumex IT All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBadgeView.h"

@interface RXCustomTabBar : UITabBarController 
{
	UIButton *btn1;
	UIButton *btn2;
//	UIButton *btn3;
    UIBadgeView *chatbView;
    UIBadgeView *settingbView;
    BOOL _preFlag;//hh
    BOOL _flag;//hh
}

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
//@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, assign) BOOL flag;//hh
@property (nonatomic, assign) BOOL preFlag;//hh

-(void) hideTabBar;
-(void) addCustomElements;
-(void) selectTab:(int)tabID;
- (void)buttonClicked:(id)sender;

-(void) hideNewTabBar;
-(void) ShowNewTabBar;

- (void)setChatBadgeValue:(int)value;
- (void)setSettingBadgeValue:(int)value;

@end
