//
//  ViewController.h
//  Sqllite3Demo
//
//  Created by Niraj Hirachan on 5/18/16.
//  Copyright © 2016 Niraj Hirachan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *findByRegNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *regNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *departmentTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;


- (IBAction)findData:(id)sender;

- (IBAction)saveData:(id)sender;

@end

