//
//  SJCategoryListVC.h
//  shijin
//
//  Created by apple on 13-8-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJCategoryListVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_iTable;
    NSArray *_dataArr;//数据源
}
@end
