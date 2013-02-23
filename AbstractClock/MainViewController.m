//
//  MainViewController.m
//  AbstractClock
//
//  Created by curos on 2/12/13.
//  Copyright (c) 2013 curos. All rights reserved.
//

#import "MainViewController.h"

static const int iSHAPE_ARRAY_SIZE = 10 ;

static inline int RAND_INT( int iMin, int iMax )
{ return iMin + arc4random()%( (iMax+1)-iMin ) ; }



@interface MainViewController ()

@end

@implementation MainViewController
{
    NSMutableArray* _oShapeVwArr ;
    NSTimer* _oTimer ;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    const CGAffineTransform scaleTransf = CGAffineTransformMakeScale( 0.1, 0.1 ) ;
    _oShapeVwArr = [ [NSMutableArray alloc] initWithCapacity:iSHAPE_ARRAY_SIZE ] ;
    
    for( int i=0 ; i<iSHAPE_ARRAY_SIZE ; ++i )
    {
        NSString* oImgName = [ NSString stringWithFormat:@"PatchSquare%d.png", i ] ;
        UIImage* oImg = [ UIImage imageNamed:oImgName ] ;
        UIImageView* oImgVw = [ [UIImageView alloc] initWithImage:oImg ] ;
        
        oImgVw.transform = scaleTransf ;
        oImgVw.center = CGPointMake( RAND_INT(0,320), RAND_INT(0,480) ) ;
        oImgVw.alpha = 0 ;
        
        [ _oShapeVwArr addObject:oImgVw ] ;
        [ super.view addSubview:oImgVw ] ;
    }
}



-(void) viewWillAppear:(BOOL)a_animated
{
    _oTimer = [ NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime)
                                             userInfo:nil repeats:YES ] ;
}



-(void) viewDidDisappear:(BOOL)a_animated
{
    [ _oTimer invalidate ] ;
    _oTimer = nil ;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}



#pragma mark - ETC


-(void) updateTime
{
    NSDate* oNow = [ NSDate date ] ;
    NSCalendar* oCal = [ NSCalendar currentCalendar ] ;
    NSCalendarUnit calUnits = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |
                              NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
    NSDateComponents* oComp = [ oCal components:calUnits fromDate:oNow ] ;
    
    int iSec = oComp.second ;
    
    UIImageView* oImgVw = _oShapeVwArr[iSec%10] ;
    oImgVw.alpha = 0.3 ;
    float fScale = RAND_INT(20,100) / 100.0 ;    
    
    [ UIView beginAnimations:nil context:NULL ] ;
    [ UIView setAnimationDuration:1.0 ] ;
    [ UIView setAnimationCurve:UIViewAnimationCurveEaseOut ] ;
    oImgVw.transform = CGAffineTransformMakeScale( fScale, fScale ) ;
    [ UIView commitAnimations ] ;    
}

@end
