//
//  DWBasicAlertAction.m
//  FenBei
//
//  Created by DickyWoo on 2017/8/9.
//  Copyright © 2017年 Dicky. All rights reserved.
//
//  弹窗显示工具

#import "DWBasicAlertAction.h"
//#import "AppDelegate.h"
#import <objc/runtime.h>

@implementation DWBasicAlertAction
// 显示Alert模式对话框（会自动根据iOS版本选择调用UIAlertView还是UIAlertController）
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles
               chooseBlock:(void (^)(NSInteger))chooseBlock  {
    
    NSMutableArray *argsArray = [[NSMutableArray alloc] initWithCapacity:1];
    [argsArray addObjectsFromArray:otherButtonTitles];
    
    if ([DWBasicAlertAction isUseAlertController]) {
        if (cancelButtonTitle) {
            //添加取消按钮数据---插入数组头部（为保持和系统默认cancelButtonIndex下标一致）
            [argsArray insertObject:cancelButtonTitle atIndex:0];
        }

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (NSInteger i = 0; i < [argsArray count]; i++) {
            NSString *buttonTitle = argsArray[i];
            UIAlertActionStyle style = UIAlertActionStyleDefault;
            if (cancelButtonTitle && [cancelButtonTitle isEqualToString:buttonTitle]) {
                style = UIAlertActionStyleCancel;
            }
            UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle style:style handler:^(UIAlertAction *action) {
                if (chooseBlock) {
                    chooseBlock(i);
                }
            }];
            [alertController addAction:action];
        }
        [DWBasicAlertAction presentAlertController:alertController];
        
    } else {

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
        if (argsArray.count) {
            for (NSString *buttonTitle in argsArray) {
                [alertView addButtonWithTitle:buttonTitle];
            }
        }
        [alertView showWithBlock:^(NSInteger buttonIdx) {
            if (chooseBlock) {
                chooseBlock(buttonIdx);
            }
         }];
    }
}

//显示UIActionSheet模式对话框（会自动根据iOS版本选择调用UIActionSheet还是UIAlertController）
+ (void)showActionSheetWithTitle:(NSString *)title
                         message:(NSString *)message
               cancelButtonTitle:(NSString *)cancelString
          destructiveButtonTitle:(NSString *)destructiveButtonTitle
               otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles
                     chooseBlock:(void (^)(NSInteger buttonIdx))chooseBlock {
    
    NSMutableArray *argsArray = [[NSMutableArray alloc] initWithCapacity:3];
    [argsArray addObjectsFromArray:otherButtonTitles];
    
    if ([DWBasicAlertAction isUseAlertController]) {
        if (destructiveButtonTitle) {
            //添加销毁按钮数据---插入数组首部（为保持和系统默认destructiveButtonIndex下标一致）
            [argsArray insertObject:destructiveButtonTitle atIndex:0];
        }
        if (cancelString) {
            //添加取消按钮数据---插入数组尾部（为保持和系统默认cancelButtonIndex下标一致）
            [argsArray addObject:cancelString];
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSInteger i = 0; i < [argsArray count]; i++) {
            NSString *buttonTitle = argsArray[i];
            UIAlertActionStyle style = UIAlertActionStyleDefault;
            if (cancelString && [cancelString isEqualToString:buttonTitle]) {
                //判断是否存在取消按钮
                style = UIAlertActionStyleCancel;
            }
            if (destructiveButtonTitle && [destructiveButtonTitle isEqualToString:buttonTitle]) {
                //判断是否存在销毁按钮
                style = UIAlertActionStyleDestructive;
            }
            UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle style:style handler:^(UIAlertAction *action) {
                if (chooseBlock) {
                    chooseBlock(i);
                }
            }];
            [alertController addAction:action];
        }
        [self presentAlertController:alertController];

    } else {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil, nil];
        if (argsArray.count > 0) {
            for (NSInteger i=0; i < argsArray.count; i++) {
                [sheet addButtonWithTitle:argsArray[i]];
            }
        }
        if (cancelString) {
            //最后添加取消按钮（为保持和系统默认cancelButtonIndex下标一致）
            [sheet addButtonWithTitle:cancelString];
            [sheet setCancelButtonIndex:argsArray.count + (destructiveButtonTitle?1:0)];
        }
        
        UIView *showView = [DWBasicAlertAction getPresentViewController].view;
        [sheet showInView:showView block:^(NSInteger buttonIdx, NSString *buttonTitle) {
            if (chooseBlock) {
                chooseBlock(buttonIdx);
            }
        }];
    }
}

