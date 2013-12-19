//
//  BusinessAddress.m
//  Exam
//
//  Created by Mckein on 12/13/13.
//  Copyright (c) 2013 Mckein. All rights reserved.
//

#import "Business.h"
#import "GDataXMLNode.h"


@interface Business()

@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readwrite, strong) NSString *category;
@property (nonatomic, readwrite, strong) NSString *rating;
@property (nonatomic, readwrite, strong) NSString *phone;
@property (nonatomic, readwrite) BusinessLocation *location;

@end

@implementation Business

-(BusinessLocation *)location
{
    if (!_location) _location = [[BusinessLocation alloc] init];
    return _location;
}

-(instancetype) initWithXmlData:(NSData *) xmlData
{
    self = [super init];
    
    if (self){
        NSArray *keyArrays = @[NAME, CATEGORY, RATING, LOCATION, PHONE];
        
        if (xmlData){
            NSError *error;
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                                   options:0 error:&error];
            if (doc == nil) {
                return nil;
            }
            
            int businessSwitchCount = 0;
            for (id key in keyArrays){
                if ([key isKindOfClass:[NSString class]]){
                    
                    NSArray *keyValuesArray = [doc.rootElement elementsForName:key];
                    NSString *xmlValue = [keyValuesArray[0] stringValue];
                    
                    if ([keyValuesArray count]){
                        switch (businessSwitchCount) {
                            case BusinessName:
                                self.name = xmlValue;
                                break;
                            case BusinessCategory:
                                self.category = xmlValue;
                                break;
                            case BusinessRating:
                                self.rating = xmlValue;
                                break;
                            case BusinessLoc:
                                for (GDataXMLElement *locationElement in keyValuesArray){
                                    self.location.address = [(GDataXMLElement *)[locationElement elementsForName:ADDRESS][0]stringValue];
                                    self.location.city = [(GDataXMLElement *)[locationElement elementsForName:CITY][0]stringValue];
                                    self.location.state = [(GDataXMLElement *)[locationElement elementsForName:STATE][0]stringValue];
                                    self.location.zip = [(GDataXMLElement *)[locationElement elementsForName:ZIP][0]stringValue];
                                    self.location.coordinate = CLLocationCoordinate2DMake([[(GDataXMLElement *)[locationElement elementsForName:LATITUDE][0]stringValue] floatValue], [[(GDataXMLElement *)[locationElement elementsForName:LONGITUDE][0]stringValue] floatValue]);
                                }
                                break;
                            case BusinessPhone:
                                self.phone = xmlValue;
                                break;
                        }
                        
                        
                    }
                }
                businessSwitchCount++;
            }
            
        }

    }
    
    return self;

}

@end
