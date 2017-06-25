//
//  GUC.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/25.
//  Copyright © 2017年 jaki. All rights reserved.
//

#ifndef GUC_h
#define GUC_h


#endif /* GUC_h */

#import "GreatUserInterfaceControl.h"

#define GUC_REFRESH(viewId) [[GreatUserInterfaceControl defaultControl]refreshView:viewId]

#define GUC_ADD_OBSERVER(ob,viewId,sel) [[GreatUserInterfaceControl defaultControl]addObserver:ob inViewID:viewId withAction:sel]

#define GUC_REMOVE_OBSERVER_ID(ob,viewId) [[GreatUserInterfaceControl defaultControl] removeObserver:ob inViewID:viewId]

#define GUC_REMOVE_OBSERVER(ob) [[GreatUserInterfaceControl defaultControl]removeObserver:ob]
