//
//  DWBasicAlertAction.h
//  FenBei
//
//  Created by DickyWoo on 2017/8/9.
//  Copyright © 2017年 Dicky. All rights reserved.
//
//  弹窗显示工具

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DWBasicAlertAction : NSObject
/**
 *  显示Alert模式对话框（会自动根据iOS版本选择调用UIAlertView还是UIAlertController）
 *
 *  @param title             标题
 *  @param message           提示内容
 *  @param cancelButtonTitle 取消按钮文本
 *  @param otherButtonTitles 其他按钮数组，如 @[@"sure1",@"sure2",@"sure3"]
 *  @param chooseBlock       点击事件回调->返回按钮下标(按钮下标规则同系统默认UIAlertView下标规则，若cancelButtonTitle不为空则取消按钮下标为0，其他按钮下标依次排列)
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
          otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles
               chooseBlock:(void (^)(NSInteger buttonIdx))chooseBlock;

/**
 *    显示UIActionSheet模式对话框（会自动根据iOS版本选择调用UIActionSheet还是UIAlertController）
 *
 *  @param title                  标题
 *  @param message                消息内容,大于iOS8.0才会显示
 *  @param cancelButtonTitle      取消按钮文本
 *  @param destructiveButtonTitle 销毁按钮文本，默认红色文字显示
 *  @param otherButtonTitles      其他按钮数组,如 @[@"other1",@"other2",@"other3"]
 *  @param chooseBlock            点击事件回调->返回buttonIdx（按钮下标规则同系统默认UIActionSheet下标规则，若destructiveButtonTitle不为空则销毁按钮下标为0，其他按钮下标依次排列，若cancelButtonTitle不为空则取消按钮下标为最后一个）
 */
+ (void)showActionSheetWithTitle:(NSString *)title
                         message:(NSString *)message
               cancelButtonTitle:(NSString *)cancelButtonTitle
          destructiveButtonTitle:(NSString *)destructiveButtonTitle
               otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles
                     chooseBlock:(void (^)(NSInteger buttonIdx))chooseBlock;

@end


@interface UIAlertView (DWBasicAlertAction)
// 用block的方式回调，这时候会默认用self作为Delegate
- (void)showWithBlock:(void(^)(NSInteger buttonIndex))block;

@end



@interface UIActionSheet (DWBasicAlertAction)<UIActionSheetDelegate>
// 用block的方式回调
- (void)showInView:(UIView *)view block:(void(^)(NSInteger idx, NSString *buttonTitle))block;

@end
