//
//  CNX_FlipsideViewController.m
//  How2Go
//
//  Created by Thomas Dubiel on 21.09.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import "CNX_FlipsideViewController.h"

@interface CNX_FlipsideViewController ()

@end

@implementation CNX_FlipsideViewController

@synthesize productOff, firstText, secondText, decisionText;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    productOff.text = NSLocalizedString(@"ProductOfKey", nil);
    firstText.text = NSLocalizedString(@"FirstTextKey", nil);
    secondText.text = NSLocalizedString(@"SecondTextKey", nil);
    decisionText.text = NSLocalizedString(@"DecisionTextKey", nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self setProductOff:nil];
    [self setFirstText:nil];
    [self setSecondText:nil];
    [self setDecisionText:nil];
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (void)viewDidUnload {

    [super viewDidUnload];
}
@end
