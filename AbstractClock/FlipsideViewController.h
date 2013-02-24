//
//  FlipsideViewController.h
//  AbstractClock
//
//  Created by curos on 2/12/13.
//  Copyright (c) 2013 curos. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Constants.h"



@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
-(void) changedShape:(CLOCK_SHAPE_t)a_shape ;
-(void) changed24Mode:(BOOL)a_on ;
-(void) changedDateInfo:(BOOL)a_on ;
@end

@interface FlipsideViewController : UIViewController < UITableViewDelegate, UITableViewDataSource >

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
