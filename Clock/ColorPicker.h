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

- (UIColor*)getRGBAsFromImageAtPoint: (CGPoint*)point;
@end 
