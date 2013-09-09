//
//  ClockView.m
//  clock
//
//  Created by Ignacio Enriquez Gutierrez on 1/31/11.
//  Copyright 2011 Nacho4D. All rights reserved.
//  See the file License.txt for copying permission.
//

#import "ClockView.h"


@implementation ClockView

#pragma mark - Public Methods

- (void)start
{
    kSecount = 0;
    kMinutes = 0;
	timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClock:) userInfo:nil repeats:YES];
    
}

- (void)stop
{
	[timer invalidate];
	timer = nil;
}

//customize appearence
- (void)setHourHandImage:(CGImageRef)image
{
	if (image == NULL) {
        //		hourHand.backgroundColor = [UIColor blackColor].CGColor;
        //		hourHand.cornerRadius = 3;
        hourHand.hidden = YES;
	}else{
		hourHand.backgroundColor = [UIColor clearColor].CGColor;
		hourHand.cornerRadius = 0.0;
		hourHand.hidden = NO;
	}
	hourHand.contents = (id)image;
}

- (void)setMinHandImage:(CGImageRef)image
{
	if (image == NULL) {
        //		minHand.backgroundColor = [UIColor grayColor].CGColor;
        minHand.hidden = YES;
	}else{
		minHand.backgroundColor = [UIColor clearColor].CGColor;
        minHand.hidden = NO;
	}
	minHand.contents = (id)image;
}

- (void)setSecHandImage:(CGImageRef)image
{
	if (image == NULL) {
        //		secHand.backgroundColor = [UIColor whiteColor].CGColor;
        //		secHand.borderWidth = 1.0;
        //		secHand.borderColor = [UIColor grayColor].CGColor;
        secHand.hidden = YES;
	}else{
		secHand.backgroundColor = [UIColor clearColor].CGColor;
		secHand.borderWidth = 0.0;
		secHand.borderColor = [UIColor clearColor].CGColor;
        secHand.hidden = NO;
	}
	secHand.contents = (id)image;
}

- (void)setClockBackgroundImage:(CGImageRef)image
{
	if (image == NULL) {
		containerLayer.borderColor = [UIColor clearColor].CGColor;
		containerLayer.borderWidth = 0.0;
		containerLayer.cornerRadius = 0.0;
	}else{
		containerLayer.borderColor = [UIColor clearColor].CGColor;
		containerLayer.borderWidth = 0.0;
		containerLayer.cornerRadius = 0.0;
	}
	containerLayer.contents = (id)image;
}

#pragma mark - Private Methods

//Default sizes of hands:
//in percentage (0.0 - 1.0)
#define HOURS_HAND_LENGTH 0.65
#define MIN_HAND_LENGTH 0.75
#define SEC_HAND_LENGTH 0.8
//in pixels
#define HOURS_HAND_WIDTH 10
#define MIN_HAND_WIDTH 8
#define SEC_HAND_WIDTH 4

float Degrees2Radians(float degrees) { return degrees * M_PI / 180; }

//timer callback
- (void) updateClock:(NSTimer *)theTimer{
	
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"HH:mm:ss"];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
    kSecount++;
    if (kSecount>= 60) {
        kSecount = 0;
        kMinutes++;
    }
    NSDate *date =[dateFormat dateFromString:[NSString stringWithFormat:@"00:%2d:%2d",kMinutes,kSecount ]];
    
    
	NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
	NSInteger seconds = [dateComponents second];
	NSInteger minutes = [dateComponents minute];
	NSInteger hours = [dateComponents hour];
	NSLog(@"raw: hours:%d min:%d secs:%d", hours, minutes, seconds);
	if (hours > 12) hours -=12; //PM
    
	//set angles for each of the hands
	CGFloat secAngle = Degrees2Radians(seconds/60.0*360);
	CGFloat minAngle = Degrees2Radians(minutes/60.0*360);
	CGFloat hourAngle = Degrees2Radians(hours/12.0*360) + minAngle/12.0;
	
	//reflect the rotations + 180 degres since CALayers coordinate system is inverted
	secHand.transform = CATransform3DMakeRotation (secAngle+M_PI, 0, 0, 1);
	minHand.transform = CATransform3DMakeRotation (minAngle+M_PI, 0, 0, 1);
	hourHand.transform = CATransform3DMakeRotation (hourAngle+M_PI, 0, 0, 1);
    
    self.SecountProgress = kSecount / 60.0f;
    self.progress = kMinutes / 60.0f;
    
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    NSNumber *aRadius = [NSNumber numberWithFloat:self.frame.size.width / 2 - self.lineWidth / 2 - 5];
    NSNumber *aAngle  = [NSNumber numberWithFloat:(CGFloat)(1.5 * M_PI)];
    //circle 背景 外圈
    //    [self drawCircleBy:self.backColor andRadius:aRadius andAngle:aAngle andLineWidth:self.lineWidth];
    //中心画园
    CGPoint point = CGPointMake(self.frame.size.width / 2,self.frame.size.height / 2);
    //circle 预约背景 外圈
    NSNumber *aAngle2  = [NSNumber numberWithFloat:(CGFloat)(-M_PI_2 + self.appointmentProgress * 2 * M_PI)];
    [self drawCircleBy:self.appointmentColor andRadius:aRadius andAngle:aAngle2 andLineWidth:self.lineWidth andCenter:point];
    
    
    if (self.progress != 0) {//circle 跑动 外圈
        NSNumber *aAngle1  = [NSNumber numberWithFloat:(CGFloat)(-M_PI_2 + self.progress * 2 * M_PI)];
        [self drawCircleBy:self.minuteColor andRadius:aRadius andAngle:aAngle1 andLineWidth:self.lineWidth andCenter:point];
    }
    
    //circle 背景 内圈
    NSNumber *aRadius1 = [NSNumber numberWithFloat:44];
    //    [self drawCircleBy:self.secountBackColor andRadius:aRadius1 andAngle:aAngle andLineWidth:self.lineWidth];
    CGPoint point1 = CGPointMake(self.frame.size.width / 2 - 24,self.frame.size.height / 2 + 22);
    
    if (self.SecountProgress != 0) {//circle 跑动 内圈
        NSNumber *aAngle1  = [NSNumber numberWithFloat:(CGFloat)(-M_PI_2 + self.SecountProgress * 2 * M_PI)];
        [self drawCircleBy:self.progressColor andRadius:aRadius1 andAngle:aAngle1 andLineWidth:2.0f andCenter:point1];
    }
}
- (void)drawCircleBy:(UIColor *)circleColor andRadius:(NSNumber *)aRadius andAngle:(NSNumber *)aAangle andLineWidth:(CGFloat)aLineWidth andCenter:(CGPoint)aPoint
{
    UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:aPoint radius:[aRadius floatValue] startAngle:(CGFloat) -M_PI_2 endAngle:(CGFloat)[aAangle floatValue] clockwise:YES];
    [circleColor setStroke];
    progressCircle.lineWidth = aLineWidth;
    [progressCircle stroke];
    
}

