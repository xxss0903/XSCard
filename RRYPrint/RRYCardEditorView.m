//
//  RRYCardEditorView.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/8.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYCardEditorView.h"
#import "RRYBaseTableView.h"

@interface RRYCardEditorView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) RRYBaseTableView *viewsTable;


@end

@implementation RRYCardEditorView

#pragma mark - tableviewdatasource/delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    return cell;
}


- (void)setupSubViews
{
    self.viewsTable = [[RRYBaseTableView alloc] init];
    [self addSubview:self.viewsTable];
}


- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor purpleColor];
        [self setupSubViews];
    }
    return self;
}

@end
