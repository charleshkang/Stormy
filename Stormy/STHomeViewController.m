//
//  STHomeViewController.m
//  Stormy
//
//  Created by Charles Kang on 2/16/16.
//  Copyright © 2016 Charles Kang. All rights reserved.
//

#import "Forecastr.h"
#import "ForecastrAPIClient.h"
#import <AFNetworking/AFNetworking.h>

#import "STHomeViewController.h"
#import "STTokyoTableViewController.h"
#import "STTorontoTableViewController.h"

@interface STHomeViewController ()

@property (nonatomic) NSMutableArray *searchResults;

@end

@implementation STHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Stockholm Weather";
    [self checkForAPIKey];
    [self updateLabels];
    [self fetchForecastData];
}

- (instancetype)initWithJSON:(NSDictionary *)json {
    
    if (self = [super init]) {
        
        self.summary = json[@"summary"];
        self.icon = json[@"icon"];
        self.temperature = [json[@"temperature"] integerValue];
        
        return self;
    }
    return nil;
}

- (void) updateLabels {
    self.stockholmSummaryLabel.text = self.summary;
    self.stockholmTempLabel.text = [NSString stringWithFormat:@"%@", self.icon];
    self.stockholmIcon.image = self.icon;
}

- (void)checkForAPIKey {
    NSString *APIKey = @"a94fd4fbdf72c5a56b4397f5249655ae";
    if (!APIKey || !APIKey.length) {
        [NSException raise:@"Forecastr" format:@"Your Forecast.io API key must be populated before you can access the API.", nil];
    }
}

- (void) fetchForecastData {
    
    // create forecast.io url
    NSString *ForecastURLString = @"https://api.forecast.io/forecast/a94fd4fbdf72c5a56b4397f5249655ae/35.6833,139.6833";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:ForecastURLString
      parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             NSDictionary *results = [responseObject objectForKey:@"currently"];
             NSArray *data= [results objectForKey:@"currently"];
             
             // reset my array
             self.searchResults = [[NSMutableArray alloc] init];
             NSLog(@"%@", responseObject);
             
             
             // loop through all json posts
             for (NSDictionary *result in data) {
                 
                 // create ForecastJSON
                 STHomeViewController *weatherResult = [[STHomeViewController alloc] initWithJSON:result];
                 [self.searchResults addObject:weatherResult];
             }
         } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
             NSLog(@"%@", error);
             
         }];
}

- (IBAction)tokyoWeatherTapped:(id)sender {
    NSLog(@"Tokyo Segue");
}
- (IBAction)torontoWeatherTapped:(id)sender {
    NSLog(@"Toronto Segue");
}

@end