//执行跳转UIAlertController
+ (void)presentAlertController:(UIAlertController *)alertController {
    dispatch_async(dispatch_get_main_queue(), ^{
        //presentViewController的时候往往会占用较多资源，所以编译器默认放在后台处理
        //就导致有时候presentViewController所需时间过长，例如点击cell且selectionStyle为UITableViewCellSelectionStyleNone时，该过程就可能需要大概五六秒时间
        //为解决这个问题，故将该操作移到主线程中进行
        [[DWBasicAlertAction getPresentViewController] presentViewController:alertController animated:YES completion:^{
        }];
    });
}

//获取用来跳转UIAlertController的控制器
+ (UIViewController *)getPresentViewController {
    /* 不能使用[[[UIApplication sharedApplication] keyWindow] rootViewController]去获取rootViewController
    因为UIAlertController的出现，是生成了一个新的window，然后添加在界面上
    这个时候获取到的keyWindow就是UIAlertControllerShimPresenterWindow
    获取到的rootViewController就会是UIApplicationRotationFollowingController */
//    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    UIViewController *topController = appdelegate.window.rootViewController;
    UIViewController *topController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])	{
        topController = [topController presentedViewController];
    }
    //  Getting current ViewController
    UIViewController *currentViewController = topController;
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController]) {
        currentViewController = [(UINavigationController*)currentViewController topViewController];
        
    }
    //  Returning present ViewController
    return currentViewController;
}

//判断系统版本，如果是大于等于8.0使用UIAlertController，否则使用UIAlertView或者UIActionSheet
+ (BOOL)isUseAlertController {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        return YES;
    } else {
        return NO;
    }
}


@end



static char AlertBlockKey;
@implementation UIAlertView (DWBasicAlertAction)
//get block属性
- (void(^)(NSInteger buttonIndex))block {
    return objc_getAssociatedObject(self, &AlertBlockKey);;
}

//set block属性
- (void)setBlock:(void(^)(NSInteger buttonIndex))block {
    if (block) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, &AlertBlockKey, block, OBJC_ASSOCIATION_COPY);
    }
}

- (void)showWithBlock:(void(^)(NSInteger buttonIndex))block {
    self.block = block;
    self.delegate = self;
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.block) {
        self.block(buttonIndex);
    }
    //断开所有关联
    objc_removeAssociatedObjects(self);
}

@end



static char SheetBlockKey;
@implementation UIActionSheet (DWBasicAlertAction)
//get block属性
- (void(^)(NSInteger idx, NSString *buttonTitle))block {
    return objc_getAssociatedObject(self, &SheetBlockKey);;
}

//set block属性
- (void)setBlock:(void(^)(NSInteger idx, NSString* buttonTitle))block {
    if (block) {
        objc_setAssociatedObject(self, &SheetBlockKey, block, OBJC_ASSOCIATION_COPY);
    }
}

- (void)showInView:(UIView *)view block:(void(^)(NSInteger idx, NSString* buttonTitle))block {
    self.block = block;
    self.delegate = self;
    [self showInView:view];
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.block) {
        self.block(buttonIndex,[self buttonTitleAtIndex:buttonIndex]);
    }
    //断开所有关联
    objc_removeAssociatedObjects(self);
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    //断开所有关联
    objc_removeAssociatedObjects(self);
}

@end

