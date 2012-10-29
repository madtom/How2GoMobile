//
//  CNX_FlipsideViewController.h
//  How2Go
//
//  Created by Thomas Dubiel on 21.09.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CNX_FlipsideViewController;

@protocol CNX_FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(CNX_FlipsideViewController *)controller;
@end

@interface CNX_FlipsideViewController : UIViewController

@property (weak, nonatomic) id <CNX_FlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *productOff;
@property (weak, nonatomic) IBOutlet UITextView *firstText;
@property (weak, nonatomic) IBOutlet UITextView *secondText;
@property (weak, nonatomic) IBOutlet UITextView *decisionText;
@property (weak, nonatomic) IBOutlet UILabel *versionText;

- (IBAction)done:(id)sender;

@end
