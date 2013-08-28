//
//  SJRegisteredVC.h
//  shijin
//
//  Created by apple on 13-7-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJRegisteredVC : UIViewController<UITextFieldDelegate>
{
    UIImageView *_mainImgView;
    UITextField *_nikeName;
    UITextField *_email;
    UITextField *_password;
    UITextField *_rePassword;
    
    UIButton    *_btnBackGround;
}
@end
