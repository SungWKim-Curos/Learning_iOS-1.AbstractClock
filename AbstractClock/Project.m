//
//  Project.m
//  AbstractClock
//
//  Created by curos on 2/25/13.
//  Copyright (c) 2013 curos. All rights reserved.
//


static CGSize sg_screenSize = { 320, 480 } ;


void TakeScreenSize( const CGSize* a_pSize )
{
    sg_screenSize = *a_pSize ;    
}


CGFloat GetScreenWidth()
{
    return sg_screenSize.width ;
}


CGFloat GetScreenHeight()
{
    return sg_screenSize.height ;
}
