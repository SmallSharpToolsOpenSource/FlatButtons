//
//  BKFilledButton.h
//  Blanket
//
//  Created by Brennan Stehling on 6/16/13.
//  Copyright (c) 2013 Blanket. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SSTBaseButton.h"

@interface SSTFilledButton : SSTBaseButton

- (void)setBackgroundImageWithColor:(UIColor *)color forState:(UIControlState)state;

@end
