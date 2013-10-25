//
//  SettingsView.m
//  Clock
//
//  Created by dancho on 9/26/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "SettingsView.h"
#import "ViewController.h"
#import "ColorPicker.h"

@interface SettingsView ()

@end

@implementation SettingsView

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
    [self setColorBoxes];
    [self loadDefaultsColors];
    _colorPicker.paletteImage = [UIImage imageNamed:@"palette3"];
    _letterColorBox.backgroundColor = _backGroundColor;
    _sampleLbl.textColor = _lightColor;
    _colorSwitch.offImage = [UIImage imageNamed:@"switchOff.png"];
    _colorSwitch.onImage = [UIImage imageNamed:@"switchOn.png"];
    [_colorPicker addTarget:self action:@selector(setColor) forControlEvents:UIControlEventValueChanged];
    NSLog(@"Light color: %@",_lightColor);
    NSLog(@"LABEL color: %@",_sampleLbl.textColor);
    [self loadDefaultsColors];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of adsdsdsny resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self setDefaultsColors];
     [self.delegate myViewControllerFinishedProcessing:self];
}


-(void)setColor
{
    if(_colorSwitch.on)
    {
        _lightColor = _colorPicker.oldColor;
        [self setColorBoxes];
    }
    else
    {
        _backGroundColor = _colorPicker.oldColor;
        [self setColorBoxes];
    }
}

-(void)setColorBoxes
{
    _letterColorBox.backgroundColor = _backGroundColor;
    _sampleLbl.textColor = _lightColor;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadDefaultsColors];
    [self setColor];
    [self setColorBoxes];
}

-(void)setDefaultsColors
{
    NSData *lightColor = [NSKeyedArchiver archivedDataWithRootObject:_lightColor];
    NSData *backGroundColor = [NSKeyedArchiver archivedDataWithRootObject:_backGroundColor];
    [_colors setObject:lightColor forKey:@"lightColor"];
    [_colors setObject:backGroundColor forKey:@"backGroundColor"];
    [_colors synchronize];
    NSLog(@"Data saved");
}
-(void)loadDefaultsColors
{
    NSData *lightColorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"lightColor"];
    _lightColor= [NSKeyedUnarchiver unarchiveObjectWithData:lightColorData];
    NSData *backGroundColorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundColor"];
    _backGroundColor= [NSKeyedUnarchiver unarchiveObjectWithData:backGroundColorData];
}

@end
