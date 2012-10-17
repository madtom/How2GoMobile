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

@synthesize charges, myTableView;

#pragma mark - Charges View

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    charges = [self.delegate getCharges];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self setMyTableView:nil];    
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

- (IBAction)done:(id)sender
{
    [self.delegate chargesViewControllerDidFinish:self];
}

- (IBAction)clear:(id)sender {
    [charges clearAllInstances];
    [myTableView reloadData];
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
    
    // Number Formatter vorbereiten
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    
    switch (indexPath.section) {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"Car Price";
            [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.carPrice]];
            break;
        case 1:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Insurance";
                    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.insurance]];
                    break;
                case 1:
                    cell.textLabel.text = @"Car Tax";
                    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.tax]];
                    break;
                case 2:
                    cell.textLabel.text = @"Service";
                    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.service]];
                    break;
            }
            break;
        case 2:
            cell.accessoryType = UITableViewCellAccessoryNone;
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Deprication";
                    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:3];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.deprication]];
                    break;
                case 1:
                    cell.textLabel.text = @"Expenses";
                    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:3];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.chargesPerKM]];
                    break;
                case 2:
                    cell.textLabel.text = @"Total";
                    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:3];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.sumCostsKM]];
                    break;
            }
            break;
        case 3:
            cell.accessoryType = UITableViewCellAccessoryNone;
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Life Time (years)";
                    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.lifeTime]];
                    break;
                case 1:
                    cell.textLabel.text = @"Mileage Per Annum";
                    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.milagePerAnno]];
                    break;
                case 2:
                    cell.textLabel.text = @"Mileage Life Time";
                    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.milageLife]];
                    break;
            }
    }
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"Hier war er an Stelle %i, %i", indexPath.section, indexPath.row);
    selectedCell = indexPath;
    switch (indexPath.section) {
        case 0:
            digits = 5;
            fractionalDigets = 0;
            pickerValue = [NSNumber numberWithDouble:charges.carPrice];
            headerDescription = @"Please enter the original price of your car. This value is mandatory of all further calculations.";
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    digits = 3;
                    fractionalDigets = 2;
                    pickerValue = [NSNumber numberWithDouble:charges.insurance];
                    headerDescription = @"Please enter the total amount for all insurances which are related to your car. This value is part of the expenses which are calculated by the tool.";
                    break;
                case 1:
                    digits = 3;
                    fractionalDigets = 2;
                    pickerValue = [NSNumber numberWithDouble:charges.tax];
                    headerDescription = @"Please enter the total amount of all taxes which are related to your car. This value is part of the expenses which are calculated by the tool.";
                    break;
                case 2:
                    digits = 4;
                    fractionalDigets = 2;
                    pickerValue = [NSNumber numberWithDouble:charges.service];
                    headerDescription = @"Please enter the total amount of your yearly service fee which is related to your car. This value is part of the expenses which are calculated by this tool.";
                    break;
            }
            break;
    }
}

#pragma mark - Data Select View

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDataPicker"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

-(void) dataSelectViewControllerDidFinish:(CNX_DataSelectViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    switch (selectedCell.section) {
        case 0:
            charges.carPrice = [controller.selectedValue doubleValue];
            break;
        case 1:
            switch (selectedCell.row) {
                case 0:
                    charges.insurance = [controller.selectedValue doubleValue];
                    break;
                case 1:
                    charges.tax = [controller.selectedValue doubleValue];
                    break;
                case 2:
                    charges.service = [controller.selectedValue doubleValue];
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

-(NSString *)getHeaderDescription {
    return headerDescription;
}

@end
