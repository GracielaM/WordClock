//
//  ViewController.m
//  Clock
//
//  Created by dancho on 9/24/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "ViewController.h"
#import "SettingsView.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad
{   
    [super viewDidLoad];
    _backGroundColor = [UIColor blackColor];
    self.numbers = [[NSArray alloc]initWithObjects:_one,_two,_three,_four,_five,_six,_seven,_eight,_nine,_ten,_eleven,_twelve, nil];
    self.qualifiers = [[NSArray alloc]initWithObjects:_half, _ten, _quarter, _twenty, _five, _minutes, _to, _past, _oclock,_tenQual, _fiveQual, nil];
    [self formatLbls];
   
    UIBarButtonItem *adminButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(goToSettings)];
    self.navigationItem.rightBarButtonItem = adminButton;
    
    [self lightTheWords];

    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(lightTheWords) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];

}
-(void)formatLbls{
    _backGroundColor = [UIColor blackColor];
    self.lightColor = [UIColor whiteColor];
    self.backGroundColor = [UIColor colorWithWhite:1 alpha:0.2];
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
    int hour = [self currentHour];
    [self setDefaultLetterColor];
       
    if ( [self currentMinutes] >= 55) {
        // minutes = @"five to";
        [self changeColor:[_qualifiers objectAtIndex:10]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:5]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:6]:self.lightColor];
        hour++;
    }else if( [self currentMinutes] >= 50) {
        [self changeColor:[_qualifiers objectAtIndex:9]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:5]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:6]:self.lightColor];
        // minutes = @"ten to";
        hour++;
    }else if( [self currentMinutes] >= 45) {
        [self changeColor:[_qualifiers objectAtIndex:2]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:6]:self.lightColor];
        // minutes = @"quarter to";
        hour++;
    }else if( [self currentMinutes] >= 40){
        [self changeColor:[_qualifiers objectAtIndex:3]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:5]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:6]:self.lightColor];
        // minutes = @"twenty to";
        hour++;
    }else if( [self currentMinutes] >= 30) {
        [self changeColor:[_qualifiers objectAtIndex:0]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:7]:self.lightColor];
        
    }else if ( [self currentMinutes] >= 20) {
        [self changeColor:[_qualifiers objectAtIndex:3]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:5]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:7]:self.lightColor];
        // minutes = @"twenty past";
    }else if( [self currentMinutes] >= 15) {
        [self changeColor:[_qualifiers objectAtIndex:2]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:7]:self.lightColor];
        // minutes = @"quarter past";
    }else if ( [self currentMinutes] >= 10) {
        [self changeColor:[_qualifiers objectAtIndex:9]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:5]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:7]:self.lightColor];
        // minutes = @"ten past";
    }else if( [self currentMinutes] >= 5) {
        [self changeColor:[_qualifiers objectAtIndex:10]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:5]:self.lightColor];
        [self changeColor:[_qualifiers objectAtIndex:7]:self.lightColor];
            }else if( [self currentMinutes] >= 0){
        [self changeColor:[_qualifiers objectAtIndex:8]:self.lightColor];
        // minutes = @"o'clock";
    }
    if(hour == [self currentHour]){
       NSInteger hour = [self currentHour];
          [self changeColor:_numbers[hour-1]:self.lightColor];
    } else {
        [self changeColor:_numbers[hour-1]:self.lightColor];
    }
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
        [self changeColor:[self.numbers objectAtIndex:i]:[UIColor colorWithWhite:1 alpha:0.2]];
    }
    for(int i=0;i<[self.qualifiers count];i++){
        [self changeColor:[self.qualifiers objectAtIndex:i]:[UIColor colorWithWhite:1 alpha:0.2]];
    }
}

-(void)goToSettings
{
    SettingsView *settingsView =[[SettingsView alloc]initWithNibName:@"SettingsView" bundle:nil];
    settingsView.lightColor = _lightColor;
    settingsView.defaultLetterColor = _backGroundColor;
    settingsView.delegate = self;
    [self.navigationController pushViewController:settingsView animated:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(lightTheWords) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];
    [self changeColor:_itsLbl :_lightColor];
    self.view.backgroundColor = _backGroundColor;
}
-(void)myViewControllerFinishedProcessing:(SettingsView *)vc
{
    if(vc.lightColor != nil){
        self.lightColor = vc.lightColor;
    }
    if(vc.defaultLetterColor != nil){
        self.backGroundColor = vc.defaultLetterColor;
    }
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
