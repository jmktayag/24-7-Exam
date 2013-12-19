//
//  ViewController.m
//  Exam
//
//  Created by Mckein on 12/13/13.
//  Copyright (c) 2013 Mckein. All rights reserved.
//

//URL https://dl.dropboxusercontent.com/u/101222705/business.xml
//Display it in map

#import "ViewController.h"
#import "GDataXMLNode.h"
#import "Business.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) NSURL *xmlUrl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) Business *business;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *categoryLbl;
@property (weak, nonatomic) IBOutlet UILabel *ratingLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;

@end

@implementation ViewController


-(void)setXmlUrl:(NSURL *)xmlUrl
{
    _xmlUrl = xmlUrl;
    [self downloadAndParse];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.xmlUrl = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/101222705/business.xml"];
   
}

//Method for downloading and parsing the xml
-(void) downloadAndParse
{
    
    if (self.xmlUrl)
    {
        self.business = nil;
        [self.activityIndicator startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.xmlUrl];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
                                                            if (!error){
                                                                NSLog(@"**responser: %@", localfile);
                                                                
                                                                NSData *xmlData = [NSData dataWithContentsOfURL:localfile];
                                                                
                                                                self.business = [[Business alloc] initWithXmlData:xmlData];
                                                                
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    [self updateUI];
                                                                });
                                                            }
                                                        }]; //double click will comple the params
        [task resume];

    }
    
}


-(void) updateUI
{
    [self.activityIndicator stopAnimating];
    
    //Map Code
    
    if (self.business){
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.business.location.coordinate, 400, 400);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        
        // Add an annotation
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = self.business.location.coordinate;
        point.title = self.business.name;
        point.subtitle = [NSString stringWithFormat:@"%@, %@, %@", self.business.location.address, self.business.location.city, self.business.location.state];
        [self.mapView addAnnotation:point];
        
        //Update labels
        self.nameLbl.text = [NSString stringWithFormat:@"Name: %@", self.business.name];
        self.categoryLbl.text = [NSString stringWithFormat:@"Category: %@", self.business.category];
        self.ratingLbl.text = [NSString stringWithFormat:@"Rating: %@", self.business.rating];
        self.addressLbl.text = [NSString stringWithFormat:@"Address: %@, %@, %@ %@",  self.business.location.address, self.business.location.city, self.business.location.state,self.business.location.zip];
        self.phoneLbl.text = [NSString stringWithFormat:@"Phone: %@", self.business.phone];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
