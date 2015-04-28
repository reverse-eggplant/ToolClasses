//
//  FontDefines.h
//  Baller
//
//  Created by malong on 15/1/10.
//  Copyright (c) 2015年 malong. All rights reserved.
//

#ifndef Baller_FontDefines_h
#define Baller_FontDefines_h


#pragma mark 字体
//字体名
#define HLN @"HelveticaNeue"
#define HLN_Bold @"HelveticaNeue-Bold"
#define HLN_Light @"HelveticaNeue-Light"
#define HLN_Thin @"HelveticaNeue-Thin"
#define HLN_Regular @"HelveticaNeue-Regular"

//默认字体
#define DEFAULT_FONTSIZE    17

#define SYSTEM_FONT_S(s)     [UIFont systemFontOfSize:s]

#define SYSTEM_FONT_NS(n,s)     [UIFont fontWithName:n size:s]

#define DEFAULT_BOLDFONT(s) [UIFont fontWithName:@"Helvetica-Bold" size:s]

// For table cells
#define CELL_FONTSIZE    16

#define CELL_FONT(s)     [UIFont fontWithName:@"Helvetica" size:s]

#define CELL_BOLDFONT(s) [UIFont fontWithName:@"Helvetica-Bold" size:s]



#endif
