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
     [self setDefaultsColors];
    [self loadDefaultsColors];
    [self setColorBoxes];
   
    _colorPicker.paletteImage = [UIImage imageNamed:@"palette3"];
    _letterColorBox.backgroundColor = _backGroundColor;
    _sampleLbl.textColor = _lightColor;
    _colorSwitch.offImage = [UIImage imageNamed:@"switchOff.png"];
    _colorSwitch.onImage = [UIImage imageNamed:@"switchOn.png"];
    [_colorPicker addTarget:self action:@selector(setColor) forControlEvents:UIControlEventValueChanged];
    NSLog(@"Light color: %@",_lightColor);
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
    NSLog(@"Saving data...");
    const CGFloat  *componentsLight = CGColorGetComponents(_lightColor.CGColor);
    const CGFloat  *componentsBack = CGColorGetComponents(_backGroundColor.CGColor);
    [_colors setFloat:componentsLight[0]  forKey:@"lcr"];
    [_colors setFloat:componentsLight[1]  forKey:@"lcg"];
    [_colors setFloat:componentsLight[2]  forKey:@"lcb"];
    [_colors setFloat:componentsLight[3]  forKey:@"lca"];
    [_colors setFloat:componentsBack[0]  forKey:@"bcr"];
    [_colors setFloat:componentsBack[1]  forKey:@"bcg"];
    [_colors setFloat:componentsBack[2]  forKey:@"bcb"];
    [_colors setFloat:componentsBack[3]  forKey:@"bca"];

    //[_colors synchronize];
    
}

-(void)loadDefaultsColors
{
    NSLog(@"Loading data...");
    _lightColor = [UIColor colorWithRed:[_colors floatForKey:@"cr"] green:[_colors floatForKey:@"cg"] blue:[_colors floatForKey:@"cb"] alpha:[_colors floatForKey:@"ca"]];
    _backGroundColor = [UIColor colorWithRed:[_colors floatForKey:@"bcr"] green:[_colors floatForKey:@"bcg"] blue:[_colors floatForKey:@"bcb"] alpha:[_colors floatForKey:@"bca"]];
}

@end
