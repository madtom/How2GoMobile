//
//  CSP-ExtraCharges.h
//  HowToGo
//
//  Created by Thomas Dubiel on 24.08.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNX_ExtraCharges : NSObject <NSCoding> {
    
    // Instanzvariablen
//    double carPrice;
//    double insurance;
//    double tax;
//    double service;
    
}

@property (readonly) double lifeTime, milageLife, deprication, chargesPerKM, sumCharges, sumCostsKM;
@property (readonly) int milagePerAnno;

@property (assign) double carPrice, insurance, tax, service;

// Protokollmethoden
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;

// eigene Methoden
-(void)clearAllInstances;

@end
