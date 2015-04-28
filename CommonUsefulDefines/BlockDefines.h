//
//  BlockDefines.h
//  Baller
//
//  Created by malong on 15/1/9.
//  Copyright (c) 2015年 malong. All rights reserved.
//

#define __WEAKOBJ(weakObj,Obj) __weak __typeof(&*Obj)weakObj = Obj;

#define __STRONGOBJ(strongObj,Obj) __strong __typeof(&*Obj)strongObj = Obj;

#define __BLOCKOBJ(blockObj,Obj) __block __typeof(&*Obj)blockObj = Obj;

#define __UNSAFED_UNRETAINEDOBJ(usurObj,Obj) __unsafe_unretained __typeof(&*Obj)usurObj = Obj;


//GCD函数
#define BACKGROUND_BLOCK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define MAIN_BLOCK(block) dispatch_async(dispatch_get_main_queue(),block)
