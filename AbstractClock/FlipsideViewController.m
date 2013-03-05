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
static NSString* const HEADER[] = { @"Shape Type", @"Options" } ;
static NSString* const FOOTER[] =
{
    nil,
    @"Abstract Clock Ver 1.0\nKeep up the good work!\n\n"
};

static NSString* const SECT0_SHAPE_LABEL[] = { @"Squares", @"Circles" } ;

static NSString* const SECT1_OPTION_LABEL[] = { @"24 Hours Mode", @"Date Information", @"Allow Auto-Lock" } ;
static NSString* const SECT1_OPTION_KEY[] = { CLOCK_OPTION_24HOUR, CLOCK_OPTION_DATE_DISPLAY, CLOCK_OPTION_AUTOLOCK } ;



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



-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return HEADER[section] ;
}



-(NSString*) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return FOOTER[section] ;
}



-(UITableViewCell*) tableView:(UITableView*)a_oTblVw cellForRowAtIndexPath:(NSIndexPath *)a_oIndexPath
{
    NSInteger iSect = a_oIndexPath.section ;
    NSInteger iRow = a_oIndexPath.row ;
    
    UITableViewCell* oCell = [ a_oTblVw dequeueReusableCellWithIdentifier:REUSE_ID[iSect] ] ;
    if( nil == oCell )
    {
        switch( iSect )
        {
            case 0 :
            {
                oCell = [ [UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSE_ID[0] ] ;
            }
                break ;
                
            case 1 :
            {
                UINib* oNib = [ UINib nibWithNibName:@"SwitchTableCell" bundle:[NSBundle mainBundle] ] ;
                [ oNib instantiateWithOwner:self options:nil ] ;
                oCell = _switchTableCell ;
            }
                break ;
        }
    }
    
    switch( iSect )
    {
        case 0 :
        {
            oCell.textLabel.text = SECT0_SHAPE_LABEL[iRow] ;
            NSInteger iShape = [ [NSUserDefaults standardUserDefaults] integerForKey:CLOCK_OPTION_SHAPE ] ;
            oCell.accessoryType = iShape==iRow ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone ;
        }
            break;
            
        case 1 :
        {
            oCell.textLabel.text = SECT1_OPTION_LABEL[iRow] ;
            oCell.selectionStyle = UITableViewCellSelectionStyleNone ;
            UISwitch* oSwitch = (UISwitch*)oCell.accessoryView ;
            oSwitch.on = [ [NSUserDefaults standardUserDefaults] boolForKey:SECT1_OPTION_KEY[iRow] ] ;
            oSwitch.tag = iRow ;
        }
            break ;
    }
    
    return oCell ;
    
}



-(void) tableView:(UITableView*)a_oTblVw didSelectRowAtIndexPath:(NSIndexPath*)a_oIndexPath
{
    if( 1 == a_oIndexPath.section )
        return ;
    
    NSUserDefaults* oUserDefs = [ NSUserDefaults standardUserDefaults ] ;
    NSInteger iOldShape = [ oUserDefs integerForKey:CLOCK_OPTION_SHAPE ] ;
    NSInteger iRow = a_oIndexPath.row ;
    if( iOldShape != iRow )
    {
        NSIndexPath* oOldIndexPath = [ NSIndexPath indexPathForRow:iOldShape inSection:0 ] ;
        [ a_oTblVw cellForRowAtIndexPath:oOldIndexPath ].accessoryType = UITableViewCellAccessoryNone ;
        [ a_oTblVw cellForRowAtIndexPath:a_oIndexPath ].accessoryType = UITableViewCellAccessoryCheckmark ;
    
        [ oUserDefs setInteger:iRow forKey:CLOCK_OPTION_SHAPE ] ;
#ifdef DEBUG
        [ oUserDefs synchronize ] ;
#endif
        
        [ _delegate changedShape:(CLOCK_SHAPE_t)iRow ] ;
    }
    
    [ a_oTblVw deselectRowAtIndexPath:a_oIndexPath animated:YES ] ;
}



#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}



-(IBAction) switchChanged:(UISwitch*)a_oSenderSwitch
{
    int iRow = a_oSenderSwitch.tag ;
    BOOL switchOn = a_oSenderSwitch.on ;
    NSUserDefaults* oUserDefs = [NSUserDefaults standardUserDefaults] ;
    [ oUserDefs setBool:switchOn forKey:SECT1_OPTION_KEY[iRow] ] ;
#ifdef DEBUG
    [ oUserDefs synchronize ] ;
#endif
    
    switch( iRow )
    {
        case 0 :
            [ _delegate changed24Mode:switchOn ] ;
            break ;
            
        case 1 :
            [ _delegate changedDateInfo:switchOn ] ;
            break ;
            
        case 2 :
            [UIApplication sharedApplication].idleTimerDisabled = NO==switchOn ;
            break;
    }
}

@end
