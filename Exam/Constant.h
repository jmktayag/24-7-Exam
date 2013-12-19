//
//  Constant.h
//  Exam
//
//  Created by Mckein on 12/13/13.
//  Copyright (c) 2013 Mckein. All rights reserved.
//

#import <Foundation/Foundation.h>

//XML KEYS
#define NAME @"name"
#define CATEGORY @"category"
#define RATING @"rating"
#define LOCATION @"location"
#define PHONE @"phone"

#define ADDRESS @"address"
#define CITY @"city"
#define STATE @"state"
#define ZIP @"zip"
#define LONGITUDE @"longitude"
#define LATITUDE @"latitude"

//Enum for business model
typedef NS_ENUM(NSUInteger, BusinessDetail) {
    BusinessName,
    BusinessCategory,
    BusinessRating,
    BusinessLoc,
    BusinessPhone
};

