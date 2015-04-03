//
//  ReadersViewController.m
//  BookClub
//
//  Created by zhenduo zhu on 4/1/15.
//  Copyright (c) 2015 zhenduo zhu. All rights reserved.
//


#import "ReadersViewController.h"
#import "ReadersDownloader.h"
#import "Reader.h"
#import "Friend.h"

@interface ReadersViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSArray *readers;
@property (nonatomic) NSMutableArray *isChecked;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ReadersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.isChecked = [NSMutableArray new];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if (![userDefaults objectForKey:@"hasSavedReaderList"]) {
        [ReadersDownloader downloadReadersWithCompletion:^(NSArray *readerArray)
        {

            NSMutableArray *tempReaders = [NSMutableArray new];
            for (NSString *name in readerArray) {
                Reader *reader = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Reader class]) inManagedObjectContext:self.moc];
                reader.name = name;
                [tempReaders addObject:reader];
            }
            self.readers = tempReaders.copy;
            [self.moc save:nil];
            [userDefaults setObject:@YES forKey:@"hasSavedReaderList"];
            [userDefaults synchronize];
            
            [self.tableView reloadData];
           
        }];
    } else {
        [self loadReaders];
    }
}

-(void)loadReaders
{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([Reader class])];
    self.readers = [self.moc executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.readers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReaderCell"];
    cell.textLabel.text = [self.readers[indexPath.row] name];
    Reader *reader = self.readers[indexPath.row];
    NSInteger index = [self.friends indexOfObjectPassingTest:^BOOL(Friend *obj, NSUInteger idx, BOOL *stop) {
        return [obj.name isEqualToString:reader.name];
    }];
    if (index != NSNotFound) {
        self.isChecked[indexPath.row] = @YES;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.isChecked[indexPath.row] = @NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Reader *reader = self.readers[indexPath.row];
    if ([self.isChecked[indexPath.row] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        NSInteger index = [self.friends indexOfObjectPassingTest:^BOOL(Friend *obj, NSUInteger idx, BOOL *stop) {
            return [obj.name isEqualToString:reader.name];
        }];
        [self.moc deleteObject:self.friends[index]];
        [self.friends removeObjectAtIndex:index];
        [self.moc save:nil];
        self.isChecked[indexPath.row] = @NO;
    } else {
        Friend *friend = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Friend class]) inManagedObjectContext:self.moc];
        friend.name = reader.name;
        [self.friends addObject:friend];
        [self.moc save:nil];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.isChecked[indexPath.row] = @YES;
    }

}


//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//     UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    Reader *reader = self.readers[indexPath.row];
//    if ([self.isChecked[indexPath.row] boolValue]) {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        NSInteger index = [self.friends indexOfObjectPassingTest:^BOOL(Friend *obj, NSUInteger idx, BOOL *stop) {
//            return [obj.name isEqualToString:reader.name];
//        }];
//        [self.moc deleteObject:self.friends[index]];
//        [self.friends removeObjectAtIndex:index];
//        [self.moc save:nil];
//        self.isChecked[indexPath.row] = @NO;
//    } else {
//        Friend *friend = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Friend class]) inManagedObjectContext:self.moc];
//        friend.name = reader.name;
//        [self.friends addObject:friend];
//        [self.moc save:nil];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        self.isChecked[indexPath.row] = @YES;
//    }
//}
//




@end
