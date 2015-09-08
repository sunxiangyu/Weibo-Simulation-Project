//
//  WBComposeViewController.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/6.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "WBTextVIew.h"
#import "WBComposeToolbar.h"
#import "WBComposePhotosView.h"
#import "WBEmotionKeyboard.h"
#import "WBEmotion.h"
#import "WBEmotionTextView.h"

@interface WBComposeViewController()<UITextViewDelegate, WBComposeToolbarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) WBEmotionTextView *textView;

@property (nonatomic, weak) WBComposeToolbar *toolbar;

@property (nonatomic, weak) WBComposePhotosView *photosView;

@property (nonatomic, strong) WBEmotionKeyboard *emotionKeyboard;

@property (nonatomic, assign) BOOL switchingKeyboard;
@end

@implementation WBComposeViewController

- (WBEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[WBEmotionKeyboard alloc] init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 230;
    }
    return _emotionKeyboard;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolbar];
    
    [self setupPhotosView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [WBAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.numberOfLines = 0;
        titleView.y = 50;
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
        
    } else {
        self.title = prefix;
    }
}

- (void)setupTextView
{
    WBEmotionTextView *textView = [[WBEmotionTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享新鲜事...";
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSeclect:) name:WBEmotionDidSelectNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect) name:WBEmotionDidDeleteNotification object:nil];
    
}

- (void)setupToolbar
{
    WBComposeToolbar *toolbar = [[WBComposeToolbar alloc] init];
    toolbar.height = 37;
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
}

- (void)setupPhotosView
{
    WBComposePhotosView *photosView = [[WBComposePhotosView alloc] init];
    photosView.height = self.view.height;
    photosView.width = self.view.width;
    photosView.y = 150;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

#pragma mark - 监听方法

- (void)emotionDidSeclect:(NSNotification *)notification
{
    WBEmotion *emotion = notification.userInfo[WBSelectEmotionKey];
    [self.textView insertEmotion:emotion];
}

- (void)emotionDidSelect
{
    [self.textView deleteBackward];
}


- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    if (self.photosView.photos.count) {
        [self sendWithImage];
    } else {
        [self sendWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendWithImage
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        WBLog(@"%@", error);
        [MBProgressHUD showError:@"发送失败"];
    }];
}


- (void)sendWithoutImage
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
}


- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    if (self.switchingKeyboard) return;
    NSDictionary *userInfo = notification.userInfo;
    
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        if (keyboardF.origin.y > self.view.height) {
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
    }];
}

#pragma mark - 其他方法

- (void)switchKeyboard
{
    if (self.textView.inputView == nil) {
        self.textView.inputView = self.emotionKeyboard;
        self.toolbar.showKeyboardButton = YES;
    } else {
        self.textView.inputView = nil;
        self.toolbar.showKeyboardButton = NO;
    }
    
    self.switchingKeyboard = YES;
    
    [self.textView endEditing:YES];
    
    self.switchingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
        
    });
}

- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAlbum
{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UITextViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - WBComposeToolbarDelegate

- (void)composeToolbar:(WBComposeToolbar *)toolbar didClickButton:(WBComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case WBComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
            
        case WBComposeToolbarButtonTypePicture:
            [self openAlbum];
            break;
            
        case WBComposeToolbarButtonTypeMention:
            WBLog(@"--- @");
            break;
            
        case WBComposeToolbarButtonTypeTrend:
            WBLog(@"--- #");
            break;
            
        case WBComposeToolbarButtonTypeEmotion:
            [self switchKeyboard];
            break;
        
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.photosView addPhoto:image];
}

@end
