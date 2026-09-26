
#import <UIKit/UIKit.h>


#ifdef __cplusplus
extern "C" {
#endif

NSString *ASDTranslate(NSString *text);

#ifdef __cplusplus
}
#endif

 
#pragma mark Download Status

static NSString *ASDDownloadTranslate(NSString *text)
{
    if([text hasPrefix:@"Caching"])
        return @"缓存中";

    if([text hasPrefix:@"Queued"])
        return @"排队中";

    if([text isEqualToString:@"Cleaning up..."])
        return @"清理中...";

    return text;
}

#pragma mark - 防止中文重复翻译

static BOOL ASDHasChinese(NSString *text)
{
    if(!text)
        return NO;


    NSPredicate *p =
    [NSPredicate predicateWithFormat:
     @"SELF MATCHES %@", @".*[\\u4e00-\\u9fa5].*"];


    return [p evaluateWithObject:text];
}



static NSString *ASDSafeTranslate(NSString *text)
{
    if(!text ||
       text.length == 0)
        return text;

text = ASDDownloadTranslate(text);

if ([text isEqualToString:@"What's new in Cercube"] ||
        [text isEqualToString:@"What's new\nin Cercube"] ||
        [text isEqualToString:@"What's new\r\nin Cercube"])
    {
        return @"Cercube 更新内容";
    }
if([text isEqualToString:@"Supercharge your YouTube experience!"])
{
    return @"增强你的 YouTube 使用体验！";
    
    }

   if([text hasPrefix:@"Agreeing"])
{
    return @"正在确认…";
}
    
    if([text hasPrefix:@"Resume caching"])
{
    return @"继续缓存";
}
    
    
 if([text containsString:@"What is Cercube?"] &&
   [text containsString:@"A tweak that adds advanced media controls"])
{
    return @"什么是 Cercube？\n一个为 YouTube 添加高级媒体控制，并扩展许多新功能的插件。\n\n这个能解锁 YouTube Premium 吗？\n不能！此插件不会免费解锁任何 Premium 功能，也无法帮助你绕过 DRM 保护。";
}


if([text hasPrefix:@"Paused"])
{
    return [text stringByReplacingOccurrencesOfString:@"Paused"
                                            withString:@"已暂停"];
}

if([text hasPrefix:@"Failed"])
{
    return [text stringByReplacingOccurrencesOfString:@"Failed"
                                            withString:@"失败"];
}

if([text hasPrefix:@"Audio"])
{
    return [text stringByReplacingOccurrencesOfString:@"Audio"
                                            withString:@"音频"];
}


    // Deleted: 后面可能包含中文标题
    if([text rangeOfString:@"Deleted:"
                   options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        NSRange range =
            [text rangeOfString:@"Deleted:"
                        options:NSCaseInsensitiveSearch];

        NSString *content =
            [text substringFromIndex:
             range.location + range.length];

        return [NSString stringWithFormat:@"已删除：%@", content];
    }


    // 防止中文重复翻译
    if(ASDHasChinese(text))
        return text;


    return ASDTranslate(text);
}




#pragma mark UILabel

%hook UILabel


- (void)setText:(NSString *)text
{
    %orig(ASDSafeTranslate(text));
}



- (void)setAttributedText:(NSAttributedString *)text
{

    if(text)
    {

        NSString *old =
        text.string;


        NSString *newText =
        ASDSafeTranslate(old);



        if(newText &&
           ![newText isEqualToString:old])
        {

            NSMutableAttributedString *m =
            [text mutableCopy];


            [m replaceCharactersInRange:
             NSMakeRange(0, old.length)
             withString:newText];


            %orig(m);

            return;

        }

    }


    %orig(text);

}


- (void)setAccessibilityLabel:(NSString *)text
{
    %orig(ASDSafeTranslate(text));
}



%end

#pragma mark UIButton


%hook UIButton


- (void)setTitle:(NSString *)title
        forState:(UIControlState)state
{

    %orig(ASDSafeTranslate(title),state);

}


%end





#pragma mark UITextField


%hook UITextField


- (void)setText:(NSString *)text
{
    %orig(ASDSafeTranslate(text));
}



- (void)setPlaceholder:(NSString *)text
{
    %orig(ASDSafeTranslate(text));
}



%end





#pragma mark UITextView


#pragma mark UITextView


%hook UITextView


- (void)setText:(NSString *)text

{
    %orig(ASDSafeTranslate(text));
}



- (void)setAttributedText:(NSAttributedString *)text

{
    if(text)
    {
        NSString *old =
        text.string;


        // 只处理 Cercube 同意页面
        if([old containsString:@"By using this tweak"] &&
           [old containsString:@"terms of service"])
        {

            NSMutableAttributedString *m =
            [text mutableCopy];


            // 普通文字
            NSRange r1 =
            [m.string rangeOfString:
             @"By using this tweak, you agree to the full"];


            if(r1.location != NSNotFound)
            {
                [m replaceCharactersInRange:
                 r1
                 withString:
                 @"使用此插件，即表示你同意完整的"];
            }



            // 保留 terms of service 的链接属性，只改显示文字
            NSRange r2 =
            [m.string rangeOfString:
             @"terms of service."];


            if(r2.location != NSNotFound)
            {
                [m replaceCharactersInRange:
                 r2
                 withString:
                 @"服务条款"];
            }



            %orig(m);
            return;
        }
    }


    %orig(text);
}

%end


#pragma mark YTFormattedStringLabel


%hook YTFormattedStringLabel



- (void)setText:(NSString *)text

{
    %orig(ASDSafeTranslate(text));
}



- (void)setAttributedText:(NSAttributedString *)text

{
    if(text)
    {
        NSString *old =
        text.string;


        NSString *newText =
        ASDSafeTranslate(old);



        if(newText &&
           ![newText isEqualToString:old])
        {
            NSMutableAttributedString *m =
            [text mutableCopy];


            [m replaceCharactersInRange:
             NSMakeRange(0, old.length)
             withString:newText];


            %orig(m);
            return;
        }
    }


    %orig(text);
}



%end





#pragma mark - YouTube Download Popup


%hook UIView



- (void)didMoveToWindow
{

    %orig;



    for(UIView *view in self.subviews)
    {


        if([view isKindOfClass:[UILabel class]])
        {

            UILabel *label =
            (UILabel *)view;



            NSString *old =
            label.text;



            if(old &&
               old.length)
            {

                NSString *newText =
                ASDSafeTranslate(old);



                if(newText &&
                   ![newText isEqualToString:old])
                {


                    NSLog(@"ASD FIX %@ => %@",old,newText);



                    label.text =
                    newText;

                }

            }

        }


    }


}



%end





#pragma mark UITableViewCell


%hook UITableViewCell


- (void)layoutSubviews
{

    %orig;


    if(self.textLabel.text)
    {
        self.textLabel.text =
        ASDSafeTranslate(self.textLabel.text);
    }


    if(self.detailTextLabel.text)
    {
        self.detailTextLabel.text =
        ASDSafeTranslate(self.detailTextLabel.text);
    }


}


%end





#pragma mark Settings


%hook UIListContentConfiguration


- (void)setText:(NSString *)text
{
    %orig(ASDSafeTranslate(text));
}



- (void)setSecondaryText:(NSString *)text
{
    %orig(ASDSafeTranslate(text));
}



%end
