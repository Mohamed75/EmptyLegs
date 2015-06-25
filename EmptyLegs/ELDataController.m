//
//  ELDataController.m
//  EmptyLegs
//
//  Created by Mohamed Boumansour on 25/06/15.
//  Copyright (c) 2015 explovia. All rights reserved.
//

#import "ELDataController.h"

@implementation ELDataController

static ELDataController *sharedInstance;
+ (ELDataController *) getSharedInstance{
    
    if (sharedInstance == nil) {
        
        sharedInstance = [super new];
    }
    return sharedInstance;
}

- (void) loadCargos{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Cargo"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil){
            
            self.cargos = [NSMutableArray arrayWithArray:objects];
            [[ELMainViewController getSharedInstance] endLoadingCargos:self.cargos];
        }
    }];
}

@end
