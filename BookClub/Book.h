//
//  Book.h
//  BookClub
//
//  Created by zhenduo zhu on 4/2/15.
//  Copyright (c) 2015 zhenduo zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Friend, Reader;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSSet *friends;
@property (nonatomic, retain) NSSet *readers;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addFriendsObject:(Friend *)value;
- (void)removeFriendsObject:(Friend *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

- (void)addReadersObject:(Reader *)value;
- (void)removeReadersObject:(Reader *)value;
- (void)addReaders:(NSSet *)values;
- (void)removeReaders:(NSSet *)values;

@end
