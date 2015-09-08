//
//  WBEmotionTextView.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/13.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBEmotionTextView.h"
#import "WBEmotion.h"
#import "WBEmotionAttachment.h"

@implementation WBEmotionTextView

- (void)insertEmotion:(WBEmotion *)emotion
{
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    } else if (emotion.png) {
        WBEmotionAttachment *attach = [[WBEmotionAttachment alloc] init];
        attach.emotion = emotion;
        
        CGFloat attachWH = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -4, attachWH, attachWH);
        
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
        
        [self insertAttributedText:imageStr];
        
//        NSMutableAttributedString *text = (NSMutableAttributedString *)self.attributedText;
//        [text addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    }
}

- (NSString *)fullText
{
    NSMutableString *fullText = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        WBEmotionAttachment *attach = attrs[@"NSAttachment"];
        if (attach) {
            [fullText appendString:attach.emotion.chs];
        } else {
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
                                 
    return fullText;
}

@end
