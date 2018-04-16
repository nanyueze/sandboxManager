//
//  NANSandboxViewController.h
//  NANSandboxManager
//
//  Created by nan on 2018/4/16.
//

#import <UIKit/UIKit.h>

@interface NANSandboxViewController : UIViewController

// 点击导航栏返回按钮，调用该block
@property (nonatomic, copy) dispatch_block_t dismissBlock;

+ (NANSandboxViewController *)presentFSViewControllerFrom:(UIViewController *)fromVC filePath:(NSString *)path;
+ (NANSandboxViewController *)pushFSViewControllerFrom:(UIViewController *)fromVC filePath:(NSString *)path;

@end
