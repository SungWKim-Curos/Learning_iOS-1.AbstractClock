//
//  FlipsideViewController.m
//  AbstractClock
//
//  Created by curos on 2/12/13.
//  Copyright (c) 2013 curos. All rights reserved.
//

#import "FlipsideViewController.h"

#import "Constants.h"



@interface FlipsideViewController ()

@property (strong, nonatomic) IBOutlet UITableViewCell *switchTableCell;

@end

@implementation FlipsideViewController

static const int TABLE_ROWS[] = { 2, 3 } ;
static const int iTABLE_SECTIONS = sizeof(TABLE_ROWS)/sizeof(TABLE_ROWS[0]) ;
static NSString* const REUSE_ID[] = { @"Simple", @"Switch" } ;

static NSString* const SECT0_SHAPE_LABEL[] = { @"Squres", @"Circles" } ;

static NSString* const SECT1_OPTION_LABEL[] = { @"24 Hours Mode", @"Date Information", @"Allow Auto-Lock" } ;
static NSString* const SECT1_OPTION_KEY[] = { CLOCK_OPTION_24HOUR, CLOCK_OPTION_DATE_DISPLAY, CLOCK_OPTION_24HOUR } ;



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
    NSInteger iRow = a_oIndexPath.row ;
    
    UITableViewCell* oCell = [ a_oTblVw dequeueReusableCellWithIdentifier:REUSE_ID[iSect] ] ;
    if( nil == oCell )
    {
        if( 1 == iSect )
        {
            UINib* oNib = [ UINib nibWithNibName:@"SwitchTableCell" bundle:[NSBundle mainBundle] ] ;
            [ oNib instantiateWithOwner:self options:nil ] ;
            oCell = _switchTableCell ;
        }
        else
        {
            oCell = [ [UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSE_ID[iSect] ] ;
        }
    }
    
    switch ( iSect )
    {
        case 0 :
        {
            oCell.textLabel.text = SECT0_SHAPE_LABEL[iRow] ;
            NSInteger iShape = [ [NSUserDefaults standardUserDefaults] integerForKey:CLOCK_OPTION_SHAPE ] ;
            oCell.accessoryType = iShape==iRow ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone ;
        }
            break;
            
        case 1 :
            oCell.textLabel.text = SECT1_OPTION_LABEL[iRow] ;
            oCell.selectionStyle = UITableViewCellSelectionStyleNone ;
            UISwitch* oSwitch = (UISwitch*)oCell.accessoryView ;
            oSwitch.on = [ [NSUserDefaults standardUserDefaults] boolForKey:SECT1_OPTION_KEY[iRow] ] ;
            break ;
    }
    
    return oCell ;
    
}



#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
