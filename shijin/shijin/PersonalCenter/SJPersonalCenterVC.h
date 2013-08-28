//
//  SJPersonalCenterVC.h
//  shijin
//
//  Created by apple on 13-7-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJPersonalInfoVC.h"
#import "SJUserBalanceVC.h"
#import "SJServiceTermsVC.h"
@interface SJPersonalCenterVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_iTable;
}
- (void)loginAction;
- (void)registered;

@end
