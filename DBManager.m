//
//  DBManager.m
//  Sqllite3Demo
//
//  Created by Niraj Hirachan on 5/18/16.
//  Copyright © 2016 Niraj Hirachan. All rights reserved.
//

#import "DBManager.h"
static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager*)getSharedInstance{
    if(!sharedInstance){
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}


-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *applicationSupportDirectory = [paths firstObject];
    
    
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths.firstObject;
    //docsDir = [dirPaths]; //or  //   //gives correct directory of our app Library Folder.
    
    NSLog(@"applicationSupportDirectory: '%@'", docsDir);
    
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"student.db"]];
    
    
    BOOL isSuccess = YES;
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "create table if not exists studentsDetail (regno integer primary key, name text, department text, year text)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;

} //end of createDB


- (BOOL) saveData:(NSString*)registerNumber name:(NSString*)name
       department:(NSString*)department year:(NSString*)year;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"insert into studentsDetail (regno,name, department,year) values (\"%d\",\"%@\", \"%@\", \"%@\");",(int)[registerNumber integerValue],name, department, year];
        const char *insert_stmt = [insertSQL UTF8String];
        
        NSLog(@"%s",insert_stmt);
        sqlite3_prepare_v2(database,insert_stmt,-1,&statement,NULL);//Pointer to unused portion of zSql
     //   sqlite3_prepare_v2(database,// Database handle
           //                insert_stmt, //* SQL statement, UTF-8 encoded */
              //             -1, //Maximum length of zSql in bytes.
            //               &statement, // OUT Statement handle */
                //           NULL);//Pointer to unused portion of zSql
        
            if (sqlite3_step(statement) == SQLITE_DONE){
                    return YES;
                }
            else{
                    return NO;
                }
      sqlite3_reset(statement);
    }
    return NO;
}


- (NSArray*) findByRegistrationNumber:(NSString*)registerNumber
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"select name, department, year from studentsDetail where regno=\"%@\"",registerNumber];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)// sqlite3_step() has another row ready
            {
                NSString *name = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:name];
                NSString *department = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:department];
                NSString *year = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:year];
                return resultArray;
            }
            else{
                NSLog(@"Not found");
                return nil;
            }
            //sqlite3_reset(statement);
        }
    }
    return nil;
}


@end
