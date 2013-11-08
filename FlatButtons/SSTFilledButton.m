//
//  BKFilledButton.m
//  Blanket
//
//  Created by Brennan Stehling on 6/16/13.
//  Copyright (c) 2013 Blanket. All rights reserved.
//

#import "SSTFilledButton.h"

#import <QuartzCore/QuartzCore.h>

#pragma mark - Class Extension
#pragma mark -

@interface SSTFilledButton ()

@property (strong, nonatomic) UIColor *originalBackgroundColor;
@property (strong, nonatomic) UIColor *myNormalColor;
@property (strong, nonatomic) UIColor *mySelectedColor;
@property (strong, nonatomic) UIColor *myHighlightedColor;
@property (strong, nonatomic) UIColor *myDisabledColor;

@end

@implementation SSTFilledButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.originalBackgroundColor = self.backgroundColor;
        self.backgroundColor = self.tintColor;
        
        UIColor *normalColor = self.originalBackgroundColor;
        UIColor *lighterColor = [self lighterColorForColor:normalColor];
        UIColor *darkerColor = [self darkerColorForColor:normalColor];
        
        self.myNormalColor = normalColor;
        self.mySelectedColor = lighterColor;
        self.myHighlightedColor = darkerColor;
        self.myDisabledColor = lighterColor;
        
        // don't allow the drawing to bleed over the bounds
        self.clipsToBounds = TRUE;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:self.myNormalColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:self.mySelectedColor] forState:UIControlStateSelected];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:self.myHighlightedColor] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:self.mySelectedColor] forState:UIControlStateSelected | UIControlStateHighlighted];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:self.myDisabledColor] forState:UIControlStateDisabled];
    
//    [[self layer] setCornerRadius:3];
//    [self setClipsToBounds: YES];
}

- (void)setBackgroundImageWithColor:(UIColor *)color forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
            self.myNormalColor = color;
            break;
        case UIControlStateSelected:
            self.mySelectedColor = color;
            break;
        case UIControlStateHighlighted:
            self.myHighlightedColor = color;
            break;
            
        default:
            break;
    }
}

- (UIImage *)drawnBackgroundImageWithSize:(CGSize)size color:(UIColor *)color {
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [color setFill];
    [rectanglePath fill];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(4.0f, 4.0f, 4.0f, 4.0f)];
}

@end
