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

@synthesize busImage, carImage, myTableView, charges, costSwitch, questionImage;
@synthesize imageView, resultLabel, costLabel, switchLabel, mainHeaderLabel, hintLabel;

#pragma mark - Main View

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    busImage = [UIImage imageNamed:@"Bus_100.png"];
    carImage = [UIImage imageNamed:@"Car_100.png"];
    questionImage = [UIImage imageNamed:@"QuestionMark100.png"];
    switchLabel.text = @"Use Expenses";
    hintLabel.text = @"";
    mainHeaderLabel.text = @"Please enter the fare of your public transportation, the current price of gasoline and the distance to your destination. You can see the best choice in the buttom area.";
    
    // load existing files if available or create new instances
    [self openArchives];
    
    // register for notification UIApplicationDidEnterBackgroundNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveArchives:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    // check the charges and set the costSwitch
    [self setCostSwitchState];
    [self checkResult];
}

-(void)setCostSwitchState {
    if ( charges.sumCostsKM == 0) {
        [costSwitch setOn:NO animated:YES];
    } else {
        [costSwitch setOn:YES animated:YES];
    }
}

-(void)openArchives {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *vehicleFilePath = [documentsPath stringByAppendingPathComponent:@"vehicle.plist"];
    NSString *chargesFilePath = [documentsPath stringByAppendingPathComponent:@"charges.plist"];
    BOOL vehicleExist = [fileManager fileExistsAtPath:vehicleFilePath];
    BOOL chargesExist = [fileManager fileExistsAtPath:chargesFilePath];
    
    // if vehicle archive exist, load otherwise create a new
    if (vehicleExist) {
        vehicle = [NSKeyedUnarchiver unarchiveObjectWithFile:vehicleFilePath];
    }
    else {
        vehicle = [CNX_vehicleCalculator new];
    }
    
    // if charges archive exist, load otherwise craete a new
    if (chargesExist) {
        charges = [NSKeyedUnarchiver unarchiveObjectWithFile:chargesFilePath];
    }
    else {
        charges = [CNX_ExtraCharges new];
    }
}

-(void)saveArchives: (NSNotificationCenter *) notification {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *vehicleFilePath = [documentsPath stringByAppendingPathComponent:@"vehicle.plist"];
    NSString *chargesFilePath = [documentsPath stringByAppendingPathComponent:@"charges.plist"];
    [NSKeyedArchiver archiveRootObject:vehicle toFile:vehicleFilePath];
    [NSKeyedArchiver archiveRootObject:charges toFile:chargesFilePath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self saveArchives:nil];
    [self setMyTableView:nil];
    [self setCostSwitch:nil];
    [self setImageView:nil];
    [self setResultLabel:nil];
    [self setCostLabel:nil];
    
}

- (void)viewDidUnload {
    // depricated in iOS 6.0
    [self setSwitchLabel:nil];
    [self setMainHeaderLabel:nil];
    [self setHintLabel:nil];
    [super viewDidUnload];
}

- (IBAction)costSwitchChanged:(id)sender {
    [self checkHint];
    [self checkResult];
}

-(void)checkHint {
    //hintLabel.textColor =
    if ( charges.sumCostsKM == 0 && costSwitch.isOn == 1 ) {
        hintLabel.text = @"Please add Expenses ^^";
    }
    else {
        hintLabel.text = @"";
    }
}

- (IBAction)clear:(id)sender {
    [vehicle clearAllInstances];
    [charges clearAllInstances];
    [myTableView reloadData];
    [self setCostSwitchState];
    [self checkHint];
    [self checkResult];
}

#pragma mark - vehicle methods

-(void)checkResult {

    // Tripkosten berechnen
    tripCosts = [vehicle calcFare:costSwitch.isOn withCharges:charges];
    if (tripCosts == 0) {
        imageView.image = questionImage;
        costLabel.text = @"";
        resultLabel.text = @"Please enter all required values above";
    }
    else {
        // Number Formatter vorbereiten
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        costLabel.text = [NSString stringWithFormat:@"Vehicle's Costs: %@", [numberFormatter stringFromNumber:[NSNumber numberWithDouble:tripCosts]]];
        if ( tripCosts >= vehicle.ticketPrice ) {
            imageView.image = busImage;
            resultLabel.text = @"Take the Bus!";
        }
        else {
            imageView.image = carImage;
            resultLabel.text = @"Take the Car!";
        }
    }
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
    self.charges = controller.charges;
    [self setCostSwitchState];
    [self checkHint];
    [self checkResult];
}

-(CNX_ExtraCharges *) getCharges {
    if ( charges == nil ) {
        return nil;
    } else {
        return charges;
    }
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
             headerDescription = @"Please enter the fare of a trip with your favorit public transportation. This value is the baseline to check what is the best way to go.";
             break;
         case 1:
             switch (indexPath.row) {
                 case 0:
                     digits = 2;
                     fractionalDigets = 3;
                     pickerValue = [NSNumber numberWithDouble:vehicle.fuelPrice];
                     headerDescription = @"Please enter the curent price of a unit of fuel. This price is one of the mandatory costs to decide the best way to go.";
                     break;
                 case 1:
                     digits = 4;
                     fractionalDigets = 1;
                     pickerValue = [NSNumber numberWithDouble:vehicle.distance];
                     headerDescription = @"Please enter the distance of your trip you have to go. The distance should be the route for going by car. The distance is one of the mandatory values to decide what is the best way to go.";
                     break;
                 case 2:
                     digits = 2;
                     fractionalDigets = 2;
                     pickerValue = [NSNumber numberWithDouble:vehicle.averageFuelConsumption];
                     headerDescription = @"Please enter the average fuel consumption of your car. This value is mandatory to decide what is the best way to go.";
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
    [self checkResult];
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
