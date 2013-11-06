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
    self.labels = [[NSArray alloc]initWithObjects:_its, _fiveM, _tenM, _quarterM, _twentyM, _minutes,_half,_past,_to,_one,_two,_three,_four,_five,_six,_seven,_eight,_nine,_ten, _eleven,_twelve, _oclock,nil];
    self.labelsBg = [[NSArray alloc]initWithObjects:_its,_one,_two,_three,_four,_five,_six,_seven,_eight,_nine,_ten,_eleven,_twelve,_past,_to,_fiveM,_tenM,_quarterM,_twentyM,_minutes,_half,_oclock,nil];
    [self formatLbls];
    [self setLetterShadow];
    [self setClockLanguage];
    UIBarButtonItem *adminButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(goToSettings)];
    self.navigationItem.rightBarButtonItem = adminButton;
    [self lightTheWords];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(lightTheWords) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];

}

-(void)formatLbls{
    [self loadUserDefaults];
    self.its.textColor = self.lightColor;
    self.its.font = _one.font;
    [self setLetterColor];
    [self changeColor:_its :_lightColor];
    self.view.backgroundColor = _backGroundColor;
    if([_language isEqualToString:@"english"])
        self.title = @"Word clock";
    else
        self.title = @"Часовник с думи";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)lightTheWords
{
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
        [self changeColor:_labels[hour + 8]:self.lightColor];
    } else {
        [self changeColor:_labels[hour + 8]:self.lightColor];
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

-(void)setLetterColor
{
    for(int i=0;i<[self.labels count];i++){
        [self changeColor:[self.labels objectAtIndex:i]:[UIColor colorWithWhite:1 alpha:0.2]];
    }
}

-(void)setLetterShadow
{
    UILabel *tempLabel = [[UILabel alloc] init];
    for(tempLabel in self.labels){
        tempLabel.shadowColor = [UIColor darkGrayColor];
        tempLabel.shadowOffset = CGSizeMake(1.0, 1.0);
    }
}


-(void)goToSettings
{
    SettingsViewController *settingsView =[[SettingsViewController alloc]init];
    settingsView.lightColor = _lightColor;
    settingsView.backGroundColor = _backGroundColor;
    [self.navigationController pushViewController:settingsView animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(lightTheWords) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];
    [self formatLbls];
    [self setUserDefaults];
    [self setClockLanguage];
    
}

-(void)setUserDefaults
{
    NSUserDefaults *defaultsColors = [NSUserDefaults standardUserDefaults];
    [defaultsColors setObject:[NSKeyedArchiver archivedDataWithRootObject:_lightColor] forKey:@"lightColor"];
    [defaultsColors setObject:[NSKeyedArchiver archivedDataWithRootObject:_backGroundColor] forKey:@"backGroundColor"];
    [defaultsColors setObject:_language forKey:@"language"];
    [defaultsColors synchronize];
}

-(void)loadUserDefaults
{
    NSUserDefaults *defaultsColors = [NSUserDefaults standardUserDefaults];
    _lightColor = [NSKeyedUnarchiver unarchiveObjectWithData:[defaultsColors objectForKey:@"lightColor"]];
    _backGroundColor = [NSKeyedUnarchiver unarchiveObjectWithData:[defaultsColors objectForKey:@"backGroundColor"]];
    _language = [defaultsColors objectForKey:@"language"];
}


-(void)calculateLabelsPositions:(NSArray *)label{
    
    CGPoint labelDimensions;
    labelDimensions.x = 20;
    labelDimensions.y = 60;
    CGPoint labelDimensionsSteps;
    labelDimensionsSteps.x = 100;
    labelDimensionsSteps.y = 40;
    int counter = 1;
    for(int i=0; i<label.count; i++){
        [self putLbl:labelDimensions:[label objectAtIndex:i]];
        labelDimensions.x = labelDimensions.x + labelDimensionsSteps.x;
        if(counter == 3){
            labelDimensions.x=20;
            labelDimensions.y=labelDimensions.y + labelDimensionsSteps.y;
            counter = 0;
        }
        counter++;
    }
}

-(void)putLbl: (CGPoint) point : (UILabel*) label
{
    label.frame = CGRectMake(point.x, point.y, 90, 30);
}

-(void)setBgLabels
{
    NSArray* bgStrings = [[NSArray alloc]initWithObjects:@"часът е", @"един", @"два", @"три", @"четири" , @"пет", @"шест" , @"седем" , @"осем", @"девет", @"десет", @"единадесет", @"дванадесет", @"и", @"без", @"пет", @"десет", @"петнадесет", @"двадесет", @"минути", @"половина", @"часа",nil];
    UILabel* tempLabel = [[UILabel alloc]init];
    for(int i=0;i<_labelsBg.count;i++){
        tempLabel = [_labelsBg objectAtIndex:i];
        tempLabel.text = [bgStrings objectAtIndex:i];
   }
}

-(void)setEnLabels
{
    NSArray * enStrings = [[NSArray alloc]initWithObjects:@"its", @"five", @"ten", @"quarter", @"twenty", @"minutes",@"half",@"past",@"to",@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight",@"nine",@"ten", @"eleven",@"twelve", @"oclock",nil];
    UILabel* tempLabel = [[UILabel alloc]init];
    for(int i=0;i<_labels.count;i++){
        tempLabel = [_labels objectAtIndex:i];
        tempLabel.text = [enStrings objectAtIndex:i];
    }
}

-(void)switchToBg
{
    [self calculateLabelsPositions:_labelsBg];
    [self setBgLabels];
}

-(void)switchToEn
{
    [self calculateLabelsPositions:_labels];
    [self setEnLabels];
}

-(void)setClockLanguage
{
    if([_language isEqualToString:@"english"])
        [self switchToEn];
    if([_language isEqualToString:@"bulgarian"])
        [self switchToBg];
}

@end
