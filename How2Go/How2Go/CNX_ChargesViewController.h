//
//  CNX_ChargesViewController.h
//  How2GoLite
//
//  Created by Thomas Dubiel on 20.09.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CNX_ChargesViewController;

@protocol CNX_ChargesViewControllerDelegate
- (void)chargesViewControllerDidFinish:(CNX_ChargesViewController *)controller;
@end

@interface CNX_ChargesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id <CNX_ChargesViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
