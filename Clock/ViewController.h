//
//  ViewController.h
//  Clock
//
//  Created by dancho on 9/24/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;
@protocol MyViewControllerDelegate;

@interface ViewController : UIViewController

@property(strong, nonatomic) NSArray *labels;

@property (weak, nonatomic) IBOutlet UILabel *its;
@property (weak, nonatomic) IBOutlet UILabel *fiveM;
@property (weak, nonatomic) IBOutlet UILabel *tenM;
@property (weak, nonatomic) IBOutlet UILabel *quarterM;
@property (weak, nonatomic) IBOutlet UILabel *twentyM;
@property (weak, nonatomic) IBOutlet UILabel *half;
@property (weak, nonatomic) IBOutlet UILabel *past;
@property (weak, nonatomic) IBOutlet UILabel *to;
@property (weak, nonatomic) IBOutlet UILabel *one;
@property (weak, nonatomic) IBOutlet UILabel *two;
@property (weak, nonatomic) IBOutlet UILabel *three;
@property (weak, nonatomic) IBOutlet UILabel *four;
@property (weak, nonatomic) IBOutlet UILabel *five;
@property (weak, nonatomic) IBOutlet UILabel *six;
@property (weak, nonatomic) IBOutlet UILabel *seven;
@property (weak, nonatomic) IBOutlet UILabel *eight;
@property (weak, nonatomic) IBOutlet UILabel *nine;
@property (weak, nonatomic) IBOutlet UILabel *ten;
@property (weak, nonatomic) IBOutlet UILabel *eleven;
@property (weak, nonatomic) IBOutlet UILabel *twelve;
@property (weak, nonatomic) IBOutlet UILabel *minutes;
@property (weak, nonatomic) IBOutlet UILabel *oclock;


@property(strong) UIColor* lightColor;
@property(strong) UIColor* backGroundColor;
-(void) goToSettings ;
-(void)setLetterColor;
-(NSInteger)currentHour;
-(NSInteger)currentMinutes;
-(void) lightTheWords;
-(void) changeColor: (UILabel *)lblName :(UIColor*)color;
-(void)setLetterShadow;
-(void)setDefaultsColors;
-(void)loadDefaultsColors;
-(void)locationSwap:(UILabel *)firstLabel : (UILabel*) secondLabel;
-(void)changeLabelLocationForBg;
-(void)changeToBgText;
-(void)changeLabelLocationForEn;

@end
