//
//  ColorPicker.m
//  ColorPicker
//
//  Created by dancho on 10/21/13.
//  Copyright (c) 2013 Andrey. All rights reserved.
//

#import "ColorPicker.h"
#import <QuartzCore/QuartzCore.h> 


@implementation ColorPicker


- (void)setup
{
    self.pickerImage = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.pickerImage];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setPaletteImage:(UIImage *)paletteImage
{
    _paletteImage = paletteImage;
    self.pickerImage.image = _paletteImage;
    [self setNeedsDisplay];
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.touchInside) {
        CGPoint p = [touch locationInView:self];
        _oldColor = [self getRGBAsFromImageAtPoint:&p];
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.touchInside) {
        CGPoint p = [touch locationInView:self];
        _oldColor = [self getRGBAsFromImageAtPoint:&p];
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return (YES);
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
   
}

- (UIColor*)getRGBAsFromImageAtPoint: (CGPoint*)point

{

    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace,(CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point->x, -point->y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}

-(BOOL)isInView: (CGPoint*)point inView:(UIImageView*)view
{
    if(CGRectContainsPoint(view.frame, *point)){
        return YES;
    }
       else{
           return NO;
       }
}

@end
