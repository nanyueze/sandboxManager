//
//  NANSandboxManager.h
//  NANSandboxManager
//
//  Created by nan on 2018/4/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NANFileInfoItem.h"

@interface NANSandboxManager : NSObject

/*
 * @desc: 展示默认的入口
 * @params: CGPointZero位于屏幕左上角，正值往右下方偏移
 */
+ (void)showSandboxEntranceWithOffset:(CGPoint)offset;

+ (NANFileList *)fileListForPath:(NSString *)path;
+ (NSString *)rootFilePath;

@end
