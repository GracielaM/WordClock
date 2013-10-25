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
    NSLog(@"LIGHT color: %@",_lightColor);
    NSLog(@"BACK color: %@",_backGroundColor);
    NSLog(@"Saving data...");
    const CGFloat  *componentsLight = CGColorGetComponents(_lightColor.CGColor);
    const CGFloat  *componentsBack = CGColorGetComponents(_backGroundColor.CGColor);
    NSUserDefaults *defaultsColors = [NSUserDefaults standardUserDefaults];
    [defaultsColors setFloat:componentsLight[0]  forKey:@"lcr"];
    [defaultsColors setFloat:componentsLight[1]  forKey:@"lcg"];
    [defaultsColors setFloat:componentsLight[2]  forKey:@"lcb"];
    [defaultsColors setFloat:componentsLight[3]  forKey:@"lca"];
    [defaultsColors setFloat:componentsBack[0]  forKey:@"bcr"];
    [defaultsColors setFloat:componentsBack[1]  forKey:@"bcg"];
    [defaultsColors setFloat:componentsBack[2]  forKey:@"bcb"];
    [defaultsColors setFloat:componentsBack[3]  forKey:@"bca"];
    [defaultsColors synchronize];
    
}

-(void)loadDefaultsColors
{
    NSLog(@"Loading data...");
    NSUserDefaults *defaultsColors = [NSUserDefaults standardUserDefaults];
    _lightColor = [UIColor colorWithRed:[defaultsColors floatForKey:@"cr"] green:[defaultsColors floatForKey:@"cg"] blue:[defaultsColors floatForKey:@"cb"] alpha:[defaultsColors floatForKey:@"ca"]];
    NSLog(@"Loaded LIGHT color: %@",_lightColor);

    _backGroundColor = [UIColor colorWithRed:[defaultsColors floatForKey:@"bcr"] green:[defaultsColors floatForKey:@"bcg"] blue:[defaultsColors floatForKey:@"bcb"] alpha:[defaultsColors floatForKey:@"bca"]];
     NSLog(@"Loaded BACK color: %@",_backGroundColor);

}

@end
