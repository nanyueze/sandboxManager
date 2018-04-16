//
//  NANFileInfoItem.h
//  NANSandboxManager
//
//  Created by nan on 2018/4/16.
//

#import <Foundation/Foundation.h>

@interface NANFileInfoItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSArray<NANFileInfoItem *> *subfiles;
@property (nonatomic, assign) BOOL isDirector;

@end


@interface NANFileList : NSObject

@property (nonatomic, copy) NSArray<NANFileInfoItem *> *fileList;

@end
