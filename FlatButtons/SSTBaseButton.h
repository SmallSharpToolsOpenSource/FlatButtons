//
//  SSTBaseButton.h
//  Blanket
//
//  Created by Brennan Stehling on 6/23/13.
//  Copyright (c) 2013 Blanket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSTBaseButton : UIButton

- (UIColor *)lighterColorForColor:(UIColor *)c;

- (UIColor *)darkerColorForColor:(UIColor *)c;

@end
