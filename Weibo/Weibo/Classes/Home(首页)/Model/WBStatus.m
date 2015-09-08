//
//  WBStatus.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/27.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBStatus.h"
#import "WBPhoto.h"
#import "MJExtension.h"

@implementation WBStatus

//+ (instancetype)statusWithDict:(NSDictionary *)dict
//{
//    WBStatus *status = [[self alloc] init];
//    status.idstr = dict[@"idstr"];
//    status.text = dict[@"text"];
//    status.user = [WBUser userWithDict:dict[@"user"]];
//    return status;
//}

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [WBPhoto class]};
}

-(NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    NSDate *createDate = [fmt dateFromString:_created_at];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) {
        if ([createDate isYesterday]) {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) {
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

-(void)setSource:(NSString *)source
{   if (source.length != 0) {
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
  }
}

@end
