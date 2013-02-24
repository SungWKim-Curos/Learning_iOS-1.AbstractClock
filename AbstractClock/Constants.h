//
//  Constants.h
//  AbstractClock
//
//  Created by curos on 2/24/13.
//  Copyright (c) 2013 curos. All rights reserved.
//

#ifndef AbstractClock_Constants_h
#define AbstractClock_Constants_h

typedef enum CLOCK_SHAPE_t : int
{
iCLOCK_SHAPE_SQURE  = 0,
iCLOCK_SHAPE_CIRCLE = 1
}
CLOCK_SHAPE_t ;

#define CLOCK_OPTION_SHAPE          @"Shape"
#define CLOCK_OPTION_24HOUR         @"24Hour"
#define CLOCK_OPTION_DATE_DISPLAY   @"DateDisplay"
#define CLOCK_OPTION_AUTOLOCK       @"AutoLock"

#endif
