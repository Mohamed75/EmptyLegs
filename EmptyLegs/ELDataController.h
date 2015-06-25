//
//  ELDataController.h
//  EmptyLegs
//
//  Created by Mohamed Boumansour on 25/06/15.
//  Copyright (c) 2015 explovia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELDataController : NSObject

@property NSMutableArray *cargos;

+ (ELDataController *) getSharedInstance;

- (void) loadCargos;

@end
