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
        
        [ _oShapeVwArr addObject:oImgVw ] ;
        [ super.view addSubview:oImgVw ] ;
    }
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

@end
