//
//  SJAlipayWebVC.h
//  shijin
//
//  Created by apple on 13-9-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJAlipayWebVC : UIViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
}
@property (nonatomic, strong) NSString *fundStr;

@end
