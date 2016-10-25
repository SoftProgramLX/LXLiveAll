//
//  LXTextView.m
//  TextViewLink
//
//  Created by 李旭 on 16/4/19.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import "LXTextView.h"
#import "LXTextAttachment.h"
#import "UIImageView+WebCache.h"
#import "LXTextHelpClass.h"

@implementation LXTextView
{
    NSMutableAttributedString *attributedString;
    LXTextHelpClass *helpClass;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        helpClass = [LXTextHelpClass sharedLXTextHelpClass];
        self.fontFloat = 18.;
    }
    return self;
}

- (void)setTextString:(NSString *)string
{
    NSDictionary *attributeDict =
        [NSDictionary dictionaryWithObjectsAndKeys:
         [UIFont systemFontOfSize:self.fontFloat], NSFontAttributeName,
         [UIColor blackColor], NSForegroundColorAttributeName,nil];
    
    attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:attributeDict];
    
    //设置行距与换行模式
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    
    NSArray *emojiArr = [LXTextHelpClass validateEmojiOfText:attributedString.string];
    for (int i = 0; i < emojiArr.count; i++) {
        NSInteger index = [helpClass.keyArr indexOfObject:emojiArr[i]];
        NSString *imgName = [helpClass.valueArr objectAtIndex:index];
        NSRange range = [attributedString.string rangeOfString:emojiArr[i] options:NSCaseInsensitiveSearch range:NSMakeRange(0, attributedString.string.length)];
        
        //正则表达式匹配的表情
        LXTextAttachment *textAttachmentEmoji = [[LXTextAttachment alloc] initWithData:nil ofType:nil];
        textAttachmentEmoji.imgSize = CGSizeMake(30 ,30);
        textAttachmentEmoji.image = [UIImage imageNamed:imgName] ;
        NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachmentEmoji];
        [attributedString replaceCharactersInRange:range withAttributedString:textAttachmentString];
    }
    
    //自定义添加的本地图片
//    LXTextAttachment *textAttachmentImg = [[LXTextAttachment alloc] initWithData:nil ofType:nil];
//    textAttachmentImg.imgSize = CGSizeMake(270, 160);
//    textAttachmentImg.image = [UIImage imageNamed:@"bird"];
//    NSAttributedString *textAttachmentString2 = [NSAttributedString attributedStringWithAttachment:textAttachmentImg];
//    [attributedString insertAttributedString:textAttachmentString2 atIndex:56];
    
    NSArray *linkArr = [LXTextHelpClass validateLinkOfText:attributedString.string];
    for (int i = 0; i < linkArr.count; i++) {
        NSRange range = NSRangeFromString(linkArr[i]);
        //正则表达式匹配的链接
        NSString *linkStr = [attributedString.string substringWithRange:range];
        [attributedString addAttribute:NSLinkAttributeName value:linkStr range:range];
    }
    
    //自定义的链接
    NSString *key1 = @"查看教程";
    if ([string rangeOfString:key1].length > 0) {
        [attributedString addAttribute:NSLinkAttributeName value:URL_JIANSHU_COURSE range:[[attributedString string] rangeOfString:key1]];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:self.fontFloat+2.0] range:[string rangeOfString:key1]];
    }
    
    NSDictionary *linkAttributes =
    @{NSForegroundColorAttributeName:[UIColor greenColor], NSUnderlineColorAttributeName:[UIColor lightGrayColor], NSUnderlineStyleAttributeName:@(NSUnderlinePatternSolid)};
    
    self.linkTextAttributes = linkAttributes;
    self.attributedText = attributedString;
}

- (void)downloadImageWithUrl:(NSString *)urlString withIndex:(NSInteger)index
{
    __block UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [imgV sd_setImageWithURL:[NSURL URLWithString:urlString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (attributedString) {
            //网络图片
            LXTextAttachment *textAttachment3 = [[LXTextAttachment alloc] initWithData:nil ofType:nil];
            textAttachment3.imgSize = CGSizeMake(130, 80);
            textAttachment3.image = image;
            NSAttributedString *textAttachmentString3 = [NSAttributedString attributedStringWithAttachment:textAttachment3];
            [attributedString insertAttributedString:textAttachmentString3 atIndex:index];
            self.attributedText = attributedString;
        }
        
        [imgV removeFromSuperview];
        imgV = nil;
    }];
    [self addSubview:imgV];
}

@end


