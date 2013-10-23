//
//  ColorPicker.m
//  ColorPicker
//
//  Created by dancho on 10/21/13.
//  Copyright (c) 2013 Andrey. All rights reserved.
//

#import "ColorPicker.h"

@implementation ColorPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithPaletteImage:(UIImage *)paletteImage
{
    self = [super init];
    if (self) {
        self.paletteImg = paletteImage;
    }
    return self;
}

- (UIColor*)getRGBAsFromImageAtPoint: (CGPoint*)point //count:(int)count
{
    CGImageRef imageRef = [_paletteImg CGImage];
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
    if(point->x < view.frame.origin.x) return NO;
    if(point->x > (view.frame.size.width+view.frame.origin.x)) return NO;
    if(point->y < view.frame.origin.y) return NO;
    if(point->y > (view.frame.size.height+view.frame.origin.y)) return NO;
    NSLog(@"IN   DA");
    return YES;
}

-(UIColor*)getColorAtPoint: (CGPoint*)point inView:(UIImageView*)view
{
    //if([self isInView:point inView:view]){
    if(view.image == self.paletteImg) {
        
        if([self isInView:point inView:view]) {
        
        _oldColor = [self getRGBAsFromImageAtPoint:point];
    }
    }
    return _oldColor;
    
}

@end
