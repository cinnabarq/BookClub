//
//  FilloutViewController.m
//  BookClub
//
//  Created by zhenduo zhu on 4/1/15.
//  Copyright (c) 2015 zhenduo zhu. All rights reserved.
//

#import "FilloutViewController.h"
#import "Book.h"

@interface FilloutViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (nonatomic) Book *book;

@end

@implementation FilloutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleTextField becomeFirstResponder];
    self.titleTextField.placeholder = @"Enter title";
    self.authorTextField.placeholder = @"Enter author";
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![textField isEqual:@""]) {
        if (textField == self.titleTextField) {
            self.book = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Book class]) inManagedObjectContext:self.friend.managedObjectContext];
            self.book.name = textField.text;
            [self.authorTextField becomeFirstResponder];
        } else if (textField == self.authorTextField) {
            self.book.author = textField.text;
        }
        [self.friend addBooksObject:self.book];
        [self.friend.managedObjectContext save:nil];
    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.authorTextField && !self.titleTextField.text.length) {
        return NO;
    }
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
