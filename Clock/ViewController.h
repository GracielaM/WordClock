//
//  ViewController.h
//  Clock
//
//  Created by dancho on 9/24/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(strong, nonatomic) NSArray *numbers;
@property(strong, nonatomic) NSArray *qualifiers;
@property (strong, nonatomic) IBOutlet UILabel *half;
@property (strong, nonatomic) IBOutlet UILabel *tenQual;
@property (strong, nonatomic) IBOutlet UILabel *quarter;
@property (strong, nonatomic) IBOutlet UILabel *twenty;
@property (strong, nonatomic) IBOutlet UILabel *fiveQual;
@property (strong, nonatomic) IBOutlet UILabel *minutes;
@property (strong, nonatomic) IBOutlet UILabel *to;
@property (strong, nonatomic) IBOutlet UILabel *past;
@property (strong, nonatomic) IBOutlet UILabel *one;
@property (strong, nonatomic) IBOutlet UILabel *three;
@property (strong, nonatomic) IBOutlet UILabel *two;
@property (strong, nonatomic) IBOutlet UILabel *four;
@property (strong, nonatomic) IBOutlet UILabel *five;
@property (strong, nonatomic) IBOutlet UILabel *six;
@property (strong, nonatomic) IBOutlet UILabel *seven;
@property (strong, nonatomic) IBOutlet UILabel *eight;
@property (strong, nonatomic) IBOutlet UILabel *nine;
@property (strong, nonatomic) IBOutlet UILabel *ten;
@property (strong, nonatomic) IBOutlet UILabel *eleven;
@property (strong, nonatomic) IBOutlet UILabel *twelve;
@property (strong, nonatomic) IBOutlet UILabel *itsLbl;
@property (strong, nonatomic) IBOutlet UILabel *oclock;

@property(strong) UIColor* lightColor;
@property(strong) UIColor* defaultLetterColor;
-(void) goToSettings ;
-(void)setDefaultLetterColor;
-(NSInteger)currentHour;
-(NSInteger)currentMinutes;
-(void) lightTheWords ;
-(void) changeColor: (UILabel *)lblName :(UIColor*)color;
@end
