//
//  ViewController.m
//  EmptyLegs
//
//  Created by Mohamed Boumansour on 25/06/15.
//  Copyright (c) 2015 explovia. All rights reserved.
//

#import "ELMainViewController.h"
#import "ELCargoViewController.h"
#import "ELCargoTableViewCell.h"
#import "ELContactViewController.h"
#import "ELDriverViewController.h"


@interface ELMainViewController ()

@property UIButton *cargosButton;
@property UIButton *driversButton;

@property UITableView *tableView;
@property NSMutableArray *tableData;

@property UIButton *addButton;

@property BOOL cargoMode;


@property ELCargoViewController *cargoViewController;
@property ELDriverViewController *driverViewController;
@property UIImageView *firstAnimation;

@property ELContactViewController *contactViewController ;

@end



@implementation ELMainViewController

+ (NSArray *)getAnimationImages{
    
    NSArray *imageNames     = [NSArray arrayWithObjects:@"empty_leg_logo_03a", @"empty_leg_logo_03b", @"empty_leg_logo_03c", @"empty_leg_logo_03d", @"empty_leg_logo_03e", @"empty_leg_logo_03f", nil];
    NSMutableArray *images  = [NSMutableArray new];
    for(NSString *image in imageNames)
        if([UIImage imageNamed:image])    [images addObject:[UIImage imageNamed:image]];
    
    return images;
}

static ELMainViewController *sharedInstance;
+ (ELMainViewController *) getSharedInstance{
    
    return sharedInstance;
}


- (void)viewDidLoad {
    
    self.navigationController.navigationBarHidden = YES;
    
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    statusBarView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.view addSubview:statusBarView];
    
    [super viewDidLoad];
    
    sharedInstance = self;
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = SPECIAL_DARK;
    
    NSArray *images = [ELMainViewController getAnimationImages];
    self.firstAnimation                 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.firstAnimation.animationImages = images;
    self.firstAnimation.image           = images.lastObject;
    self.firstAnimation.animationDuration       = 1.1;
    self.firstAnimation.animationRepeatCount    = 100;
    [self.firstAnimation startAnimating];
    
    
    
    self.cargosButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 40, 120, 40)];
    self.cargosButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cargosButton.layer.borderWidth = 1;
    self.cargosButton.backgroundColor = [UIColor whiteColor];
    [self.cargosButton setTitleColor:[UIColor blackColor] forState:0];
    [self.cargosButton setTitle:@"cargo" forState:0];
    [self.cargosButton.titleLabel setFont:[UIFont fontWithName:@"SourceCodePro-Bold" size:20]];
    [self.cargosButton addTarget:self action:@selector(cargosBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cargosButton];
    
    self.driversButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 40, 120, 40)];
    self.driversButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.driversButton.layer.borderWidth = 1;
    self.driversButton.backgroundColor = [UIColor blackColor];
    [self.driversButton setTitleColor:[UIColor whiteColor] forState:0];
    [self.driversButton setTitle:@"drivers" forState:0];
    [self.driversButton.titleLabel setFont:[UIFont fontWithName:@"SourceCodePro-Bold" size:20]];
    [self.driversButton addTarget:self action:@selector(driversBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.driversButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, self.view.frame.size.height-180)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(140, self.view.frame.size.height-60, 42, 42)];
    [self.addButton setImage:[UIImage imageNamed:@"empty_leg_plus"] forState:0];
    [self.addButton addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    
    self.cargoMode = YES;
    
    [self.view addSubview:self.firstAnimation];
}

- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
}

- (void) endLoadingCargos{
    
    if(self.cargoMode)
        self.tableData = [ELDataController getSharedInstance].cargos;
    else{
        self.tableData = [ELDataController getSharedInstance].drivers;
    }
    [self.firstAnimation stopAnimating];
    [self.firstAnimation removeFromSuperview];
    [self.tableView reloadData];
}


- (void) cargosBtnClicked:(id)sender{
    
    self.cargoMode = YES;
    
    self.cargosButton.backgroundColor = [UIColor whiteColor];
    [self.cargosButton setTitleColor:[UIColor blackColor] forState:0];
    
    self.driversButton.backgroundColor = [UIColor blackColor];
    [self.driversButton setTitleColor:[UIColor whiteColor] forState:0];
    
    [self.cargoViewController.view removeFromSuperview];
    [self.driverViewController.view removeFromSuperview];
    
    self.tableData = [ELDataController getSharedInstance].cargos;
    [self.tableView reloadData];
}

- (void) driversBtnClicked:(id)sender{
    
    self.cargoMode = NO;
    
    self.cargosButton.backgroundColor = [UIColor blackColor];
    [self.cargosButton setTitleColor:[UIColor whiteColor] forState:0];
    
    self.driversButton.backgroundColor = [UIColor whiteColor];
    [self.driversButton setTitleColor:[UIColor blackColor] forState:0];
    
    [self.cargoViewController.view removeFromSuperview];
    [self.driverViewController.view removeFromSuperview];
    
    self.tableData = [ELDataController getSharedInstance].drivers;
    [self.tableView reloadData];
}

- (void) addBtnClicked:(id)sender{
    
    //if(self.cargoMode){
        self.cargoViewController = [ELCargoViewController new];
        CGRect frame = self.cargoViewController.view.frame;
        frame.origin.y += 80;
        self.cargoViewController.view.frame = frame;
        self.cargoViewController.cargoMode = self.cargoMode;
        [self.view addSubview:self.cargoViewController.view];
        
    /*}else{
        self.driverViewController = [ELDriverViewController new];
        CGRect frame = self.driverViewController.view.frame;
        frame.origin.y += 80;
        self.driverViewController.view.frame = frame;
        [self.view addSubview:self.driverViewController.view];
    }*/
}





#pragma mark - Table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CargoCell";
    
    ELCargoTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ){
        cell            = [[ELCargoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    [cell setData:[self.tableData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ELCargoTableViewCell *cell      = [[ELCargoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"heightCell"];
    return [cell setData:[self.tableData objectAtIndex:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void) contactBtnClicked:(id)sender{
    
     self.contactViewController = [ELContactViewController new];
    
    ELCargoTableViewCell *cell = ((UIButton *)sender).superview;
    PFObject *object = [self.tableData objectAtIndex:cell.tag];
    
    NSMutableDictionary *contact = [NSMutableDictionary new];
    [contact setObject:object[@"phone"] forKey:@"phone"];
    [contact setObject:object[@"email"] forKey:@"email"];
    self.contactViewController.contact = contact;
    
    [self.view addSubview:self.contactViewController.view];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
