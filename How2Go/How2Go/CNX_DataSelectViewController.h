//
//  CNX_DataSelectViewController.h
//  How2Go
//
//  Created by Thomas Dubiel on 30.09.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CNX_DataSelectViewController;

@protocol CNX_DataSelectViewControllerDelegate
- (void)dataSelectViewControllerDidFinish:(CNX_DataSelectViewController *)controller;
-(NSInteger)getFractionalDigets;
-(NSInteger)getDigits;
-(NSNumber *)getSelectedValue;
@end

@interface CNX_DataSelectViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    NSInteger fractionalDigets;
    NSInteger digits;
    NSNumber *selectedValue;
    int columns;
    
}

@property (weak, nonatomic) id <CNX_DataSelectViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) IBOutlet NSNumber *selectedValue;


- (IBAction)done:(id)sender;

@end
