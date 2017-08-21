# DWBasicAlertAction 系统弹窗，根据版本自动选择调用UIAlertView、UIActionSheet还是UIAlertController

## Alert调用示例
[DWBasicAlertAction showAlertWithTitle:@"Alert" message:@"DWBasicAlertAction" cancelButtonTitle:@"cancel" otherButtonTitles:@[@"item1",@"item2",@"item3",@"item4",@"item5",@"item6"]  chooseBlock:^(NSInteger buttonIdx) {
	NSLog(@"click buttonIdx:%ld",buttonIdx);
}];

## UIActionSheet调用示例
[DWBasicAlertAction showActionSheetWithTitle:@"ActionSheet" message:@"DWBasicAlertAction" cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destrutive" otherButtonTitles:@[@"item1",@"item2",@"item3",@"item4",@"item5",@"item6"] chooseBlock:^(NSInteger buttonIdx) {
	NSLog(@"click buttonIdx:%ld",buttonIdx);
}];
