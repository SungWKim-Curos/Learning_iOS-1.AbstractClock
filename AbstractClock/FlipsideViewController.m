//
//  FlipsideViewController.m
//  AbstractClock
//
//  Created by curos on 2/12/13.
//  Copyright (c) 2013 curos. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

static const int TABLE_ROWS[] = { 2, 3 } ;
static const int iTABLE_SECTIONS = sizeof(TABLE_ROWS)/sizeof(TABLE_ROWS[0]) ;
static NSString* const REUSE_ID[] = { @"Simple", @"Switch" } ;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableView


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return iTABLE_SECTIONS ;
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)a_iSection
{
    return TABLE_ROWS[a_iSection] ;
}



-(UITableViewCell*) tableView:(UITableView*)a_oTblVw cellForRowAtIndexPath:(NSIndexPath *)a_oIndexPath
{
    NSInteger iSect = a_oIndexPath.section ;
    UITableViewCell* oCell = [ a_oTblVw dequeueReusableCellWithIdentifier:REUSE_ID[iSect] ] ;
    if( nil == oCell )
    {
        oCell = [ [UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSE_ID[iSect] ] ;
    }
    
    return oCell ;
    
}



#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
