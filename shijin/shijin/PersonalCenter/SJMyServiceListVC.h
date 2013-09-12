//
//  SJMyServiceListVC.h
//  shijin
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJMyServiceListVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_iTable;
    NSArray *_iDataArr;
}
@end
