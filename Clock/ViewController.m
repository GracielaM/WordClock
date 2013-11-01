//
//  ViewController.m
//  Clock
//
//  Created by dancho on 9/24/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "ViewController.h"
#import "SettingsViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad
{   
    [super viewDidLoad];
    self.numbers = [[NSArray alloc]initWithObjects:_one,_two,_three,_four,_five,_six,_seven,_eight,_nine,_ten,_eleven,_twelve, nil];
    self.qualifiers = [[NSArray alloc]initWithObjects:_half, _quarterM, _twentyM, _to, _past, _tenM, _fiveM,_minutes,_oclock,_its, nil];
    self.numbersBg = [[NSArray alloc] initWithObjects:@"един",@"два",@"три",@"четири", @"пет", @"шест",@"седем",@"осем",@"девет",@"десет",@"единадесет",@"дванадесет", nil];
    self.qualifiersBg = [[NSArray alloc]initWithObjects:@"половина",@"петнадесет",@"двадесет",@"без",@"и",@"десет",@"пет",@"минути",@"часа",@"часът е ", nil];
    [self formatLbls];
    [self setLetterShadow];
   
    UIBarButtonItem *adminButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(goToSettings)];
    self.navigationItem.rightBarButtonItem = adminButton;
    
    [self lightTheWords];

    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(lightTheWords) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];
    [self changeLabelLocationForBg];
    [self changeToBgText];

}

