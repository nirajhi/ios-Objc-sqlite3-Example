//
//  ViewController.m
//  Sqllite3Demo
//
//  Created by Niraj Hirachan on 5/18/16.
//  Copyright © 2016 Niraj Hirachan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()


@end

@implementation ViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)
//nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)saveData:(id)sender{
    BOOL success = NO;
    NSLog(@"The success is %x", success);

    NSString *alertString = @"Data Insertion failed";
    if (self.regNoTextField.text.length>0 && self.nameTextField.text.length>0 && self.departmentTextField.text.length>0 && self.yearTextField.text.length>0 ){
        NSLog(@"The success is %x", success);
        //print [success];
        success = [[DBManager getSharedInstance]saveData:
                   self.regNoTextField.text name:self.nameTextField.text department:
                   self.departmentTextField.text year:self.yearTextField.text];
    }
    else{
        alertString = @"Enter all fields";
    }
    if (success == NO) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:
                              alertString message:nil
                                                      delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

-(IBAction)findData:(id)sender{
    NSArray *data = [[DBManager getSharedInstance]findByRegistrationNumber:
                     self.findByRegNumTextField.text];
    if (data == nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:
                              @"Data not found" message:nil delegate:nil cancelButtonTitle:
                              @"OK" otherButtonTitles:nil];
        [alert show];
        self.regNoTextField.text = @"";
        self.nameTextField.text =@"";
        self.departmentTextField.text = @"";
        self.yearTextField.text =@"";
    }
    else{
        self.regNoTextField.text = self.findByRegNumTextField.text;
        self.nameTextField.text =[data objectAtIndex:0];
        self.departmentTextField.text = [data objectAtIndex:1];
        self.yearTextField.text =[data objectAtIndex:2];
        NSLog(@"Succesfully data retrieved");
    }
}

#pragma mark - Text field delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.myScrollView setFrame:CGRectMake(10, 50, 300, 200)];
    [self.myScrollView setContentSize:CGSizeMake(300, 350)];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.myScrollView setFrame:CGRectMake(10, 50, 300, 350)];
    
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

@end
