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

@interface CNX_MainViewController : UIViewController <CNX_FlipsideViewControllerDelegate, CNX_ChargesViewControllerDelegate, CNX_DataSelectViewControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSInteger fractionalDigets;
    NSInteger digits;
    NSIndexPath *selectedCell;
    NSNumber *pickerValue;
    CNX_vehicleCalculator *vehicle;
}

@property (nonatomic, retain) UIImage *busImage;
@property (nonatomic, retain) UIImage *carImage;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@end
