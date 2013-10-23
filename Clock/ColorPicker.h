//
//  ColorPicker.h
//  ColorPicker
//
//  Created by dancho on 10/21/13.
//  Copyright (c) 2013 Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorPicker : UIControl

@property UIImageView *pickerImage;
@property (strong, nonatomic) UIImage *paletteImage;
@property UIColor *oldColor;

- (id)initWithPaletteImage:(UIImage*)paletteImage;
- (UIColor*)getRGBAsFromImageAtPoint: (CGPoint*)point;
-(BOOL)isInView: (CGPoint*)point inView:(UIImageView*)view;
-(UIColor*)getColorAtPoint: (CGPoint*)point inView:(UIImageView*)view;
@end 
