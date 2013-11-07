//
//  SettingsView.m
//
//
//  Created by dancho on 9/26/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"
#import "ColorPicker.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self formatControls];
    [_colorPicker addTarget:self action:@selector(setColor) forControlEvents:UIControlEventValueChanged];
    [_languageSwitch addTarget:self action:@selector(languageSwitchChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of adsdsdsny resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self setUserDefaults];
}

-(void)formatControls
{
    _sampleLbl.backgroundColor = _backGroundColor;
    _sampleLbl.textColor = _lightColor;
    _sampleLbl.textAlignment = NSTextAlignmentCenter;
    _sampleLbl.text = @"O'clock";
        self.title = @"Settings";
    _colorSwitch.offImage = [UIImage imageNamed:@"switchOff.png"];
    _colorSwitch.onImage = [UIImage imageNamed:@"switchOn.png"];
    _languageSwitch.offImage = [UIImage imageNamed:@"switchOff.png"];
    _languageSwitch.onImage = [UIImage imageNamed:@"switchOn.png"];
     _colorPicker.paletteImage = [UIImage imageNamed:@"palette.png"];
}

-(void)setColor
{
    if(_colorSwitch.on)
    {
        _lightColor = _colorPicker.oldColor;
        _sampleLbl.textColor = _lightColor;
    }
    else
    {
        _backGroundColor = _colorPicker.oldColor;
        _sampleLbl.backgroundColor = _backGroundColor;
    }
    [self setUserDefaults];
}

-(void) setClockLanguage
{
    if(_languageSwitch.on)
        _language = @"english";
    else _language = @"bulgarian";
    [self setUserDefaults];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadUserDefaults];
    _sampleLbl.textColor = _lightColor;
    _sampleLbl.backgroundColor = _backGroundColor;
    if([_language isEqualToString:@"english"])
        _languageSwitch.on = YES;
    else
        _languageSwitch.on = NO;
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

- (IBAction)languageSwitchChanged:(id)sender {
    [self setClockLanguage];
    [self formatControls];
}

@end
