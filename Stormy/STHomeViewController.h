//
//  STHomeViewController.h
//  Stormy
//
//  Created by Charles Kang on 2/16/16.
//  Copyright © 2016 Charles Kang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STHomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *stockholmSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockholmTempLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stockholmIcon;

@property (nonatomic) NSString *summary;
@property (nonatomic) UIImage *icon;
@property (nonatomic) NSInteger temperature;

- (instancetype)initWithJSON:(NSDictionary *)json;

@end
