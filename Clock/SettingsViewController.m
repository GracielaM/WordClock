//
//  SettingsView.m
//  Clock
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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _colorPicker.paletteImage = [UIImage imageNamed:@"palette3"];
    _letterColorBox.backgroundColor = _backGroundColor;
    _sampleLbl.textColor = _lightColor;
    _colorSwitch.offImage = [UIImage imageNamed:@"switchOff.png"];
    _colorSwitch.onImage = [UIImage imageNamed:@"switchOn.png"];
    [_colorPicker addTarget:self action:@selector(setColor) forControlEvents:UIControlEventValueChanged];
    //NSLog(@"Back color: %@",_backGroundColor);
    NSLog(@"LABEL color: %@",_sampleLbl.textColor);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of adsdsdsny resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.delegate myViewControllerFinishedProcessing:self];
    [self setDefaultsColors];
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
        _letterColorBox.backgroundColor = _backGroundColor;
    }
    
    [self setDefaultsColors];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadDefaultsColors];
    _sampleLbl.textColor = _lightColor;
    _letterColorBox.backgroundColor = _backGroundColor;
}

-(void)setDefaultsColors
{
    NSLog(@"LIGHT color: %@",_lightColor);
    NSLog(@"BACK color: %@",_backGroundColor);
    NSLog(@"Saving data...");
    
    NSUserDefaults *defaultsColors = [NSUserDefaults standardUserDefaults];
    [defaultsColors setObject:[NSKeyedArchiver archivedDataWithRootObject:_lightColor] forKey:@"lightColor"];
    [defaultsColors setObject:[NSKeyedArchiver archivedDataWithRootObject:_backGroundColor] forKey:@"backGroundColor"];
    
    [defaultsColors synchronize];
}

-(void)loadDefaultsColors
{
    NSLog(@"Loading data...");
    NSUserDefaults *defaultsColors = [NSUserDefaults standardUserDefaults];
    _lightColor = [NSKeyedUnarchiver unarchiveObjectWithData:[defaultsColors objectForKey:@"lightColor"]];
    _backGroundColor = [NSKeyedUnarchiver unarchiveObjectWithData:[defaultsColors objectForKey:@"backGroundColor"]];
}

@end
