//
//  CNX_MainViewController.m
//  How2Go
//
//  Created by Thomas Dubiel on 21.09.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import "CNX_MainViewController.h"

@interface CNX_MainViewController ()

@end

@implementation CNX_MainViewController

@synthesize busImage, carImage, myTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    busImage = [UIImage imageNamed:@"Bus_100.png"];
    carImage = [UIImage imageNamed:@"Car_100.png"];
    
    // create a instance of vehicle
    vehicle = [[CNX_vehicleCalculator alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(CNX_FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"] ||
        [[segue identifier] isEqualToString:@"showCharges"] ||
        [[segue identifier] isEqualToString:@"showDataSelect"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark - Charges View

-(void)chargesViewControllerDidFinish:(CNX_ChargesViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int numberOfRows;
    
    switch (section) {
        case 0:
            numberOfRows = 1;
            break;
        case 1:
            numberOfRows = 3;
            break;
    }
    return numberOfRows;
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
            cell.textLabel.text = @"Fare";
            [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:vehicle.ticketPrice]];
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Gas Price";
                    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:3];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:vehicle.fuelPrice]];
                    break;
                case 1:
                    cell.textLabel.text = @"Distance";
                    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:vehicle.distance]];
                    break;
                case 2:
                    cell.textLabel.text = @"Gas Consumption";
                    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:vehicle.averageFuelConsumption]];
                    break;
            }
            break;
    }
    return cell;
}

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

#pragma mark - Data Select View

-(void) dataSelectViewControllerDidFinish:(CNX_DataSelectViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    switch (selectedCell.section) {
        case 0:
            vehicle.ticketPrice = [controller.selectedValue doubleValue];
            break;
        case 1:
            switch (selectedCell.row) {
                case 0:
                    vehicle.fuelPrice = [controller.selectedValue doubleValue];
                    break;
                case 1:
                    vehicle.distance = [controller.selectedValue doubleValue];
                    break;
                case 2:
                    vehicle.averageFuelConsumption = [controller.selectedValue doubleValue];
                    break;
            }
            break;
    }
    [myTableView reloadData];
    //#warning Hier muss ich später die richtigen werte ersetzen
    //    pickerValue = controller.selectedValue;
    //    NSLog(@"selected value: %.3f", [pickerValue doubleValue]);
}

-(NSInteger)getFractionalDigets {
    return fractionalDigets;
}

-(NSInteger)getDigits {
    return digits;
}

-(NSNumber *)getSelectedValue {
    return pickerValue;
}

- (void)viewDidUnload {
    [self setMyTableView:nil];
    [super viewDidUnload];
}
@end
