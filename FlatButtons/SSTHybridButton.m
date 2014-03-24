//
//  BKHybridButton.m
//  Blanket
//
//  Created by Brennan Stehling on 6/23/13.
//  Copyright (c) 2013 Blanket. All rights reserved.
//

#import "SSTHybridButton.h"

#import <QuartzCore/QuartzCore.h>

#pragma mark - Class Extension
#pragma mark -

@interface SSTHybridButton ()

@property (strong, nonatomic) UIColor *originalTitleColor;
@property (strong, nonatomic) UIColor *originalBackgroundColor;

@end

@implementation SSTHybridButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.originalTitleColor = self.titleLabel.textColor;
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
//    UIColor *darkerColor = [self darkerColorForColor:normalColor];
    
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size fillColor:nil outlineColor:normalColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size fillColor:self.originalTitleColor outlineColor:normalColor] forState:UIControlStateSelected];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size fillColor:self.originalTitleColor outlineColor:lighterColor] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size fillColor:self.originalTitleColor outlineColor:lighterColor] forState:UIControlStateSelected | UIControlStateHighlighted];
    
    [self setTitleColor:normalColor forState:UIControlStateNormal];
    [self setTitleColor:normalColor forState:UIControlStateSelected];
    [self setTitleColor:normalColor forState:UIControlStateHighlighted];
    
    //    [[self layer] setCornerRadius:3];
    //    [self setClipsToBounds: YES];
}

- (UIImage *)drawnBackgroundImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor outlineColor:(UIColor *)outlineColor {
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    if (fillColor) {
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, size.width, size.height)];
        [fillColor setFill];
        [rectanglePath fill];
    }
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(1, 1, size.width - 2, size.height - 2)];
    [outlineColor setStroke];
    rectanglePath.lineWidth = 2;
    [rectanglePath stroke];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(4.0f, 4.0f, 4.0f, 4.0f)];
}

@end
