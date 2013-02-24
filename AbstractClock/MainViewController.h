//
//  MainViewController.h
//  AbstractClock
//
//  Created by curos on 2/12/13.
//  Copyright (c) 2013 curos. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

- (IBAction)showInfo:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *timeDigit;
@property (weak, nonatomic) IBOutlet UILabel *amPm;

@end
