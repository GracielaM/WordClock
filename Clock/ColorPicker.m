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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (UIColor*)getRGBAsFromImageAtPoint: (CGPoint*)point //count:(int)count
{
   // NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    
    // First get the image into your data buffer
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
    
   // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * point->y) + point->x * bytesPerPixel;
    //for (int ii = 0 ; ii < count ; ++ii)
    //{
        CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
        byteIndex += 4;
        
        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
      //  [result addObject:acolor];
    //}
    
    //free(rawData);
    
    return acolor;
}

-(BOOL)isInView: (CGPoint*)point inView:(UIImageView*)view
{
    if(point->x < view.frame.origin.x) return NO;
    if(point->x > (view.frame.size.width+view.frame.origin.x)) return NO;
    if(point->y < view.frame.origin.y) return NO;
    if(point->y > (view.frame.size.height+view.frame.origin.y)) return NO;
    return YES;
}

-(UIColor*)getColorAtPoint: (CGPoint*)point inView:(UIImageView*)view
{
    if([self isInView:point inView:view]){
        _oldColor = [self getRGBAsFromImageAtPoint:point];
    }
    return _oldColor;
}
@end
