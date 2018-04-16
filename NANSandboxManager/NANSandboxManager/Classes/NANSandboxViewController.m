//
//  NANSandboxViewController.m
//  NANSandboxManager
//
//  Created by nan on 2018/4/16.
//

#import "NANSandboxViewController.h"
#include "NANSandboxManager.h"

typedef NS_ENUM(NSInteger, NANFSViewControllerAppearType) {
    NANFSViewControllerAppearTypePush,
    NANFSViewControllerAppearTypePresent
};

@interface NANSandboxViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NANFSViewControllerAppearType appearType;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NANFileList *fileList;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, assign) CGSize pathStringSize;

@property (nonatomic, copy) NSString *currentPath;

@end

@implementation NANSandboxViewController

+ (NANSandboxViewController *)presentFSViewControllerFrom:(UIViewController *)fromVC filePath:(NSString *)path
{
    NANSandboxViewController *fsVC = nil;
    if (fromVC) {
        fsVC = [[self alloc] init];
        fsVC.currentPath = path;
        fsVC.appearType = NANFSViewControllerAppearTypePresent;
        if (!path || !path.length) {
            fsVC.title = @"根目录";
        } else {
            fsVC.title = [path lastPathComponent];
        }
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:fsVC];
        [fromVC presentViewController:navi animated:YES completion:nil];
    }
    return fsVC;
}

+ (NANSandboxViewController *)pushFSViewControllerFrom:(UIViewController *)fromVC filePath:(NSString *)path
{
    __block NANSandboxViewController *fsVC = nil;
    
    void (^pushBlock)(UINavigationController *navi) = ^(UINavigationController *navi) {
        fsVC = [[self alloc] init];
        fsVC.currentPath = path;
        fsVC.appearType = NANFSViewControllerAppearTypePush;
        if (!path || !path.length) {
            fsVC.title = @"根目录";
        } else {
            fsVC.title = [path lastPathComponent];
        }
        [navi pushViewController:fsVC animated:YES];
    };
    
    if ([fromVC isKindOfClass:[UINavigationController class]]) {
        pushBlock((UINavigationController *)fromVC);
    } else if (fromVC.navigationController) {
        pushBlock(fromVC.navigationController);
    }
    return fsVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.selectedIndexPath) {
        [self.tableView deselectRowAtIndexPath:self.selectedIndexPath animated:YES];
        self.selectedIndexPath = nil;
    }
}

- (void)setupSubviews
{
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [backBtn setTitle:@"back" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToLastVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    _tableView = tableView;
}

- (void)backToLastVC
{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    if (self.appearType == NANFSViewControllerAppearTypePresent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - tableView dataSource && delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fileList.fileList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"NANFSTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NANFileInfoItem *fileItem = [self.fileList.fileList objectAtIndex:indexPath.row];
    cell.textLabel.text = fileItem.title;
    if (fileItem.isDirector) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NANFileInfoItem *fileItem = [self.fileList.fileList objectAtIndex:indexPath.row];
    if (fileItem.isDirector) {
        [NANSandboxViewController pushFSViewControllerFrom:self.navigationController filePath:fileItem.path];
        self.selectedIndexPath = indexPath;
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, self.pathStringSize.height)];
        
        UILabel *pathLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - self.pathStringSize.width) * 0.5, 0, self.pathStringSize.width, self.pathStringSize.height)];
        pathLabel.backgroundColor = [UIColor clearColor];
        pathLabel.textColor = [UIColor blackColor];
        pathLabel.textAlignment = NSTextAlignmentCenter;
        pathLabel.font = [UIFont systemFontOfSize:12];
        pathLabel.numberOfLines = 0;
        pathLabel.text = self.currentPath;
        [headerView addSubview:pathLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(pathLabel.frame), CGRectGetMaxY(pathLabel.frame) - 1, pathLabel.frame.size.width, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:lineView];
        
        return headerView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.pathStringSize.height;
    }
    return CGFLOAT_MIN;
}

#pragma mark - lazy load

- (NANFileList *)fileList
{
    if (!_fileList) {
        _fileList = [NANSandboxManager fileListForPath:self.currentPath];
    }
    return _fileList;
}

- (NSString *)currentPath
{
    return _currentPath ? : [NANSandboxManager rootFilePath];
}

- (CGSize)pathStringSize
{
    if (CGSizeEqualToSize(_pathStringSize, CGSizeZero)) {
        _pathStringSize = [self.currentPath boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size;
        
    }
    return _pathStringSize;
}

@end
