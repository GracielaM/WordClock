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
    [self test];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)test {
    int m = 15;
    int h = [self currentHour];
    //self.numbers = [[NSArray alloc]initWithObjects:@"",@"one", @"two", @"three",@"four", @"five", @"six", @"seven", @"eight", @"nine", @"ten", @"eleven", @"twelve", nil];
    self.numbers = [[NSArray alloc]initWithObjects:@" ", one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve, nil];
    self.qualifiers = [[NSArray alloc]initWithObjects:@"half",@"ten",@"quarter",@"twenty", @"five", @"minutes", @"to",@"past", @"o'clock", nil];
    
    if ( [self currentMinutes] == 55) {
       // minutes = @"five to";
        [self changeColor:fiveQual];
        [self changeColor:to];
        h++;
    }else if( [self currentMinutes] >= 50) {
        [self changeColor:tenQual];
        [self changeColor:to];
       // minutes = @"ten to";
        h++;
    }else if( [self currentMinutes] == 45) {
        [self changeColor:quarter];
        [self changeColor:to];
       // minutes = @"quarter to";
        h++;
    }else if( [self currentMinutes] >= 40){
        [self changeColor:twenty];
        [self changeColor:to];
       // minutes = @"twenty to";
        h++;
    }else if( [self currentMinutes] >= 30) {
        [self changeColor:half];
        [self changeColor:past];
        //minutes = @"half past";
        h++;
    }else if ( [self currentMinutes] >= 20) {
        [self changeColor:twenty];
        [self changeColor:past];
       // minutes = @"twenty past";
    }else if( [self currentMinutes] == 15) {
        [self changeColor:quarter];
        [self changeColor:past];
       // minutes = @"quarter past";
    }else if ( [self currentMinutes] >= 10) {
        [self changeColor:tenQual];
        [self changeColor:past];
       // minutes = @"ten past";
    }else if( [self currentMinutes] >= 5) {
        [self changeColor:fiveQual];
        [self changeColor:past];
       // minutes = @"five past";
    }else if( [self currentMinutes] >= 0){
        [self changeColor:oclock];
       // minutes = @"o'clock";
    }
    if(h == [self currentHour]){
        
    
    NSInteger test = [self currentHour];
    [self changeColor:numbers[test]];
    } else {
        [self changeColor:numbers[h]];
    }
    //hour = numbers[h];
   
}

-(void)changeColor:(UILabel *)lblName{
    lblName.textColor = [UIColor redColor];
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
