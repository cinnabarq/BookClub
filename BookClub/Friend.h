//
//  Friend.h
//  BookClub
//
//  Created by zhenduo zhu on 4/1/15.
//  Copyright (c) 2015 zhenduo zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Reader;

@interface Friend : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *readers;
@property (nonatomic, retain) NSSet *books;
@end

@interface Friend (CoreDataGeneratedAccessors)

- (void)addReadersObject:(Reader *)value;
- (void)removeReadersObject:(Reader *)value;
- (void)addReaders:(NSSet *)values;
- (void)removeReaders:(NSSet *)values;

- (void)addBooksObject:(NSManagedObject *)value;
- (void)removeBooksObject:(NSManagedObject *)value;
- (void)addBooks:(NSSet *)values;
- (void)removeBooks:(NSSet *)values;

@end
