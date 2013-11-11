//
//  TapFlash.m
//  Clock
//
//  Created by Interns on 11/11/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "TapFlash.h"

@implementation TapFlash

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, 40, 40);
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)changeAlpha
{
    [UIView animateWithDuration:1.0 animations:^(void) {
        _imageView.alpha = 0;
        _imageView.alpha = 1;
        _imageView.alpha = 0;
    }];
}

- (void)setup
{
    _flashImage = [UIImage imageNamed:@"flash.png"];
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.image = _flashImage;
    [self addSubview:self.imageView];
}

-(void)flash:(CGPoint)location
{
    _imageView.center = location;
    [self changeAlpha];
    _imageView.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
