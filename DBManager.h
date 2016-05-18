//
//  DBManager.h
//  Sqllite3Demo
//
//  Created by Niraj Hirachan on 5/18/16.
//  Copyright © 2016 Niraj Hirachan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL)saveData:(NSString*)registrationNumber name:(NSString*)name
     department:(NSString*)department year:(NSString*)year;
-(NSArray* )findByRegistrationNumber: (NSString *)registerNumber;


@end
