//
//  CFVFrameSetting.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/18.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import "CFVFrameSetting.h"

@implementation CFVFrameSetting
- (void)setupBoxSubViewFrameSetting {
    if (kiPhone5) {
        self.boxViewOffset_X        = -30;
        self.boxViewTopOffset_Y     = 138;
        self.boxViewLeftOffset_X    = 100;
        self.boxViewRightOffset_X   = -100;
        self.boxViewBottomOffset_Y  = -60;
    }else if (kiPhone6){
        self.boxViewOffset_X        = -30;
        self.boxViewTopOffset_Y     = 160;
        self.boxViewLeftOffset_X    = 110;
        self.boxViewRightOffset_X   = -110;
        self.boxViewBottomOffset_Y  = -70;
    }else if (kiPhone6Plus){
        self.boxViewOffset_X        = -30;
        self.boxViewTopOffset_Y     = 175;
        self.boxViewLeftOffset_X    = 125;
        self.boxViewRightOffset_X   = -125;
        self.boxViewBottomOffset_Y  = -70;
    }else if (IS_IPHONE_X){
        self.boxViewOffset_X        = -20;
        self.boxViewTopOffset_Y     = 155;
        self.boxViewLeftOffset_X    = 165;
        self.boxViewRightOffset_X   = -165;
        self.boxViewBottomOffset_Y  = -65;
    }else if (IS_IPHONE_Xr){
        self.boxViewOffset_X        = -30;
        self.boxViewTopOffset_Y     = 170;
        self.boxViewLeftOffset_X    = 180;
        self.boxViewRightOffset_X   = -180;
        self.boxViewBottomOffset_Y  = -70;
    }else if (IS_IPHONE_Xs_Max){
        self.boxViewOffset_X        = -30;
        self.boxViewTopOffset_Y     = 170;
        self.boxViewLeftOffset_X    = 180;
        self.boxViewRightOffset_X   = -180;
        self.boxViewBottomOffset_Y  = -70;
    }
    
}
@end
