//
//  CSP-ExtraCharges.m
//  HowToGo
//
//  Created by Thomas Dubiel on 24.08.12.
//  Copyright (c) 2012 Thomas Dubiel. All rights reserved.
//

#import "CNX_ExtraCharges.h"

@implementation CNX_ExtraCharges

@synthesize lifeTime, milagePerAnno, milageLife, deprication, chargesPerKM, sumCharges, sumCostsKM;
@synthesize insurance, tax, carPrice, service;

-(id)init {
    
    if ((self = [super init])) {
    // set initial values

    }
    return self;
}

-(double)lifeTime {
    return 12.4;
}

-(int)milagePerAnno {
    return 19000;
}

-(double)milageLife {
    return self.milagePerAnno * self.lifeTime;
}

-(double)deprication {
    return self.carPrice / self.milageLife;
}

-(double)sumCharges {
    return self.insurance + self.tax + self.service;
}

-(double)chargesPerKM {
    return self.sumCharges / self.milagePerAnno;
}

-(double)sumCostsKM {
    return self.deprication + self.chargesPerKM;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:[self carPrice] forKey:@"carPrice"];
    [aCoder encodeDouble:[self insurance] forKey:@"insurance"];
    [aCoder encodeDouble:[self tax] forKey:@"tax"];
    [aCoder encodeDouble:[self service] forKey:@"service"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    // Initialisierung der Elternklasse
    if (![super init])
        return nil;
    
    // Variablen aus der Datei lesen
    [self setCarPrice:[aDecoder decodeDoubleForKey:@"carPrice"]];
    [self setInsurance:[aDecoder decodeDoubleForKey:@"insurance"]];
    [self setTax:[aDecoder decodeDoubleForKey:@"tax"]];
    [self setService:[aDecoder decodeDoubleForKey:@"service"]];
    return self;
}

-(void)clearAllInstances {
    carPrice = 0;
    insurance = 0;
    tax = 0;
    service = 0;
}

@end
