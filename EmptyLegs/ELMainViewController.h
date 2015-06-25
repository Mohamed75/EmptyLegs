//
//  ViewController.h
//  EmptyLegs
//
//  Created by Mohamed Boumansour on 25/06/15.
//  Copyright (c) 2015 explovia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELMainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

+ (ELMainViewController *) getSharedInstance;


- (void) endLoadingCargos:(NSMutableArray *)cargos;

@end

