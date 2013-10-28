//
//  SettingsView.h
//  Clock
//
//  Created by dancho on 9/26/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@class ColorPicker;
@protocol MyViewControllerDelegate <NSObject>

@optional

- (void)myViewControllerFinishedProcessing:(ViewController*)controller;

@end
@interface SettingsView : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *colorPalette;
@property (strong, nonatomic) IBOutlet UILabel *sampleLbl;
@property (strong, nonatomic) IBOutlet UIImageView *letterColorBox;
@property (strong, nonatomic) IBOutlet UISwitch *colorSwitch;
@property UIColor* lightColor;
@property UIColor* backGroundColor;
@property NSUserDefaults *colors;
@property (assign) id <MyViewControllerDelegate> delegate;

@property IBOutlet ColorPicker* colorPicker;

-(void)setColor;
-(void)setColorBoxes;
-(void)loadDefaultsColors;
-(void)setDefaultsColors;

@end
