//
//  Location.h
//  Exam
//
//  Created by Mckein on 12/13/13.
//  Copyright (c) 2013 Mckein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//Location Details
@interface BusinessLocation : NSObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic) CLLocationCoordinate2D coordinate;


@end
