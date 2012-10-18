//
//  CNX_MainViewController.h
//  How2Go
//
//  Created by Thomas Dubiel on 21.09.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import "CNX_FlipsideViewController.h"
#import "CNX_ChargesViewController.h"
#import "CNX_DataSelectViewController.h"
#import "CNX_vehicleCalculator.h"
#import "CNX_ExtraCharges.h"

@interface CNX_MainViewController : UIViewController <CNX_FlipsideViewControllerDelegate, CNX_ChargesViewControllerDelegate, CNX_DataSelectViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate> {
    NSInteger fractionalDigets;
    NSInteger digits;
    NSIndexPath *selectedCell;
    NSNumber *pickerValue;
    NSString *headerDescription;
    NSString *navHeaderText;
    CNX_vehicleCalculator *vehicle;
    double tripCosts;
}

- (CNX_ExtraCharges *)getCharges;
- (IBAction)costSwitchChanged:(id)sender;
- (IBAction)clear:(id)sender;

@property (nonatomic, retain) UIImage *busImage;
@property (nonatomic, retain) UIImage *carImage;
@property (nonatomic, retain) UIImage *questionImage;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet CNX_ExtraCharges *charges;
@property (weak, nonatomic) IBOutlet UISwitch *costSwitch;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainHeaderLabel;

@end
