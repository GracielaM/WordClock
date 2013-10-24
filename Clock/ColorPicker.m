//
//  ColorPicker.m
//  ColorPicker
//
//  Created by dancho on 10/21/13.
//  Copyright (c) 2013 Andrey. All rights reserved.
//

#import "ColorPicker.h"

@implementation ColorPicker


- (void)setup
{
    self.pickerImage = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.pickerImage];
}

- (id)initWithCoder:(NSCoder *)aDecoder // invoked by IB on xib loading
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
        // Initialization code
        [self setup];
    }
    return self;
}

//- (id)initWithPaletteImage:(UIImage *)paletteImage
//{
//    self = [super init];
//    if (self) {
//        self.paletteImg = paletteImage;
//    }
//    return self;
//}

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
        NSLog(@"TOUCH INSIDE");
        // now get color
        CGPoint p = [touch locationInView:self];
        _oldColor = [self getRGBAsFromImageAtPoint:&p];
        NSLog(@"color: %@", _oldColor);
    }
    else NSLog(@"not Inside");
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.touchInside) {
        NSLog(@"Drag INSIDE");
        // now get color
        CGPoint p = [touch locationInView:self];
        _oldColor = [self getRGBAsFromImageAtPoint:&p];
        NSLog(@"color: %@", _oldColor);
    }
    else NSLog(@"not Inside");
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return (YES);
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
}

- (UIColor*)getRGBAsFromImageAtPoint: (CGPoint*)point //count:(int)count
{
    CGImageRef imageRef = [_paletteImage CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    int byteIndex = (bytesPerRow * point->y) + point->x * bytesPerPixel;
        CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
        byteIndex += 4;
        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return acolor;
}

-(BOOL)isInView: (CGPoint*)point inView:(UIImageView*)view
{
    if(CGRectContainsPoint(view.frame, *point)){
//        NSLog(view.description);
        return YES;
    }
       else{
           NSLog(@"Just tapped");
           return NO;
       }
}

@end
