//
//  ProfileViewController.m
//  BookClub
//
//  Created by zhenduo zhu on 4/1/15.
//  Copyright (c) 2015 zhenduo zhu. All rights reserved.
//

#import "ProfileViewController.h"
#import "FilloutViewController.h"
#import "BookViewController.h"
#import "Book.h"

@interface ProfileViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *books;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.friend.name;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadBooks];
}

-(void)loadBooks
{
    self.books = [self.friend.books allObjects];
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FilloutSegue"]) {
        FilloutViewController *fillVC = segue.destinationViewController;
        fillVC.friend = self.friend;
    } else if ([segue.identifier isEqualToString:@"BookSegue"]) {
        BookViewController *bookVC = segue.destinationViewController;
        bookVC.book = self.books[[[self.tableView indexPathForSelectedRow] row]];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.books.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell"];
    cell.textLabel.text = [self.books[indexPath.row] name];
    cell.detailTextLabel.text = [self.books[indexPath.row] author];
    return cell;
}



@end
