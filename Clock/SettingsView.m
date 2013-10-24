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
    //NSLog(@"Light color");
    //NSLog(_lightColor.description);
    //NSLog(@"label color:");
    NSLog(_sampleLbl.textColor.description);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of adsdsdsny resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
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
    [self setColor];
    [self setColorBoxes];
}
@end