#pragma mark - Overrides

- (void) layoutSubviews
{
	[super layoutSubviews];
    
	containerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
	float length = MIN(self.frame.size.width, self.frame.size.height)/2;
	CGPoint c = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGPoint point1 = CGPointMake(self.frame.size.width / 2 - 24,self.frame.size.height / 2 + 22);
    //指针中心位置
	hourHand.position = minHand.position = c;
    secHand.position = point1;
    
	CGFloat w, h;
	
	if (hourHand.contents == NULL){
		w = HOURS_HAND_WIDTH;
		h = length*HOURS_HAND_LENGTH;
	}else{
		w = CGImageGetWidth((CGImageRef)hourHand.contents);
		h = CGImageGetHeight((CGImageRef)hourHand.contents);
	}
	hourHand.bounds = CGRectMake(0,0,w,h);
	
	if (minHand.contents == NULL){
		w = MIN_HAND_WIDTH;
		h = length*MIN_HAND_LENGTH;
	}else{
		w = CGImageGetWidth((CGImageRef)minHand.contents);
		h = CGImageGetHeight((CGImageRef)minHand.contents);
	}
	minHand.bounds = CGRectMake(0,0,w,h);
	
	if (secHand.contents == NULL){
		w = SEC_HAND_WIDTH;
		h = length*SEC_HAND_LENGTH;
	}else{
		w = CGImageGetWidth((CGImageRef)secHand.contents);
		h = CGImageGetHeight((CGImageRef)secHand.contents);
	}
	secHand.bounds = CGRectMake(0,0,w,h);
    
	hourHand.anchorPoint = CGPointMake(0.5,0.0);
	minHand.anchorPoint = CGPointMake(0.5,0.2);
	secHand.anchorPoint = CGPointMake(0.5,0.2);
	containerLayer.anchorPoint = CGPointMake(0.5, 0.5);
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		containerLayer = [[CALayer layer] retain];
		hourHand = [[CALayer layer] retain];
		minHand = [[CALayer layer] retain];
		secHand = [[CALayer layer] retain];
		//default appearance
		[self setClockBackgroundImage:NULL];
		[self setHourHandImage:NULL];
		[self setMinHandImage:NULL];
		[self setSecHandImage:NULL];
		
		//add all created sublayers
		[containerLayer addSublayer:hourHand];
		[containerLayer addSublayer:minHand];
		[containerLayer addSublayer:secHand];
		[self.layer addSublayer:containerLayer];
	}
	return self;
}
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
        self.backColor = backColor;
        self.secountBackColor = secountBackColor;
        self.progressColor = progressColor;
        self.lineWidth = lineWidth;
        self.appointmentColor = appointmentColor;
        self.minuteColor = minuteColor;
        self.progress = 0.0f;
        self.SecountProgress = 0.0f;
        self.appointmentProgress = [appointmentProgress floatValue]/60.0f;
        self.duration = [iduration floatValue];
        self.isTimeing = NO;
        
        containerLayer = [[CALayer layer] retain];
		hourHand = [[CALayer layer] retain];
		minHand = [[CALayer layer] retain];
		secHand = [[CALayer layer] retain];
		//default appearance
		[self setClockBackgroundImage:NULL];
		[self setHourHandImage:NULL];
		[self setMinHandImage:NULL];
		[self setSecHandImage:NULL];
		
		//add all created sublayers
		[containerLayer addSublayer:hourHand];
		[containerLayer addSublayer:minHand];
		[containerLayer addSublayer:secHand];
		[self.layer addSublayer:containerLayer];
        
    }
    return self;
}

- (void)dealloc
{
	[self stop];
	[hourHand release];
	[minHand release];
	[secHand release];
	[containerLayer release];
	[super dealloc];
}

@end