//
//  BKOutlinedButton.m
//  Blanket
//
//  Created by Brennan Stehling on 6/16/13.
//  Copyright (c) 2013 Blanket. All rights reserved.
//

#import "SSTOutlinedButton.h"

#import <QuartzCore/QuartzCore.h>

#pragma mark - Class Extension
#pragma mark -

@interface SSTOutlinedButton ()

@property (strong, nonatomic) UIColor *originalBackgroundColor;

@end

@implementation SSTOutlinedButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.originalBackgroundColor = self.backgroundColor;
        self.backgroundColor = [UIColor clearColor];
        
        // don't allow the drawing to bleed over the bounds
        self.clipsToBounds = TRUE;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIColor *normalColor = self.originalBackgroundColor;
    UIColor *lighterColor = [self lighterColorForColor:normalColor];
    UIColor *darkerColor = [self darkerColorForColor:normalColor];
    
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:normalColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:lighterColor] forState:UIControlStateSelected];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:darkerColor] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:lighterColor] forState:UIControlStateSelected | UIControlStateHighlighted];

    [self setTitleColor:normalColor forState:UIControlStateNormal];
    [self setTitleColor:lighterColor forState:UIControlStateSelected];
    [self setTitleColor:darkerColor forState:UIControlStateHighlighted];
    
//    [[self layer] setCornerRadius:3];
//    [self setClipsToBounds: YES];
}

- (UIImage *)drawnBackgroundImageWithSize:(CGSize)size color:(UIColor *)color {
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(1, 1, size.width - 2, size.height - 2)];
    [color setStroke];
    rectanglePath.lineWidth = 2;
    [rectanglePath stroke];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(4.0f, 4.0f, 4.0f, 4.0f)];
}

@end
