//
//  ClockView.h
//  clock
//
//  Created by Ignacio Enriquez Gutierrez on 1/31/11.
//  Copyright 2011 Nacho4D. All rights reserved.
//  See the file License.txt for copying permission.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ClockView : UIView {
    
	CALayer *containerLayer;
	CALayer *hourHand;
	CALayer *minHand;
	CALayer *secHand;
    
	NSTimer *timer;
    int  kSecount;
    int  kMinutes;
    
    NSDate *iStartDate;
    
}
@property (strong, nonatomic) UIColor *backColor;
@property (strong, nonatomic) UIColor *secountBackColor;
@property (strong, nonatomic) UIColor *progressColor;
@property (strong, nonatomic) UIColor *appointmentColor;
@property (strong, nonatomic) UIColor *minuteColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) float progress;
@property (assign, nonatomic) float SecountProgress;
@property (assign, nonatomic) float appointmentProgress;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) BOOL isTimeing;
@property (nonatomic) NSTimeInterval currentTime;
@property (nonatomic) NSTimeInterval duration;
@property (strong, nonatomic) NSString *stypeMode;

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
   secountBackColor:(UIColor *)secountBackColor
      progressColor:(UIColor *)progressColor
   appointmentColor:(UIColor *)appointmentColor
        minuteColor:(UIColor *)minuteColor
          lineWidth:(CGFloat)lineWidth
               time:(NSString *)iduration
appointmentProgress:(NSString *)appointmentProgress;

//basic methods
- (void)start;
- (void)stop;

//customize appearence
- (void)setHourHandImage:(CGImageRef)image;
- (void)setMinHandImage:(CGImageRef)image;
- (void)setSecHandImage:(CGImageRef)image;
- (void)setClockBackgroundImage:(CGImageRef)image;

//to customize hands size: adjust following values in .m file
//HOURS_HAND_LENGTH
//MIN_HAND_LENGTH
//SEC_HAND_LENGTH
//HOURS_HAND_WIDTH
//MIN_HAND_WIDTH
//SEC_HAND_WIDTH

@end
