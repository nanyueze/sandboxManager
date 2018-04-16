//
//  NANSandboxManager.m
//  NANSandboxManager
//
//  Created by nan on 2018/4/16.
//

#import "NANSandboxManager.h"
#import "NANSandboxViewController.h"

UIWindow *_entranceWindow = nil;

@implementation NANSandboxManager

+ (void)showSandboxEntranceWithOffset:(CGPoint)offset
{
    UIApplication *app = [UIApplication sharedApplication];
    CGRect statusBarFrame = app.statusBarFrame;
    
    CGFloat windowWidth = 60;
    CGFloat windowHeight = statusBarFrame.size.height;
    
    UIWindow *entranceWindow = [[UIWindow alloc] initWithFrame:CGRectMake(offset.x, offset.y, windowWidth, windowHeight)];
    entranceWindow.windowLevel = UIWindowLevelStatusBar;
    _entranceWindow = entranceWindow;
    
    UIButton *entranceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, windowWidth, windowHeight)];
    [entranceBtn setTitle:@"sandbox" forState:UIControlStateNormal];
    [entranceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    entranceBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [entranceBtn addTarget:self action:@selector(showFileSystemViewController) forControlEvents:UIControlEventTouchUpInside];
    [entranceWindow addSubview:entranceBtn];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [app.keyWindow addSubview:entranceWindow];
        entranceWindow.hidden = NO;
    });
}

+ (void)showFileSystemViewController
{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    NANSandboxViewController *fsVC = [NANSandboxViewController presentFSViewControllerFrom:rootVC filePath:nil];
    fsVC.dismissBlock = ^{
        _entranceWindow.hidden = NO;
    };
    _entranceWindow.hidden = YES;
}

+ (NANFileList *)fileListForPath:(NSString *)path
{
    if (!path || !path.length) {
        return nil;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *rootList = [fileManager contentsOfDirectoryAtPath:path error:&error];
    
    NSMutableArray *allFileItems = [NSMutableArray array];
    for (NSString *fileName in rootList) {
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        NANFileInfoItem *fileItem = [self fileInfoItemForPath:filePath];
        if (fileItem) {
            [allFileItems addObject:fileItem];
        }
    }
    if (allFileItems.count) {
        NANFileList *fileList = [[NANFileList alloc] init];
        fileList.fileList = [allFileItems copy];
        return fileList;
    }
    
    return nil;
}

+ (NANFileInfoItem *)fileInfoItemForPath:(NSString *)path
{
    if (!path || !path.length) {
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirector = NO;
    BOOL fileExist = [fileManager fileExistsAtPath:path isDirectory:&isDirector];
    if (!fileExist) {
        return nil;
    }
    NANFileInfoItem *fileInfoItem = [[NANFileInfoItem alloc] init];
    fileInfoItem.path = path;
    fileInfoItem.title = [path lastPathComponent];
    fileInfoItem.isDirector = isDirector;
    
    return fileInfoItem;
}

+ (NSString *)rootFilePath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return [path stringByDeletingLastPathComponent];
}

@end
