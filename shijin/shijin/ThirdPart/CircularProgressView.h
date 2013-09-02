//
//  CircularProgressView.h
//  CircularProgressView
//
//  Created by nijino saki on 13-3-2.
//  Copyright (c) 2013年 nijino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol CircularProgressDelegate;

@interface CircularProgressView : UIView
{
    float timeInt;
    NSDate *iStartDate;
}
@property (assign, nonatomic) id <CircularProgressDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
   secountBackColor:(UIColor *)secountBackColor
      progressColor:(UIColor *)progressColor
   appointmentColor:(UIColor *)appointmentColor
        minuteColor:(UIColor *)minuteColor
          lineWidth:(CGFloat)lineWidth
               time:(NSString *)iduration
appointmentProgress:(NSString *)appointmentProgress;
- (void)play;
- (void)revert;


@end

@protocol CircularProgressDelegate <NSObject>

- (void)didUpdateProgressView:(NSString *)iCurrentTime;

@end