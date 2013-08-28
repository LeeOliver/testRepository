//
//  SJServiceTermsVC.h
//  shijin
//
//  Created by apple on 13-8-9.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJServiceTermsVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_iTable;
    NSArray *_dataArr;
}

@end
