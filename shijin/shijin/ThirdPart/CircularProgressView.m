//
//  CircularProgressView.m
//  CircularProgressView
//
//  Created by nijino saki on 13-3-2.
//  Copyright (c) 2013年 nijino. All rights reserved.
//

#import "CircularProgressView.h"

@interface CircularProgressView ()

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
@end

@implementation CircularProgressView

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
   secountBackColor:(UIColor *)secountBackColor
      progressColor:(UIColor *)progressColor
   appointmentColor:(UIColor *)appointmentColor
        minuteColor:(UIColor *)minuteColor
          lineWidth:(CGFloat)lineWidth
               time:(NSString *)iduration
appointmentProgress:(NSString *)appointmentProgress
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        _backColor = backColor;
        _secountBackColor = secountBackColor;
        _progressColor = progressColor;
        _lineWidth = lineWidth;
        _appointmentColor = appointmentColor;
        _minuteColor = minuteColor;
        self.progress = 0.0f;
        self.SecountProgress = 0.0f;
        self.appointmentProgress = [appointmentProgress floatValue]/60.0f;
        self.duration = [iduration floatValue];
        self.isTimeing = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSNumber *aRadius = [NSNumber numberWithFloat:self.bounds.size.width / 2 - self.lineWidth / 2];
    NSNumber *aAngle  = [NSNumber numberWithFloat:(CGFloat)(1.5 * M_PI)];
    //circle 背景 外圈
    [self drawCircleBy:self.backColor andRadius:aRadius andAngle:aAngle andLineWidth:self.lineWidth];
    
    //circle 预约背景 外圈
    NSNumber *aAngle2  = [NSNumber numberWithFloat:(CGFloat)(-M_PI_2 + self.appointmentProgress * 2 * M_PI)];
    [self drawCircleBy:self.appointmentColor andRadius:aRadius andAngle:aAngle2 andLineWidth:self.lineWidth];

    
    if (self.progress != 0) {//circle 跑动 外圈
        NSNumber *aAngle1  = [NSNumber numberWithFloat:(CGFloat)(-M_PI_2 + self.progress * 2 * M_PI)];
        [self drawCircleBy:self.minuteColor andRadius:aRadius andAngle:aAngle1 andLineWidth:self.lineWidth];
    }
    
    //circle 背景 内圈
    NSNumber *aRadius1 = [NSNumber numberWithFloat:self.bounds.size.width / 2 - self.lineWidth * 1.5];
    [self drawCircleBy:self.secountBackColor andRadius:aRadius1 andAngle:aAngle andLineWidth:self.lineWidth];
    
    if (self.SecountProgress != 0) {//circle 跑动 内圈
        NSNumber *aAngle1  = [NSNumber numberWithFloat:(CGFloat)(-M_PI_2 + self.SecountProgress * 2 * M_PI)];
        [self drawCircleBy:self.progressColor andRadius:aRadius1 andAngle:aAngle1 andLineWidth:self.lineWidth];
    }
}

- (void)drawCircleBy:(UIColor *)circleColor andRadius:(NSNumber *)aRadius andAngle:(NSNumber *)aAangle andLineWidth:(CGFloat)aLineWidth
{
    UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2) radius:[aRadius floatValue] startAngle:(CGFloat) -M_PI_2 endAngle:(CGFloat)[aAangle floatValue] clockwise:YES];
    [circleColor setStroke];
    progressCircle.lineWidth = aLineWidth;
    [progressCircle stroke];
}
- (void)updateProgressCircle{
    //update progress value
    
    
    NSDate *date = [[NSDate alloc]init];
    NSLog(@"%f",[date timeIntervalSinceDate:iStartDate]);
    self.currentTime = [date timeIntervalSinceDate:iStartDate];
    
    self.SecountProgress = (int)self.currentTime % 60 / 60.0f;
    self.progress = (int)(self.currentTime / 60) / 60.0f;
    NSLog(@"\nself.SecountProgress   =   %f,\nself.progress   =   %f",self.SecountProgress,self.progress);
    
    //redraw back & progress circles
    [self setNeedsDisplay];
    
    if (self.progress>=1) {
        [self.timer invalidate];
        self.isTimeing = NO;
        self.currentTime = 0;
        self.progress = 0;
    }
    
    if ((int)self.currentTime % 500 == 0 && (int)self.currentTime/500 > 1 && self.delegate && [self.delegate conformsToProtocol:@protocol(CircularProgressDelegate)]) {
        [self.delegate didUpdateProgressView:[NSString stringWithFormat:@"%f",self.currentTime]];
    }
}

- (void)play{
    if (self.progress == 0 && self.SecountProgress == 0) {
        iStartDate = [NSDate date];
    }
    if (!self.isTimeing) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateProgressCircle) userInfo:nil repeats:YES];
        [self.timer fire];
        self.isTimeing = YES;

    }
}

- (void)revert{
    self.isTimeing = NO;
    iStartDate = [NSDate date];
    [self.timer invalidate];
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(CircularProgressDelegate)]) {
        [self.delegate didUpdateProgressView:[NSString stringWithFormat:@"%f",self.currentTime]];
    }

    [self updateProgressCircle];
}

@end
