//
//  ELViewController.m
//  EmptyLegs
//
//  Created by Mohamed Boumansour on 25/06/15.
//  Copyright (c) 2015 explovia. All rights reserved.
//

#import "ELCargoViewController.h"
#import "ELCreationTableViewCell.h"

@interface ELCargoViewController ()

@property UITableView *tableView;

@property UIButton *doneButton;

@property BOOL keyboardShown;

@property NSMutableArray *saveData;

@property UIDatePicker  *pickerStart;
@property UIDatePicker  *pickerEnd;

@property NSDateFormatter *dateFormatter;

@end



@implementation ELCargoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = SPECIAL_DARK;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 24, 320, self.view.frame.size.height-200)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(40, self.view.frame.size.height-140, 240, 42)];
    self.doneButton.backgroundColor = [UIColor whiteColor];
    [self.doneButton setTitle:@"done" forState:0];
    [self.doneButton setTitleColor:[UIColor blackColor] forState:0];
    [self.doneButton.titleLabel setFont:[UIFont fontWithName:@"SourceCodePro-Bold" size:18]];
    [self.doneButton addTarget:self action:@selector(doneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    self.saveData = [NSMutableArray new];
    for(int i = 0; i < 6; i++)
        [self.saveData addObject:@""];
    
    self.pickerStart = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 250, 200)];
    self.pickerStart.backgroundColor = [UIColor whiteColor];
    [self.pickerStart addTarget:self action:@selector(dateStartIsChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.pickerEnd = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 250, 200)];
    self.pickerEnd.backgroundColor = [UIColor whiteColor];
    [self.pickerEnd addTarget:self action:@selector(dateEndIsChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.dateFormatter = [NSDateFormatter new];
    self.dateFormatter.dateFormat        = @"dd hh:mm";
}

- (void)dateStartIsChanged:(id)sender{
    
    ELCreationTableViewCell *startCell = (ELCreationTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    startCell.textField.text = [self.dateFormatter stringFromDate:self.pickerStart.date];
}

- (void)dateEndIsChanged:(id)sender{
    
    ELCreationTableViewCell *endCell = (ELCreationTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    endCell.textField.text = [self.dateFormatter stringFromDate:self.pickerEnd.date];
}





- (void) hideKeyBoard{
    [self.view endEditing:YES];
    
    if (!self.keyboardShown)
        return;
    
    self.keyboardShown = NO;
    
    
    CGRect viewFrame = self.tableView.frame;
    viewFrame.size.height += KEYBOARD_HEIGHT-80;
    
    
    [UIView animateWithDuration:.2 animations:^(){
        
        self.tableView.frame = viewFrame;
        
    }completion:^(BOOL finish){}];
}


- (void) doneBtnClicked:(id)sender{
    
    for(NSString *text in self.saveData){
        if(text && [text isEqualToString:@""]){
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"please fill all the fields" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alertView show];
            
            return;
        }
    }
    
    [SVProgressHUD show];
    
    NSNumber *size = [NSNumber numberWithLong:((NSString *)self.saveData[0]).intValue];
    if(size == 0){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"please enter a correct size" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alertView show];
    }
    
    PFObject *cargoObject = [PFObject objectWithClassName:@"Cargo"];
    cargoObject[@"size"] = size;
    cargoObject[@"description"] = self.saveData[1];
    cargoObject[@"from"] = self.saveData[2];
    cargoObject[@"to"] = self.saveData[3];
    cargoObject[@"pickedAt"] = self.pickerStart.date;
    cargoObject[@"arriveAt"] = self.pickerEnd.date;
    [cargoObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [SVProgressHUD dismiss];
        [self.view removeFromSuperview];
    }];
}


- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if (self.keyboardShown)
        return;
    
    self.keyboardShown = YES;
    
    
    CGRect viewFrame = self.tableView.frame;
    viewFrame.size.height -= KEYBOARD_HEIGHT-80;
    
    
    [UIView animateWithDuration:.2 animations:^(){
        
        self.tableView.frame = viewFrame;
        
    }completion:^(BOOL finish){}];
}



#pragma mark - Table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CreateCell";
    
    ELCreationTableViewCell *cell  = [[ELCreationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.delegate = self;
    cell.tag = indexPath.row;
    
    cell.textField.keyboardType = UIKeyboardTypeDefault;
    
    if(indexPath.row == 0){
        cell.title.text = @"I need m2";
        cell.textField.placeholder = @"cargo size";
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if(indexPath.row == 1){
        cell.title.text = @"of";
        cell.textField.placeholder = @"description";
    }
    
    if(indexPath.row == 2){
        cell.title.text = @"taken from";
        cell.textField.placeholder = @"location";
    }
    
    if(indexPath.row == 3){
        cell.title.text = @"to";
        cell.textField.placeholder = @"location";
    }
    
    if(indexPath.row == 4){
        cell.title.text = @"picked by";
        cell.textField.placeholder = @"time";
        cell.textField.inputView = self.pickerStart;
    }
    
    if(indexPath.row == 5){
        cell.title.text = @"arriving by";
        cell.textField.placeholder = @"time";
        cell.textField.inputView = self.pickerEnd;
    }
    
    cell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:cell.textField.placeholder attributes:@{NSForegroundColorAttributeName: SPECIAL_GREY}];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self saveAllFields];
    [self hideKeyBoard];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row%2 == 0)
        return 60;
    
    return 80;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self saveAllFields];
    long index = ((ELCreationTableViewCell *)textField.superview).tag;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
     atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    [self saveAllFields];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self saveAllFields];
    long index = ((ELCreationTableViewCell *)textField.superview).tag;
    if(index < 5){
        ELCreationTableViewCell *nextCell = (ELCreationTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index+1 inSection:0]];
        [nextCell.textField becomeFirstResponder];
    }
    else
        [self doneBtnClicked:nil];
    return YES;
}

- (void) saveAllFields{
    
    for(ELCreationTableViewCell *cell in self.tableView.visibleCells){
        if(cell.textField && ![cell.textField.text isEqualToString:@""])
            [self.saveData replaceObjectAtIndex:cell.tag withObject:cell.textField.text];
    }
}



@end
