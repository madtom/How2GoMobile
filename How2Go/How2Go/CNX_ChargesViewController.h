//
//  CNX_ChargesViewController.h
//  How2GoLite
//
//  Created by Thomas Dubiel on 20.09.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNX_DataSelectViewController.h"
#import "CNX_ExtraCharges.h"

@class CNX_ChargesViewController;

@protocol CNX_ChargesViewControllerDelegate
- (void)chargesViewControllerDidFinish:(CNX_ChargesViewController *)controller;
- (CNX_ExtraCharges *)getCharges;
@end

@interface CNX_ChargesViewController : UIViewController <CNX_DataSelectViewControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSInteger fractionalDigets;
    NSInteger digits;
    NSIndexPath *selectedCell;
    NSNumber *pickerValue;
    NSString *headerDescription;
}

@property (weak, nonatomic) id <CNX_ChargesViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet CNX_ExtraCharges *charges;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)done:(id)sender;

@end