-(void)formatLbls{
    [self loadDefaultsColors];
    self.its.textColor = self.lightColor;
    self.its.font = _one.font;
    [self setLetterColor];
    [self changeColor:_its :_lightColor];
    self.view.backgroundColor = _backGroundColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)lightTheWords{
    int hour = [self currentHour];
    [self setLetterColor];
    [self changeColor:_its :self.lightColor];
     
    if ( [self currentMinutes] >= 55) {
        // minutes = @"five minutes to";
        [self changeColor:_fiveM :self.lightColor];
        [self changeColor:_to:self.lightColor];
        [self changeColor:_minutes:self.lightColor];
        hour++;
    }else if( [self currentMinutes] >= 50) {
        [self changeColor:_tenM:self.lightColor];
        [self changeColor:_minutes:self.lightColor];
        [self changeColor:_to:self.lightColor];
        // minutes = @"ten minutes to";
        hour++;
    }else if( [self currentMinutes] >= 45) {
        [self changeColor:_quarterM:self.lightColor];
        [self changeColor:_to:self.lightColor];
        // minutes = @"quarter to";
        hour++;
    }else if( [self currentMinutes] >= 40){
        [self changeColor:_twentyM:self.lightColor];
        [self changeColor:_minutes:self.lightColor];
        [self changeColor:_to:self.lightColor];
        // minutes = @"twenty minutes to";
        hour++;
    }else if( [self currentMinutes] >= 30) {
        [self changeColor:_half:self.lightColor];
        [self changeColor:_past:self.lightColor];
        //half past
    }else if ( [self currentMinutes] >= 20) {
        [self changeColor:_twentyM:self.lightColor];
        [self changeColor:_minutes:self.lightColor];
        [self changeColor:_past:self.lightColor];
        // minutes = @"twenty past";
    }else if( [self currentMinutes] >= 15) {
        [self changeColor:_quarterM:self.lightColor];
        [self changeColor:_past:self.lightColor];
        // minutes = @"quarter past";
    }else if ( [self currentMinutes] >= 10) {
        [self changeColor:_tenM:self.lightColor];
        [self changeColor:_past:self.lightColor];
        [self changeColor:_minutes:self.lightColor];
        // minutes = @"ten past";
    }else if( [self currentMinutes] >= 5) {
        [self changeColor:_fiveM:self.lightColor];
        [self changeColor:_past:self.lightColor];
        [self changeColor:_minutes:self.lightColor];
            }else if( [self currentMinutes] >= 0){
        [self changeColor:_oclock:self.lightColor];
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
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSHourCalendarUnit fromDate:now];
    if([components hour]>12)
    return [components hour] - 12;
    if([components hour] ==0)
        return 12;
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

-(void)setLetterColor {
    for(int i=0;i<[self.numbers count];i++){
        [self changeColor:[self.numbers objectAtIndex:i]:[UIColor colorWithWhite:1 alpha:0.2]];
    }
    for(int i=0;i<[self.qualifiers count];i++){
        [self changeColor:[self.qualifiers objectAtIndex:i]:[UIColor colorWithWhite:1 alpha:0.2]];
    }
}

-(void)setLetterShadow {
    UILabel *tempLabel = [[UILabel alloc] init];
    for(tempLabel in self.numbers){
        tempLabel.shadowColor = [UIColor darkGrayColor];
        tempLabel.shadowOffset = CGSizeMake(1.0, 1.0);
    }
    for(tempLabel in self.qualifiers){
        tempLabel.shadowColor = [UIColor darkGrayColor];
        tempLabel.shadowOffset = CGSizeMake(1.0, 1.0);
    }
}


-(void)goToSettings
{
    SettingsViewController *settingsView =[[SettingsViewController alloc]init];
    settingsView.lightColor = _lightColor;
    settingsView.backGroundColor = _backGroundColor;
    [self.navigationController pushViewController:settingsView animated:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(lightTheWords) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];
    [self formatLbls];
    
}

-(void)setDefaultsColors
{
    NSUserDefaults *defaultsColors = [NSUserDefaults standardUserDefaults];
    [defaultsColors setObject:[NSKeyedArchiver archivedDataWithRootObject:_lightColor] forKey:@"lightColor"];
    [defaultsColors setObject:[NSKeyedArchiver archivedDataWithRootObject:_backGroundColor] forKey:@"backGroundColor"];
    [defaultsColors synchronize];
}

-(void)loadDefaultsColors
{
    NSUserDefaults *defaultsColors = [NSUserDefaults standardUserDefaults];
    _lightColor = [NSKeyedUnarchiver unarchiveObjectWithData:[defaultsColors objectForKey:@"lightColor"]];
    _backGroundColor = [NSKeyedUnarchiver unarchiveObjectWithData:[defaultsColors objectForKey:@"backGroundColor"]];
}

-(void)locationSwap:(UILabel *)firstLabel : (UILabel*) secondLabel
{
    CGPoint firstLabelCenter = firstLabel.center;
    firstLabel.center = secondLabel.center;
    secondLabel.center = firstLabelCenter;
}
-(void)changeLabelLocationForBg
{
    [self locationSwap:_one :_fiveM];
    [self locationSwap:_tenM :_two];
    [self locationSwap:_quarterM :_three];
    [self locationSwap:_twentyM :_four];
    [self locationSwap:_minutes :_five];
    [self locationSwap:_six :_half];
    [self locationSwap:_past :_seven];
    [self locationSwap:_eight :_to];
    [self locationSwap:_nine :_fiveM];
    [self locationSwap:_eleven :_quarterM];
    [self locationSwap:_minutes :_past];
    [self locationSwap:_to :_half];
    [self locationSwap:_minutes :_fiveM];
    [self locationSwap:_ten :_tenM];
    [self locationSwap:_twentyM :_twelve];
    [self locationSwap:_twentyM :_minutes];
}

-(void)changeToBgText
{
    UILabel* tempLabel = [[UILabel alloc]init];
    for(int i=0;i<_numbers.count;i++){
        tempLabel = [_numbers objectAtIndex:i];
        tempLabel.text = [_numbersBg objectAtIndex:i];
    }
    for(int i=0;i<_qualifiers.count;i++){
        tempLabel = [_qualifiers objectAtIndex:i];
        tempLabel.text = [_qualifiersBg objectAtIndex:i];
    }
}

@end
