//
//  UBContactSet.h
//  UBAlartView
//
//  Created by 云宝 Dean on 16/9/12.
//  Copyright © 2016年 云宝 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBContacts.h"
typedef void (^CONTACTS)(NSMutableArray *contacts);
@interface UBContactSet : NSObject
+ (instancetype)sharedInstance;
- (void)setContactsBlock:(CONTACTS)contaBlock;
@end
