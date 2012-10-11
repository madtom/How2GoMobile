//
//  CSP-vehicleCalculator.h
//  HowToGo
//
//  Created by Thomas Dubiel on 26.08.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNX_ExtraCharges.h"

@interface CNX_vehicleCalculator : NSObject <NSCoding> {
    
    // Instanzvariablen
    double ticketPrice;
    double fuelPrice;
    double averageFuelConsumption;
    double distance;
    double fuelConsumption;
}

@property (assign) double ticketPrice, fuelPrice, averageFuelConsumption, distance;
@property (readonly) double fuelConsumption;

-(double)calcFare:(bool)considerCharges withCharges:(CNX_ExtraCharges *)charges;

// Protokollmethoden
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;

@end
