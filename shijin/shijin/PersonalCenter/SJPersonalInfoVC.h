//
//  personalInfoVC.h
//  shijin
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJPersonalInfoVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *_iDataSource;
    UITableView *_iTable;
}
@end
