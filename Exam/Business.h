//
//  Business.h
//  Exam
//
//  Created by Mckein on 12/13/13.
//  Copyright (c) 2013 Mckein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessLocation.h"


//Business Model

@interface Business : NSObject

@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *category;
@property (nonatomic, readonly, strong) NSString *rating;
@property (nonatomic, readonly, strong) NSString *phone;
@property (nonatomic, readonly) BusinessLocation *location;

-(instancetype) initWithXmlData:(NSData *) xmlData;

@end
