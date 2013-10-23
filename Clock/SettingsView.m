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
    _colorPicker = [[ColorPicker alloc] initWithPaletteImage:_colorPalette.image];
    _letterColorBox.backgroundColor = _lightColor;
    _colorSwitch.offImage = [UIImage imageNamed:@"switchOff.png"];
    _colorSwitch.onImage = [UIImage imageNamed:@"switchOn.png"];

    // Do any additional setup after loading the view from its nib.
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

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    [self setColor:&location];
}

-(void)setColor: (CGPoint*)point
{
    if(_colorSwitch.on)
    {
        _lightColor = [_colorPicker getColorAtPoint:point inView:_colorPalette];
        [self setColorBoxes];
    }
    else
    {
        _defaultLetterColor = [_colorPicker getColorAtPoint:point inView:_colorPalette];
        [self setColorBoxes];
    }
}

-(void)setColorBoxes
{
    _letterColorBox.backgroundColor = _defaultLetterColor;
    _sampleLbl.textColor = _lightColor;
}

@end
