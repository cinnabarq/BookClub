//
//  ReadersDownloader.h
//  BookClub
//
//  Created by zhenduo zhu on 4/1/15.
//  Copyright (c) 2015 zhenduo zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadersDownloader : NSObject

+(void)downloadReadersWithCompletion:(void (^)(NSArray *))complete;

@end
