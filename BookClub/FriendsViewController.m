//
//  ViewController.m
//  BookClub
//
//  Created by zhenduo zhu on 4/1/15.
//  Copyright (c) 2015 zhenduo zhu. All rights reserved.
//

#import "FriendsViewController.h"
#import "AppDelegate.h"
#import "Friend.h"
#import "ReadersViewController.h"
#import "ProfileViewController.h"

@interface FriendsViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic) NSManagedObjectContext *moc;

@property (nonatomic) NSMutableArray *friends;
@property (nonatomic) NSMutableArray *sortedFriends;
@property (nonatomic) NSMutableArray *filtedFriends;
@property (nonatomic) BOOL isSortAscending;
@property (nonatomic) NSString *filterString;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 44.0)];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    searchBar.backgroundImage = [UIImage new];
    
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 44.0)];
    searchBarView.autoresizingMask = 0;
    searchBar.delegate = self;
    [searchBarView addSubview:searchBar];
    self.navigationItem.titleView = searchBarView;
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appdelegate.managedObjectContext;
    self.isSortAscending = YES;
    [self loadFriends];

}

-(void)viewWillAppear:(BOOL)animated
{
    [self setDisplayOrderWithSelectedSegment];
}

-(void)loadFriends
{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([Friend class])];
    if (self.filterString.length) {
        request.predicate = [NSPredicate predicateWithFormat:@"(name contains[c] %@)", self.filterString];
    } else {
        request.predicate = nil;
    }

    self.friends = [self.moc executeFetchRequest:request error:nil].mutableCopy;
    
    NSSortDescriptor *descriptor =  [NSSortDescriptor sortDescriptorWithKey:@"books.@count" ascending:self.isSortAscending];
   // NSSortDescriptor *descriptor = [[NSSortDescriptor alloc]initWithKey:@"books.@count" ascending:self.isSortAscending];
    
    self.sortedFriends = [self.friends sortedArrayUsingDescriptors:@[descriptor]].mutableCopy;
    self.filtedFriends = self.sortedFriends;
    [self.tableView reloadData];
}


- (IBAction)onSegmentsTapped:(UISegmentedControl *)sender
{
    [self setDisplayOrderWithSelectedSegment];
}

-(void)setDisplayOrderWithSelectedSegment
{
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            self.isSortAscending = YES;
            [self loadFriends];
            break;
        case 1:
            self.isSortAscending = NO;
            [self loadFriends];
            break;
        default:
            self.isSortAscending = YES;
            [self loadFriends];
            break;
    } 
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.filterString = searchText;
    [self loadFriends];
//    if (![searchText isEqualToString:@""]) {
//        NSMutableArray *tempFiltedArray = [NSMutableArray new];
//        for (Friend *friend in self.sortedFriends) {
//            if ([friend.name localizedCaseInsensitiveContainsString:searchText]) {
//                [tempFiltedArray addObject:friend];
//            }
//        }
//        self.filtedFriends = tempFiltedArray;
//        [self.tableView reloadData];
//    } else {
//        self.filtedFriends = self.sortedFriends;
//        [self.tableView reloadData];
//    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filtedFriends.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    cell.textLabel.text = [self.filtedFriends[indexPath.row] name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%li books",[[self.filtedFriends[indexPath.row] books]count]];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ReadersSegue"]) {
        ReadersViewController *readerVC = segue.destinationViewController;
        readerVC.friends = self.filtedFriends;
        readerVC.moc = self.moc;
    } else if ([segue.identifier isEqualToString:@"ProfileSegue"]) {
        ProfileViewController *profileVC = segue.destinationViewController;
        profileVC.friend = self.filtedFriends[[[self.tableView indexPathForSelectedRow] row]];
    }
}

@end
