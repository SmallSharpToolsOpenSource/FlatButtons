//
//  SSTInvertedButton.m
//  FlatButtons
//
//  Created by Brennan Stehling on 3/23/14.
//  Copyright (c) 2014 SmallSharpTools LLC. All rights reserved.
//

#import "SSTInvertedButton.h"

#import <QuartzCore/QuartzCore.h>

#pragma mark - Class Extension
#pragma mark -

@interface SSTInvertedButton ()

@property (strong, nonatomic) UIColor *originalTitleColor;
@property (strong, nonatomic) UIColor *originalBackgroundColor;

@property (strong, nonatomic) UIColor *myNormalTitleColor;
@property (strong, nonatomic) UIColor *mySelectedTitleColor;
@property (strong, nonatomic) UIColor *myHighlightedTitleColor;
@property (strong, nonatomic) UIColor *myDisabledTitleColor;

@property (strong, nonatomic) UIColor *myNormalBackgroundColor;
@property (strong, nonatomic) UIColor *mySelectedBackgroundColor;
@property (strong, nonatomic) UIColor *myHighlightedBackgroundColor;
@property (strong, nonatomic) UIColor *myDisabledBackgroundColor;

@end

@implementation SSTInvertedButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.originalTitleColor = self.titleLabel.textColor;
        self.originalBackgroundColor = self.backgroundColor;
        
        self.myNormalTitleColor = self.originalTitleColor;
        self.mySelectedTitleColor = self.originalBackgroundColor;
        self.myHighlightedTitleColor = self.originalBackgroundColor;
        self.myDisabledTitleColor = self.originalBackgroundColor;
        
        self.myNormalBackgroundColor = self.originalBackgroundColor;
        self.mySelectedBackgroundColor = self.originalTitleColor;
        self.myHighlightedBackgroundColor = self.originalTitleColor;
        self.myDisabledBackgroundColor = self.originalTitleColor;
        
        // don't allow the drawing to bleed over the bounds
        self.clipsToBounds = TRUE;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self setTitleColor:self.myNormalTitleColor forState:UIControlStateNormal];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:self.myNormalBackgroundColor] forState:UIControlStateNormal];
    
    [self setTitleColor:self.mySelectedTitleColor forState:UIControlStateSelected];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:self.mySelectedBackgroundColor] forState:UIControlStateSelected];

    [self setTitleColor:self.myHighlightedTitleColor forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:self.myHighlightedBackgroundColor] forState:UIControlStateHighlighted];
    
    [self setTitleColor:self.myHighlightedTitleColor forState:UIControlStateSelected | UIControlStateHighlighted];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:self.myHighlightedBackgroundColor] forState:UIControlStateSelected | UIControlStateHighlighted];

    [self setTitleColor:self.myDisabledTitleColor forState:UIControlStateDisabled];
    [self setBackgroundImage:[self drawnBackgroundImageWithSize:self.frame.size color:self.myDisabledBackgroundColor] forState:UIControlStateDisabled];
}

- (void)setBackgroundImageWithColor:(UIColor *)color forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
            self.myNormalBackgroundColor = color;
            break;
        case UIControlStateSelected:
            self.mySelectedBackgroundColor = color;
            break;
        case UIControlStateHighlighted:
            self.myHighlightedBackgroundColor = color;
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
