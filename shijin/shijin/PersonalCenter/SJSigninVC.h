//
//  SJSigninVCViewController.h
//  shijin
//
//  Created by apple on 13-7-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJSigninVC : UIViewController<UITextFieldDelegate>
{
    UITextField *_tfLoginID;
    UITextField *_tfPassWord;
    UIButton    *_btnLogin;
    UIButton    *_btnLogin1;
    UIButton    *_btnLogin2;
    float keyboard;
    
    UIButton    *_btnBackGround;
}

@end
