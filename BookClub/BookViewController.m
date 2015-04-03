//
//  BookViewController.m
//  BookClub
//
//  Created by zhenduo zhu on 4/2/15.
//  Copyright (c) 2015 zhenduo zhu. All rights reserved.
//

#import "BookViewController.h"
#import "Comment.h"


@interface BookViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSArray *comments;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.book.name;
    [self loadComments];
}

-(void)loadComments
{
    self.comments = [self.book.comments allObjects];
    [self.tableView reloadData];
}

- (IBAction)onCommentButtonTapped:(UIButton *)sender
{
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add a comment:" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter comment";
    }];
    
     UIAlertAction *okAction = [UIAlertAction
                                actionWithTitle:@"Okay"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                {
                                    Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Comment class]) inManagedObjectContext:self.book.managedObjectContext];
                                    comment.content = ((UITextField *)alertController.textFields[0]).text;
                                    [self.book addCommentsObject:comment];
                                    [self.book.managedObjectContext save:nil];
                                    [self loadComments];
                                }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.book.comments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    cell.textLabel.text = [self.comments[indexPath.row] content];
    return cell;
}


@end
