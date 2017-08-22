# DWBasicAlertAction 系统弹窗，根据版本自动选择调用UIAlertView、UIActionSheet还是UIAlertController

## Alert调用示例
```objc
[DWBasicAlertAction showAlertWithTitle:@"Alert" message:@"DWBasicAlertAction" cancelButtonTitle:@"cancel" otherButtonTitles:@[@"item1",@"item2",@"item3",@"item4",@"item5",@"item6"]  chooseBlock:^(NSInteger buttonIdx) {
	NSLog(@"click buttonIdx:%ld",buttonIdx);
}];
```
## UIActionSheet调用示例
```objc
[DWBasicAlertAction showActionSheetWithTitle:@"ActionSheet" message:@"DWBasicAlertAction" cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destrutive" otherButtonTitles:@[@"item1",@"item2",@"item3",@"item4",@"item5",@"item6"] chooseBlock:^(NSInteger buttonIdx) {
	NSLog(@"click buttonIdx:%ld",buttonIdx);
}];
```

## Installation

Latest version: **1.0.1**

```
pod search DWBasicAlertAction
```
If you cannot search out the latest version, try:  

```
pod setup
```

## Release Notes

We recommend to use the latest release in cocoapods.

- 1.0.1
support for cocoapods
