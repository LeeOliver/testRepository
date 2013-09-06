//
//  SJAlipayVC.h
//  shijin
//
//  Created by apple on 13-9-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJAlipayVC : UIViewController<UITextFieldDelegate>
{
    UITextField *_fundText;
    BOOL bAlipay;
    UIButton    *_btnBackGround;

}
@end
