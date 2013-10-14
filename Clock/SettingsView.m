//
//  SettingsView.m
//  Clock
//
//  Created by dancho on 9/26/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "SettingsView.h"
#import "ViewController.h"

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
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)greenSlider:(id)sender {
    [self setColor];
}
- (IBAction)redSlider:(id)sender {
    [self setColor];
}
- (IBAction)blueSlider:(id)sender {
    [self setColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidDisappear:(BOOL)animated
{
     [self.delegate myViewControllerFinishedProcessing:self];
}

-(void)setColor
{
    UIColor *colorToSet=[UIColor colorWithRed:_redSlide.value green:_greenSlide.value blue:_blueSlide.value alpha:1];
    if(_colorSwitch.on)
    {
        _lightColor = colorToSet;
        [self setColorBoxes];
    }
    else
    {
        _defaultLetterColor = colorToSet;
        [self setColorBoxes];
    }
}
-(void)setColorBoxes
{
    _letterColorBox.backgroundColor = _lightColor;
    _backGroundBox.backgroundColor = _defaultLetterColor;
}

	

@end
