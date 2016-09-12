//
//  ViewController.m
//  UBContactMode
//
//  Created by 云宝 Dean on 16/9/12.
//  Copyright © 2016年 云宝 Dean. All rights reserved.
//

#import "ViewController.h"
#import "UBContactSet.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic)UITableView *tableView;
@property (nonatomic)NSMutableArray *contactArray;
@end

@implementation ViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height-20) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSString *userPhoneNameStr = [[UIDevice currentDevice] name];//手机名称
//    NSLog(@"%@",userPhoneNameStr);
//    NSString *deviceNameStr = [[UIDevice currentDevice] systemName];//手机系统名称
//    NSLog(@"%@",deviceNameStr);
//    NSString *systemVersionStr = [[UIDevice currentDevice] systemVersion];//手机系统版本号
//    NSLog(@"%@",systemVersionStr);
//    NSString *phoneModelStr = [[UIDevice currentDevice] model];//类型 是模拟器还是真机
//    NSLog(@"%@",phoneModelStr);
//    //    NSString *phoneModelStr = [[UIDevice currentDevice] model];//类型 是模拟器还是真机
//    NSString *phoneUDIDStr = [[UIDevice currentDevice] model];//设备唯一标示码
//    NSLog(@"%@",phoneUDIDStr);
    
    
    [self getContactStore];
}
#pragma mark -- 获取手机通讯录
- (void)getContactStore
{
    [[UBContactSet sharedInstance]setContactsBlock:^(NSMutableArray *contacts) {
        _contactArray = contacts;
        [self.tableView reloadData];
    }];
    
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return _contactArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contactArray[section] phones].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"方式%ld:%@",indexPath.row+1,[_contactArray[indexPath.section] phones][indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = [NSString stringWithFormat:@"  %@",[_contactArray[section]famName]];
    return nameLabel;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30.0;
}



@end
