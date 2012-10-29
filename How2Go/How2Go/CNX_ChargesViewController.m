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

@synthesize charges, myTableView, navigationText;

#pragma mark - Charges View

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    charges = [self.delegate getCharges];
    navigationText.title = NSLocalizedString(@"NavExpensesKey", nil);
    
    /*
    NSLocale *myLocal = [NSLocale currentLocale];
    NSString *measurement = [myLocal objectForKey:NSLocaleMeasurementSystem];
    BOOL metric = [myLocal objectForKey:NSLocaleUsesMetricSystem];
    */
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self setMyTableView:nil];    
}

- (void)viewDidUnload
{
    [self setNavigationText:nil];
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
    
    // Ein UIActionSheet erzeugen
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"SheetHeaderKey", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"SheetUpsKey", nil)
                                         destructiveButtonTitle:NSLocalizedString(@"SheetOneKey", nil)
                                              otherButtonTitles:nil, nil];
    // Sheet anzeigen
    [sheet showInView:self.view];
}

#pragma mark - Action Sheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // prüfen des ausgewählten Buttons
    if (buttonIndex == 0) {
        [charges clearAllInstances];
        [myTableView reloadData];
    }
    
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
            tableTitle = NSLocalizedString(@"TableExpensesKey", nil);
            break;
        case 2:
            tableTitle = NSLocalizedString(@"TableCalcKey", nil);
            break;
        case 3:
            tableTitle = NSLocalizedString(@"TableFixeKey", nil);
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
            cell.textLabel.text = NSLocalizedString(@"CarPriceKey", nil);
            [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.carPrice]];
            break;
        case 1:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = NSLocalizedString(@"InsuranceKey", nil);
                    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.insurance]];
                    break;
                case 1:
                    cell.textLabel.text = NSLocalizedString(@"CarTaxKey", nil);
                    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.tax]];
                    break;
                case 2:
                    cell.textLabel.text = NSLocalizedString(@"ServiceKey", nil);;
                    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.service]];
                    break;
                default:
                    break;
            }
            default:
            break;
        case 2:
            cell.accessoryType = UITableViewCellAccessoryNone;
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = NSLocalizedString(@"DepricationKey", nil);
                    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:3];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.deprication]];
                    break;
                case 1:
                    cell.textLabel.text = NSLocalizedString(@"ExpensesKey", nil);
                    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    [numberFormatter setMaximumFractionDigits:3];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.chargesPerKM]];
                    break;
                case 2:
                    cell.textLabel.text = NSLocalizedString(@"TotalKey", nil);
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
                    cell.textLabel.text = NSLocalizedString(@"LifeTimeKey", nil);
                    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.lifeTime]];
                    break;
                case 1:
                    cell.textLabel.text = NSLocalizedString(@"MileageAnnumKey", nil);
                    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:charges.milagePerAnno]];
                    break;
                case 2:
                    cell.textLabel.text = NSLocalizedString(@"MileageLifeKey", nil);
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
            headerDescription = NSLocalizedString(@"HeaderCarPriceKey", nil);
            navHeaderText = NSLocalizedString(@"CarPriceKey", nil);
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    digits = 3;
                    fractionalDigets = 2;
                    pickerValue = [NSNumber numberWithDouble:charges.insurance];
                    headerDescription = NSLocalizedString(@"HeaderInsuranceKey", nil);
                    navHeaderText = NSLocalizedString(@"InsuranceKey", nil);
                    break;
                case 1:
                    digits = 3;
                    fractionalDigets = 2;
                    pickerValue = [NSNumber numberWithDouble:charges.tax];
                    headerDescription = NSLocalizedString(@"HeaderTaxKey", nil);
                    navHeaderText = NSLocalizedString(@"CarTaxKey", nil);
                    break;
                case 2:
                    digits = 4;
                    fractionalDigets = 2;
                    pickerValue = [NSNumber numberWithDouble:charges.service];
                    headerDescription = NSLocalizedString(@"HeaderServiceKey", nil);
                    navHeaderText = NSLocalizedString(@"ServiceKey", nil);
                    break;
                default:
                    break;
            }
        default:
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

-(NSString *)getNavDescription {
    return navHeaderText;
}

@end
