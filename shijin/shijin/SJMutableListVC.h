//
//  SJMutableListVC.h
//  shijin
//
//  Created by apple on 13-9-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJMutableListVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_dataArr;
    NSMutableArray *_btnArray;
    UIScrollView *_mainList;//主要分类界面

}
@end
