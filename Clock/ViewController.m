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

@synthesize lightColor;

- (void)viewDidLoad
{   
    [super viewDidLoad];
    self.lightColor = [UIColor whiteColor];
    //[self lightTheWords];
    self.numbers = [[NSArray alloc]initWithObjects:@" ", one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve, nil];
    self.qualifiers = [[NSArray alloc]initWithObjects:half,ten,quarter,twenty,five,minutes, to,past, oclock, nil];
    
    self.numbers = [[NSArray alloc]initWithObjects:@" ", one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve, nil];
    CGRect frame, remain;
    CGRectDivide(self.view.bounds, &frame, &remain, 44, CGRectMaxYEdge);
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:frame];
    [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [self.view addSubview:toolbar];
        [self lightTheWords];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


-(void)lightTheWords{
    int h = [self currentHour];

    
    
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
        
        
        NSInteger test = [self currentHour];
        [self changeColor:numbers[test]:self.lightColor];
    } else {
        [self changeColor:numbers[h]:self.lightColor];
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
    
    return [components hour];
}

- (NSInteger)currentMinutes
{
        NSDate *now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSHourCalendarUnit  | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now];
    NSInteger minute = [dateComponents minute];
    return minute;
}

@end
