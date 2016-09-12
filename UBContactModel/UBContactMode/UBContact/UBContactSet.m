//
//  UBContactSet.m
//  UBAlartView
//
//  Created by 云宝 Dean on 16/9/12.
//  Copyright © 2016年 云宝 Dean. All rights reserved.
//

#import "UBContactSet.h"
#import <Contacts/Contacts.h>

@implementation UBContactSet
+ (instancetype)sharedInstance
{
    static dispatch_once_t __singletonToken;
    static id __singleton__;
    dispatch_once( &__singletonToken, ^{
        __singleton__ = [[self alloc] init];
    } );
    return __singleton__;
}
/**
 *  <CNContact: 0x126d92ee0: identifier=F285EC26-B30C-45B4-A0F6-D982D77045E4, givenName=, familyName=白先生, organizationName=(not fetched), phoneNumbers=(
 "<CNLabeledValue: 0x126d930c0: identifier=D3CC1B45-DABB-459A-B94B-C2698C140D38, label=_$!<Home>!$_, value=<CNPhoneNumber: 0x126d93100: countryCode=cn, digits=18312379654>>"
 ), emailAddresses=(not fetched), postalAddresses=(not fetched)>
 *
 *
 */

- (void)setContactsBlock:(CONTACTS)contaBlock
{
    //初始化一个数组，用来存储遍历到的所有联系人
   
    NSMutableArray *contactArray = [NSMutableArray array];
      //创建通讯录对象
    CNContactStore *contact = [[CNContactStore alloc]init];
    //定义所有打算获取的属性对应的key值，此处获取姓名，手机号，头像
    NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey,CNContactImageDataKey];
    //创建CNContactFetchRequest对象
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc]initWithKeysToFetch:keys];
    
    //遍历所有的联系人并把遍历到的联系人添加到contactArray
    [contact enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        //实例化一个联系人
        UBContacts *ubContact = [[UBContacts alloc]init];
        
        //取出联系人姓名
        NSString *name = @"";
        if ([NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName]) {
            name =  [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        }
        
        ubContact.famName = name;
        
        //实例化一个存储单个联系人的手机号码
        NSMutableArray *numbers = [NSMutableArray array];
        //取出联系人手机号码
        for (CNLabeledValue *label in contact.phoneNumbers) {
            CNPhoneNumber *number = label.value;
            //去除数字以外的所有字符
            NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]
                                           invertedSet ];
            NSString *strPhone = [[number.stringValue componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
            [numbers addObject:strPhone];
        }
        ubContact.phones = numbers;
        [contactArray addObject:ubContact];
        
     }];
    if (contactArray.count) {
        contaBlock(contactArray);
    }

}
@end
