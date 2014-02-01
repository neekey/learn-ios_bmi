//
//  NKViewController.h
//  BMI
//
//  Created by neekey on 14-1-31.
//  Copyright (c) 2014年 neekey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

// picker行方的toolbar
@property (strong, nonatomic) IBOutlet UIToolbar *heightPickerViewToolbar;
// picker
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
// 用于输入高度的文本框
@property (strong, nonatomic) IBOutlet UITextField *heightTextField;
// 用于输入体重的文本框
@property (strong, nonatomic) IBOutlet UITextField *weightTextField;
// 计算 按钮
@property (strong, nonatomic) IBOutlet UIButton *calculate;
// BMI结果显示label
@property (strong, nonatomic) IBOutlet UILabel *result;

// 计算按钮点击action
- (IBAction) calculateBMI:(id)sender;
// 工具栏上 完成 按钮
- (IBAction) doneSelectHeight: (id)sender;

// 身高当前选中的行
@property NSInteger heightSelectRow;
// 体重当前选中行
@property NSInteger weightSelectRow;
// 身高选项列表
@property NSMutableArray* heightDataList;
// 体重选项列表
@property NSMutableArray* weightDataList;
// 当前数据列表
@property NSMutableArray* currentDataList;
// 当前被激活的文本框
@property UITextField* activeTextField;

@end
