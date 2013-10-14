//
//  SettingsView.h
//  Clock
//
//  Created by dancho on 9/26/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@protocol MyViewControllerDelegate <NSObject>

@optional

- (void)myViewControllerFinishedProcessing:(ViewController *)controller;

@end
@interface SettingsView : UIViewController

@property (strong, nonatomic) IBOutlet UISlider *redSlide;
@property (strong, nonatomic) IBOutlet UISlider *greenSlide;
@property (strong, nonatomic) IBOutlet UISlider *blueSlide;
@property (strong, nonatomic) IBOutlet UIImageView *colorBox;
@property UIColor* lightColor;
@property UIColor* defaultLetterColor;
@property (assign) id <MyViewControllerDelegate> delegate;

@end
