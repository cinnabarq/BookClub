//
//  ReadersViewController.h
//  BookClub
//
//  Created by zhenduo zhu on 4/1/15.
//  Copyright (c) 2015 zhenduo zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ReadersViewController : UIViewController

@property (nonatomic) NSMutableArray *friends;
@property (nonatomic) NSMutableArray *friendsToAdd;
@property (nonatomic) NSMutableArray *friendsToRemove;
@property (nonatomic) NSManagedObjectContext *moc;

@end
