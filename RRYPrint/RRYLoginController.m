//
//  RRYLoginController.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/18.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYLoginController.h"

@interface RRYLoginController ()

@property (nonatomic, strong) RRYBaseButton *loginBtn;
@property (nonatomic, strong) RRYBaseButton *cancelBtn;
@property (nonatomic, strong) RRYBaseButton *signUpBtn;

@property (nonatomic, strong) RRYBaseTextField *userNameText;
@property (nonatomic, strong) RRYBaseTextField *passWordText;

@end


@implementation RRYLoginController

- (void)setupSubViews
{
    
    // 登录按钮
    self.userNameText = [[RRYBaseTextField alloc] init];
    self.userNameText.placeholder = @"请输入用户名";
    [self.view addSubview:self.userNameText];
    self.passWordText = [[RRYBaseTextField alloc] init];
    self.passWordText.placeholder = @"请输入密码";
    [self.view addSubview:self.passWordText];
    
    self.loginBtn = [[RRYBaseButton alloc] init];
    [self.loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"正在登录..." forState:UIControlStateSelected];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
    self.cancelBtn = [[RRYBaseButton alloc] init];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitle:@"取消登录" forState:UIControlStateNormal];
    [self.view addSubview:self.cancelBtn];
    
    
    [self setupSubViewsFrame];
}

- (void)setupSubViewsFrame
{
    [self.userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(PADDING_LARGE);
        make.right.equalTo(self.view.mas_right).with.offset(-PADDING_LARGE);
        make.top.equalTo(self.view.mas_top).with.offset(PADDING_LARGE * 2);
        make.height.mas_equalTo(44);
    }];
    
    [self.passWordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(PADDING_LARGE);
        make.right.equalTo(self.view.mas_right).with.offset(-PADDING_LARGE);
        make.top.equalTo(self.userNameText.mas_bottom).with.offset(PADDING_SMALL);
        make.height.mas_equalTo(self.userNameText.mas_height);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(PADDING_LARGE);
        make.right.equalTo(self.view.mas_right).with.offset(-PADDING_LARGE);
        make.top.equalTo(self.passWordText.mas_bottom).with.offset(PADDING_LARGE);
        make.height.mas_equalTo(44);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(PADDING_LARGE);
        make.right.equalTo(self.view.mas_right).with.offset(-PADDING_LARGE);
        make.top.equalTo(self.loginBtn.mas_bottom).with.offset(PADDING_SMALL);
        make.height.mas_equalTo(44);
    }];
}

- (void)loginBtnClicked:(id)sender
{
    self.loginBtn.selected = YES;
    
    // 登录请求参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.userNameText.text forKey:@"UserName"];
    [param setValue:self.passWordText.text forKey:@"PassWord"];
    

    if (!([self.userNameText.text isEqualToString:@"j"] && [self.passWordText.text isEqualToString:@"123"])) {
        NSLog(@"用户名或密码错误");
        // 登录错误的动画效果
        
        
        return;
    }
    
    // 登录请求
//    [RRYNetworkTool post:kLogin andParam:param success:^(NSDictionary *response) {
//        //请求成功
//        NSLog(@"登录请求成功：%@", response);
//    } failure:^(NSError *error) {
//        NSLog(@"登录请求失败");
//    }];

}

- (BOOL)adjustUserName:(NSString *)userName andPassWord:(NSString *)password
{
    if ([userName isEqualToString:@"j"] && [password isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

- (void)cancelBtnClicked:(id)sender
{
    NSLog(@"dismiss vc ");
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self setupSubViews];
    
}

@end
