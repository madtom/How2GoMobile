//
//  CNX_DataSelectViewController.m
//  How2Go
//
//  Created by Thomas Dubiel on 30.09.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import "CNX_DataSelectViewController.h"

@interface CNX_DataSelectViewController ()

@end

@implementation CNX_DataSelectViewController

@synthesize picker, selectedValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPicker:nil];
    [super viewDidUnload];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    fractionalDigets = [self.delegate getFractionalDigets];
    digits = [self.delegate getDigits];
    columns = digits + fractionalDigets;
    selectedValue = [self.delegate getSelectedValue];
    [picker reloadAllComponents];
    
    int counter, zahl, subtrahend;
    for (int i = 0; i < columns; i++) {
        if (i == 0) {
            counter = 1;
        } else {
            counter *= 10;
        }
    }
    double rechenzahl = [selectedValue doubleValue];
    for (int i = 0; i < fractionalDigets; i++) {
        rechenzahl *= 10;
    }
    for (int i = 0; i < columns; i++) {
        zahl = rechenzahl / counter;
        subtrahend = zahl * counter;
        rechenzahl -= subtrahend;
        counter /= 10;
        [picker selectRow:zahl inComponent:i animated:YES];
        [picker reloadComponent:i];
    }
}

- (IBAction)done:(id)sender {
    [self.delegate dataSelectViewControllerDidFinish:self];
}

#pragma mark - Data Picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return digits + fractionalDigets;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
        return 10;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == digits -1) {
        return [NSString stringWithFormat:@"%i,", row];
    }
    else {
        return [NSString stringWithFormat:@"%i", row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    float zahl = 0;
    int expo = fractionalDigets * (-1);
    for (int i = 0; i<columns; i++) {
        zahl = zahl *10 + [pickerView selectedRowInComponent:i];
    }    
    selectedValue = [NSDecimalNumber decimalNumberWithMantissa:zahl exponent:expo isNegative:NO];
}


@end
