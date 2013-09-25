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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self liteTheWords];
    self.numbers = [[NSArray alloc]initWithObjects:@" ", one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve, nil];
    self.qualifiers = [[NSArray alloc]initWithObjects:half,ten,quarter,twenty,five,minutes, to,past, oclock, nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)liteTheWords{
    int h = [self currentHour];
    
    self.qualifiers = [[NSArray alloc]initWithObjects:@"half",@"ten",@"quarter",@"twenty", @"five", @"minutes", @"to",@"past", @"o'clock", nil];
    
    if ( [self currentMinutes] >= 55) {
        // minutes = @"five to";
        [self changeColor:fiveQual:[UIColor whiteColor]];
        [self changeColor:minutes:[UIColor whiteColor]];
        [self changeColor:to:[UIColor whiteColor]];
        h++;
    }else if( [self currentMinutes] >= 50) {
        [self changeColor:tenQual:[UIColor whiteColor]];
        [self changeColor:minutes:[UIColor whiteColor]];
        [self changeColor:to:[UIColor whiteColor]];
        // minutes = @"ten to";
        h++;
    }else if( [self currentMinutes] >= 45) {
        [self changeColor:quarter:[UIColor whiteColor]];
        [self changeColor:to:[UIColor whiteColor]];
        // minutes = @"quarter to";
        h++;
    }else if( [self currentMinutes] >= 40){
        [self changeColor:twenty:[UIColor whiteColor]];
        [self changeColor:minutes:[UIColor whiteColor]];
        [self changeColor:to:[UIColor whiteColor]];
        // minutes = @"twenty to";
        h++;
    }else if( [self currentMinutes] >= 30) {
        [self changeColor:half:[UIColor whiteColor]];
        [self changeColor:past:[UIColor whiteColor]];
        
    }else if ( [self currentMinutes] >= 20) {
        [self changeColor:twenty:[UIColor whiteColor]];
        [self changeColor:minutes:[UIColor whiteColor]];
        [self changeColor:past:[UIColor whiteColor]];
        // minutes = @"twenty past";
    }else if( [self currentMinutes] >= 15) {
        [self changeColor:quarter:[UIColor whiteColor]];
        [self changeColor:past:[UIColor whiteColor]];
        // minutes = @"quarter past";
    }else if ( [self currentMinutes] >= 10) {
        [self changeColor:tenQual:[UIColor whiteColor]];
        [self changeColor:minutes:[UIColor whiteColor]];
        [self changeColor:past:[UIColor whiteColor]];
        // minutes = @"ten past";
    }else if( [self currentMinutes] >= 5) {
        [self changeColor:fiveQual:[UIColor whiteColor]];
        [self changeColor:minutes:[UIColor whiteColor]];
        [self changeColor:past:[UIColor whiteColor]];
        // minutes = @"five past";
    }else if( [self currentMinutes] >= 0){
        [self changeColor:oclock:[UIColor whiteColor]];
        // minutes = @"o'clock";
    }
    if(h == [self currentHour]){
        
        
        NSInteger test = [self currentHour];
        [self changeColor:numbers[test]:[UIColor whiteColor]];
    } else {
        [self changeColor:numbers[h]:[UIColor whiteColor]];
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
    // In practice, these calls can be combined
   /* NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSHourCalendarUnit fromDate:now];
    NSLog(@"%d", [components minute]);
    return [components minute];
    */
    NSDate *now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSHourCalendarUnit  | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now];
    NSInteger minute = [dateComponents minute];
    return minute;
}
/*
 h=3
 m=45
 if m >= 40
 h++ 
 m == 45
 
 m == 15
 m==30
 m==0
 m==10
 m==5
 m==40 // 20 to
 = numbers[h]
 */

@end
