//
//  NKViewController.m
//  BMI
//
//  Created by neekey on 14-1-31.
//  Copyright (c) 2014年 neekey. All rights reserved.
//

#import "NKViewController.h"

@interface NKViewController ()

/**
 * 根据当前激活的textField来返回对应的数据
 */
- (NSMutableArray*) getCurrentDataListByTextField: (UITextField *)textField;

/**
 * 根据当前textField已经选中的菜单的行数
 */
- (NSInteger) getCurrentPickerSelectedRowByTextField: (UITextField *)textField;

/**
 * 根据当前textField的值的单位
 */
- (NSString*) getCurrentPickerDataUnitByTextField: (UITextField *)textField;

/**
 * 保存当前选中的行数
 */
- (void) setCurrentSelectRow:(NSInteger)currentSelectRow  byTextField: (UITextField *)textField;

@end

@implementation NKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.heightDataList = [NSMutableArray arrayWithCapacity: 100];
    self.weightDataList = [NSMutableArray arrayWithCapacity: 100];

    for (int i = 5; i <= 300; i++ ) {
        [self.heightDataList addObject: [ NSString stringWithFormat: @"%d", i ]];
    }

    for (int i = 10; i <= 200; i++ ) {
        [self.weightDataList addObject: [ NSString stringWithFormat: @"%d", i ]];
    }

    // 设置textField的代理
    self.heightTextField.delegate = self;
    // 设置inputView和inputAccessoryView，当textField需要输入时，会显示两者，accessory在inputView上方
    self.heightTextField.inputView = self.pickerView;
    self.heightTextField.inputAccessoryView = self.heightPickerViewToolbar;
    self.weightTextField.delegate = self;
    self.weightTextField.inputView = self.pickerView;
    self.weightTextField.inputAccessoryView = self.heightPickerViewToolbar;
    // 已经选中的行数
    self.heightSelectRow = 0;
    self.weightSelectRow = 0;
}

- (NSMutableArray *)getCurrentDataListByTextField: (UITextField *)textField  {
    return ( textField == self.heightTextField ) ?
    self.heightDataList : self.weightDataList;
}

- (NSInteger) getCurrentPickerSelectedRowByTextField: (UITextField *)textField {
    return (textField == self.heightTextField ) ?
    self.heightSelectRow : self.weightSelectRow;
}

- (NSString*) getCurrentPickerDataUnitByTextField: (UITextField *)textField {
    return self.activeTextField == self.heightTextField ? @"厘米" : @"千克" ;
}

- (void) setCurrentSelectRow:(NSInteger)currentSelectRow byTextField: (UITextField *)textField {

    if ( textField == self.heightTextField ) {
        self.heightSelectRow = currentSelectRow;
    }
    else {
        self.weightSelectRow = currentSelectRow;
    }
}

#pragma mark UITextFieldDelegate

/**
 * 菜单即将出现时
 */
- (BOOL) textFieldShouldBeginEditing: (UITextField *)textField {

    self.activeTextField = textField;
    self.currentDataList = [self getCurrentDataListByTextField:textField];

    // 重新装载picker的数据
    [self.pickerView reloadAllComponents];

    // 选中默认值
    [self.pickerView selectRow: [self getCurrentPickerSelectedRowByTextField:textField ] inComponent:0 animated:YES];

    // 检查 textField 是否还为空，若为空，则默认选中中间的选项
    if( [textField.text length] == 0 ){
        [self.pickerView selectRow: [self.currentDataList count] / 2 inComponent:0 animated:YES];
    }
    return YES;
}

#pragma mark actions

/**
 * 点击完成按钮
 */
- (void)doneSelectHeight:(id)sender {
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    self.activeTextField.text = [[self.currentDataList objectAtIndex:row] stringByAppendingString:[ self getCurrentPickerDataUnitByTextField: self.activeTextField ]];
    [self setCurrentSelectRow:row byTextField: self.activeTextField];
    [self.activeTextField endEditing:YES];
}

/**
 * 点击计算
 */
- (void)calculateBMI:(id)sender {
    float height = [self.heightTextField.text floatValue];
    float weight = [self.weightTextField.text floatValue];
    float bmi = weight / ( height * 2 / 100 );

    NSString* result = [ NSString stringWithFormat: @"%f", bmi ];

    self.result.text = result;
}

#pragma mark UIPickerViewDelegate & UIPickerViewDataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.currentDataList count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return  [[self.currentDataList objectAtIndex: row] stringByAppendingString: [ self getCurrentPickerDataUnitByTextField: self.activeTextField ] ];
}

@end
