//
//  CSP-vehicleCalculator.m
//  HowToGo
//
//  Created by Thomas Dubiel on 26.08.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import "CNX_vehicleCalculator.h"

@implementation CNX_vehicleCalculator

@synthesize ticketPrice, fuelPrice, averageFuelConsumption, distance;
@synthesize fuelConsumption;

-(double)fuelConsumption {
    return self.averageFuelConsumption * self.distance / 100;
}

-(double)calcFare:(bool)considerCharges withCharges:(CNX_ExtraCharges *)charges {
    
    if (considerCharges == TRUE) {
        
        return self.fuelConsumption * self.fuelPrice + ( ( charges.chargesPerKM + charges.deprication ) * self.distance );
    }
    else {
        return self.fuelConsumption * self.fuelPrice;
    }
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:ticketPrice forKey:@"ticketPrice"];
    [aCoder encodeDouble:fuelPrice forKey:@"fuelPrice"];
    [aCoder encodeDouble:averageFuelConsumption forKey:@"averageFuelConsumption"];
    [aCoder encodeDouble:distance forKey:@"distance"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    // initialization of parent class
    if (![super init]) return nil;
    
    // read attributes from archive
    [self setTicketPrice:[aDecoder decodeDoubleForKey:@"ticketPrice"]];
    [self setFuelPrice:[aDecoder decodeDoubleForKey:@"fuelPrice"]];
    [self setAverageFuelConsumption:[aDecoder decodeDoubleForKey:@"averageFuelConsumption"]];
    [self setDistance:[aDecoder decodeDoubleForKey:@"distance"]];
    return self;
}

@end
