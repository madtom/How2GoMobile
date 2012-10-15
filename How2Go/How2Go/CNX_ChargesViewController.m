//
//  CNX_ChargesViewController.m
//  How2GoLite
//
//  Created by Thomas Dubiel on 20.09.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import "CNX_ChargesViewController.h"

@interface CNX_ChargesViewController ()

@end

@implementation CNX_ChargesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate chargesViewControllerDidFinish:self];
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int numberOfRows;
    
    switch (section) {
        case 0:
            numberOfRows = 1;
            break;
        default:
            numberOfRows = 3;
            break;
    }
    return numberOfRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *tableTitle;
    
    switch (section) {
        case 0:
            tableTitle = nil;
            break;
        case 1:
            tableTitle = @"Expenses per annum";
            break;
        case 2:
            tableTitle = @"Calculated Costs per Kilometer";
            break;
        case 3:
            tableTitle = @"Constant Values";
            break;
    }
    return tableTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // prüfen ob Zellen Reused werden können
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    // wenn keine Zellen reused werden können, erzeuge neue
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    // Detail View Accessor hinzufügen
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Number Formatter vorbereiten
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"Car Price";
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Insurance";
                    break;
                case 1:
                    cell.textLabel.text = @"Car Tax";
                    break;
                case 2:
                    cell.textLabel.text = @"Service";
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Deprication";
                    break;
                case 1:
                    cell.textLabel.text = @"Expenses";
                    break;
                case 2:
                    cell.textLabel.text = @"Total";
                    break;
            }
            break;
        case 3:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Mileage";
                    break;
                case 1:
                    cell.textLabel.text = @"Useful Life";
                    break;
                case 2:
                    cell.textLabel.text = @"Total";
                    break;
            }
    }
    return cell;
}

/*
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"Hier war er an Stelle %i, %i", indexPath.section, indexPath.row);
    selectedCell = indexPath;
    switch (indexPath.section) {
        case 0:
            digits = 3;
            fractionalDigets = 2;
            pickerValue = [NSNumber numberWithDouble:vehicle.ticketPrice];
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    digits = 2;
                    fractionalDigets = 3;
                    pickerValue = [NSNumber numberWithDouble:vehicle.fuelPrice];
                    break;
                case 1:
                    digits = 4;
                    fractionalDigets = 1;
                    pickerValue = [NSNumber numberWithDouble:vehicle.distance];
                    break;
                case 2:
                    digits = 2;
                    fractionalDigets = 2;
                    pickerValue = [NSNumber numberWithDouble:vehicle.averageFuelConsumption];
                    break;
            }
            break;
    }
}
*/


@end
