//
//  ViewController.m
//  Clock
//
//  Created by dancho on 9/24/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize numbers ;
@synthesize qualifiers;

@synthesize one;
@synthesize two;
@synthesize three;
@synthesize four;
@synthesize five;
@synthesize six;
@synthesize seven;
@synthesize eight;
@synthesize nine;
@synthesize ten;
@synthesize eleven;
@synthesize twelve;

@synthesize oclock;
@synthesize fiveQual;
@synthesize tenQual;
@synthesize twenty;
@synthesize half;
@synthesize quarter;
@synthesize minutes;
@synthesize to;
@synthesize past;
@synthesize itsLbl;

@synthesize lightColor;
@synthesize defaultLetterColor;

- (void)viewDidLoad
{   
    [super viewDidLoad];
    self.numbers = [[NSArray alloc]initWithObjects:one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve, nil];
    self.qualifiers = [[NSArray alloc]initWithObjects:half,ten,quarter,twenty,five,minutes, to,past, oclock,tenQual, fiveQual, nil];
    [self formatLbls];
   
    UIBarButtonItem *adminButton = [[UIBarButtonItem alloc] initWithTitle:@"Admin" style:UIBarButtonItemStyleBordered target:self action:@selector(goToAdministrationFlow:)];
    self.navigationItem.rightBarButtonItem = adminButton;
    
    [self lightTheWords];

    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(lightTheWords) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];
       // [self test];

}
-(void)formatLbls{
    self.view.backgroundColor = [UIColor blackColor];
    self.lightColor = [UIColor whiteColor];
    self.defaultLetterColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.itsLbl.textColor = self.lightColor;
    self.itsLbl.font = [UIFont boldSystemFontOfSize:20];
    [self setDefaultLetterColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)lightTheWords{
    int h = [self currentHour];
    [self setDefaultLetterColor];
    
    
    if ( [self currentMinutes] >= 55) {
        // minutes = @"five to";
        [self changeColor:fiveQual:self.lightColor];
        [self changeColor:minutes:self.lightColor];
        [self changeColor:to:self.lightColor];
        h++;
    }else if( [self currentMinutes] >= 50) {
        [self changeColor:tenQual:self.lightColor];
        [self changeColor:minutes:self.lightColor];
        [self changeColor:to:self.lightColor];
        // minutes = @"ten to";
        h++;
    }else if( [self currentMinutes] >= 45) {
        [self changeColor:quarter:self.lightColor];
        [self changeColor:to:self.lightColor];
        // minutes = @"quarter to";
        h++;
    }else if( [self currentMinutes] >= 40){
        [self changeColor:twenty:self.lightColor];
        [self changeColor:minutes:self.lightColor];
        [self changeColor:to:self.lightColor];
        // minutes = @"twenty to";
        h++;
    }else if( [self currentMinutes] >= 30) {
        [self changeColor:half:self.lightColor];
        [self changeColor:past:self.lightColor];
        
    }else if ( [self currentMinutes] >= 20) {
        [self changeColor:twenty:self.lightColor];
        [self changeColor:minutes:self.lightColor];
        [self changeColor:past:self.lightColor];
        // minutes = @"twenty past";
    }else if( [self currentMinutes] >= 15) {
        [self changeColor:quarter:self.lightColor];
        [self changeColor:past:self.lightColor];
        // minutes = @"quarter past";
    }else if ( [self currentMinutes] >= 10) {
        [self changeColor:tenQual:self.lightColor];
        [self changeColor:minutes:self.lightColor];
        [self changeColor:past:self.lightColor];
        // minutes = @"ten past";
    }else if( [self currentMinutes] >= 5) {
        [self changeColor:fiveQual:self.lightColor];
        [self changeColor:minutes:self.lightColor];
        [self changeColor:past:self.lightColor];
            }else if( [self currentMinutes] >= 0){
        [self changeColor:oclock:self.lightColor];
        // minutes = @"o'clock";
    }
    if(h == [self currentHour]){
        
        
       NSInteger hour = [self currentHour];
          [self changeColor:numbers[hour-1]:self.lightColor];
    } else {
        [self changeColor:numbers[h-1]:self.lightColor];
    }
    //hour = numbers[h];
    
   
}

-(void)changeColor:(UILabel *)lblName : (UIColor*) color{
    lblName.textColor = color;
}

- (NSInteger)currentHour
{
    // In practice, these calls can be combined
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSHourCalendarUnit fromDate:now];
    if([components hour]>12)
    return [components hour] - 12;
    else return [components hour];
}

- (NSInteger)currentMinutes
{
        NSDate *now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSHourCalendarUnit  | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now];
    NSInteger minute = [dateComponents minute];
    return minute;
}
-(void)setDefaultLetterColor {
    for(int i=0;i<[self.numbers count];i++){
        [self changeColor:[self.numbers objectAtIndex:i]:self.defaultLetterColor];
    }
    for(int i=0;i<[self.qualifiers count];i++){
        [self changeColor:[self.qualifiers objectAtIndex:i]:self.defaultLetterColor];
    }

}
@end
