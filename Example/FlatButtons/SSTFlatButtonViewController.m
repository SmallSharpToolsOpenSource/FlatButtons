//
//  SSTFlatButtonViewController.m
//  FlatButtons
//
//  Created by Brennan Stehling on 11/7/13.
//  Copyright (c) 2013 SmallSharpTools LLC. All rights reserved.
//

#import "SSTFlatButtonViewController.h"

@interface SSTFlatButtonViewController ()

@property (weak, nonatomic) IBOutlet UIButton *mainButton;

@end

@implementation SSTFlatButtonViewController

#pragma mark - View Lifecycle
#pragma mark -

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = self.backButtonTintColor;
    
    if (isiOS7OrLater) {
        self.navigationController.navigationBar.barTintColor = [self.mainButton.tintColor colorWithAlphaComponent:0.5];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[SSTFlatButtonViewController class]]) {
        SSTFlatButtonViewController *vc = (SSTFlatButtonViewController *)segue.destinationViewController;
        vc.backButtonTintColor = self.mainButton.tintColor;
    }
}

#pragma mark - User Actions
#pragma mark -

- (IBAction)defaultButtonTapped:(UIButton *)button {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        button.selected = FALSE;
        button.highlighted = FALSE;
    });
}

- (IBAction)selectedButtonTapped:(UIButton *)button {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        button.selected = TRUE;
        button.highlighted = FALSE;
    });
}

- (IBAction)highlightedButtonTapped:(UIButton *)button {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        button.selected = FALSE;
        button.highlighted = TRUE;
    });
}

@end
