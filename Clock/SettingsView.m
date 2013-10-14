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
@synthesize colorBox;


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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] == colorBox)
    {       
        self.lightColor = [UIColor redColor];
    }
    
}
-(void)viewDidDisappear:(BOOL)animated
{
     [self.delegate myViewControllerFinishedProcessing:self];
}

-(void)sliderValueChanged:(UISlider*)slider
{
    NSLog(@"slude");
    float r=[[NSString stringWithFormat:@"%.0f",_redSlide.value] floatValue];
    float g=[[NSString stringWithFormat:@"%.0f",_greenSlide.value]floatValue];
    float b=[[NSString stringWithFormat:@"%.0f",_blueSlide.value]floatValue];
    
    UIColor *colorToSet=[UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1];
    self.colorBox.backgroundColor = colorToSet;
}

	

@end
