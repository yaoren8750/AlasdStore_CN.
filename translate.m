
#import <Foundation/Foundation.h>

#import "translate.h"
#ifdef __cplusplus
extern "C" {
#endif
    
    NSString *ASDTranslate(NSString *text)
    {
        if (!text || text.length == 0)
            return text;


        NSString *translatedText = text;


        NSString *arabicText =
        [text stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceAndNewlineCharacterSet]];

        NSLog(@"ASD RAW = %@", [text debugDescription]);
        //NSLog(@"Arabic TEXT = %@", arabicText);

        // =============================
        // Remove selected mark
        // =============================

        

        

#pragma mark - Arabic
        
        // =============================
        // Merge video
        // جار دمج الفيديو
        // =============================

        if ([arabicText containsString:@"دمج"] &&
            ([arabicText containsString:@"فيديو"] ||
             [arabicText containsString:@"الفيديو"]))
        {
            return @"正在合并视频";
        }
        
        if ([arabicText containsString:@"لا يوجد سجل تشخيص بعد"])
        {
            return @"暂无诊断记录。";
        }

// =============================
// Download Complete
// 100 - اكتمل التنزيل%
// =============================

if ([arabicText containsString:@"اكتمل"] &&
    [arabicText containsString:@"التنزيل"])
{
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:@"\\d+"
                                              options:0
                                                error:nil];

    NSTextCheckingResult *match =
    [regex firstMatchInString:arabicText
                      options:0
                        range:NSMakeRange(0, arabicText.length)];

    if (match)
    {
        NSString *num =
        [arabicText substringWithRange:match.range];

        return [NSString stringWithFormat:@"下载完成 %@%%",num];
    }

    return @"下载完成";
}



// =============================
// English Downloading
// Downloading... 0%
// =============================

if ([arabicText containsString:@"Downloading"])
{
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:@"\\d+%"
                                              options:0
                                                error:nil];

    NSTextCheckingResult *match =
    [regex firstMatchInString:arabicText
                      options:0
                        range:NSMakeRange(0, arabicText.length)];

    if(match)
    {
        NSString *percent =
        [arabicText substringWithRange:match.range];

        return [NSString stringWithFormat:@"正在下载 %@",percent];
    }

    return @"正在下载";
}



// =============================
// Video progress
// Video · 61% الفيديو
// =============================

if (([arabicText containsString:@"Video"] ||
     [arabicText containsString:@"الفيديو"] ||
     [arabicText containsString:@"فيديو"])
    &&
    [arabicText rangeOfCharacterFromSet:
     [NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound)
{
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:@"\\d+%"
                                              options:0
                                                error:nil];

    NSTextCheckingResult *match =
    [regex firstMatchInString:arabicText
                      options:0
                        range:NSMakeRange(0, arabicText.length)];

    if(match)
    {
        NSString *percent =
        [arabicText substringWithRange:match.range];

        return [NSString stringWithFormat:@"正在下载视频 %@",percent];
    }

    return @"正在下载视频";
}



// =============================
// Audio progress
// Audio · 70% الصوت
// =============================

if (([arabicText containsString:@"Audio"] ||
     [arabicText containsString:@"الصوت"] ||
     [arabicText containsString:@"صوت"])
    &&
    [arabicText rangeOfCharacterFromSet:
     [NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound)
{
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:@"\\d+%"
                                              options:0
                                                error:nil];

    NSTextCheckingResult *match =
    [regex firstMatchInString:arabicText
                      options:0
                        range:NSMakeRange(0, arabicText.length)];

    if(match)
    {
        NSString *percent =
        [arabicText substringWithRange:match.range];

        return [NSString stringWithFormat:@"正在下载音频 %@",percent];
    }

    return @"正在下载音频";
}



// =============================
// Multiple downloads
// 2 downloads · 25%
// =============================

        if ([arabicText containsString:@"downloads"] &&
            [arabicText rangeOfString:@"%"].location != NSNotFound)
{
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:@"\\d+%"
                                              options:0
                                                error:nil];

    NSTextCheckingResult *match =
    [regex firstMatchInString:arabicText
                      options:0
                        range:NSMakeRange(0, arabicText.length)];

    if(match)
    {
        NSString *percent =
        [arabicText substringWithRange:match.range];

        return [NSString stringWithFormat:@"正在下载 %@",percent];
    }

    return @"正在下载";
}

        // =============================
        // stopped at
        // 720p · 19.3 MB · stopped at 1:42
        // =============================

        NSRange stoppedRange =
            [translatedText rangeOfString:@"stopped at"
                                   options:NSCaseInsensitiveSearch];

        if (stoppedRange.location != NSNotFound)
        {
            translatedText =
                [translatedText stringByReplacingOccurrencesOfString:@"stopped at"
                                                          withString:@"停止于"
                                                             options:NSCaseInsensitiveSearch
                                                               range:stoppedRange];

            return translatedText;
        }
        
        
        
// =============================
// Arabic downloading
// جار تنزيل الفيديو
// =============================

        // =============================
        // Arabic downloading status
        // 必须有 جار 或 数字进度
        // =============================

        if([arabicText containsString:@"تنزيل"] &&
           ([arabicText containsString:@"فيديو"] ||
            [arabicText containsString:@"الفيديو"]) &&
           ([arabicText containsString:@"جار"] ||
            [arabicText rangeOfCharacterFromSet:
             [NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound))
        {
            return @"正在下载视频";
        }


        if([arabicText containsString:@"تنزيل"] &&
           ([arabicText containsString:@"صوت"] ||
            [arabicText containsString:@"الصوت"]) &&
           ([arabicText containsString:@"جار"] ||
            [arabicText rangeOfCharacterFromSet:
             [NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound))
        {
            return @"正在下载音频";
        }


// 缩略图

if([arabicText containsString:@"تنزيل"] &&
   ([arabicText containsString:@"الصورة"] ||
    [arabicText containsString:@"صورة"]))
{
    return @"正在下载缩略图";
}



// =============================
// Menu
// =============================

if([arabicText containsString:@"اختر الجودة"])
{
    return @"选择画质";
}


if([arabicText containsString:@"اختر الصيغة"])
{
    return @"选择格式";
}


if([arabicText containsString:@"تنزيل"] &&
   [arabicText containsString:@"الترجمة"])
{
    return @"下载字幕";
}


        if ([arabicText containsString:@"تنزيل"] &&
            ([arabicText containsString:@"فيديو"] ||
             [arabicText containsString:@"الفيديو"]))
        {
            return @"下载视频";
        }



        // =============================
        // Download button Audio
        // =============================

        if ([arabicText containsString:@"تنزيل"] &&
            ([arabicText containsString:@"صوت"] ||
             [arabicText containsString:@"الصوت"]))
        {
            return @"下载音频";
        }


if([arabicText containsString:@"حفظ"] &&
   ([arabicText containsString:@"الصورة"] ||
    [arabicText containsString:@"صور"]))
{
    return @"保存到照片";
}


if([arabicText containsString:@"نسخ"] &&
   ([arabicText containsString:@"العنوان"] ||
    [arabicText containsString:@"معلومات الفيديو"]))
{
    return @"复制视频信息";
}


if([arabicText containsString:@"نسخ"] &&
   [arabicText containsString:@"التشخيص"])
{
    return @"复制诊断";
}


if([arabicText containsString:@"VTT"])
{
    return @"保存字幕";
}
        
        
        
        if ([translatedText isEqualToString:@"Thanks for installing ASJTube.\n\nEnjoy!"])
        {
            return @"感谢安装 ASJTikTok。\n\n使用愉快！";
        }
        
#pragma mark - English

if ([translatedText rangeOfString:@"Transcript data is unavailable"
                          options:NSCaseInsensitiveSearch].location != NSNotFound)
{
    return @"此视频没有可用的字幕数据。";
}
    
       
        
    #pragma mark - English


        translatedText =
        [translatedText stringByReplacingOccurrencesOfString:@"Downloading audio"
                                                   withString:@"正在下载音频"];


        translatedText =
        [translatedText stringByReplacingOccurrencesOfString:@"Downloading video"
                                                   withString:@"正在下载视频"];


        translatedText =
        [translatedText stringByReplacingOccurrencesOfString:@"Downloading"
                                                   withString:@"正在下载"];


        translatedText =
        [translatedText stringByReplacingOccurrencesOfString:@"Preparing"
                                                   withString:@"准备中"];




    #pragma mark - Labels


        translatedText =
        [translatedText stringByReplacingOccurrencesOfString:@"الفيديو"
                                                   withString:@"视频"];


        translatedText =
        [translatedText stringByReplacingOccurrencesOfString:@"فيديوهات"
                                                   withString:@"视频"];


        translatedText =
        [translatedText stringByReplacingOccurrencesOfString:@"فيديو"
                                                   withString:@"视频"];



        translatedText =
        [translatedText stringByReplacingOccurrencesOfString:@"الصوت"
                                                   withString:@"音频"];


        translatedText =
        [translatedText stringByReplacingOccurrencesOfString:@"صوت"
                                                   withString:@"音频"];



        translatedText =
        [translatedText stringByReplacingOccurrencesOfString:@"Video"
                                                   withString:@"视频"];


        translatedText =
        [translatedText stringByReplacingOccurrencesOfString:@"Audio"
                                                   withString:@"音频"];


        if ([translatedText containsString:@"Set Start"])
        {
            NSRegularExpression *regex =
            [NSRegularExpression regularExpressionWithPattern:
             @"Set Start\\s*[•·]\\s*([0-9]+:[0-9]+)"
             options:0
             error:nil];


            NSTextCheckingResult *match =
            [regex firstMatchInString:translatedText
                              options:0
                                range:NSMakeRange(0, translatedText.length)];


            if(match)
            {
                NSString *time =
                [translatedText substringWithRange:[match rangeAtIndex:1]];

                return [NSString stringWithFormat:@"设置开始 • %@",time];
            }
        }


        if ([translatedText containsString:@"Set End"])
        {
            NSRegularExpression *regex =
            [NSRegularExpression regularExpressionWithPattern:
             @"Set End\\s*[•·]\\s*([0-9]+:[0-9]+)"
             options:0
             error:nil];


            NSTextCheckingResult *match =
            [regex firstMatchInString:translatedText
                              options:0
                                range:NSMakeRange(0, translatedText.length)];


            if(match)
            {
                NSString *time =
                [translatedText substringWithRange:[match rangeAtIndex:1]];

                return [NSString stringWithFormat:@"设置结束 • %@",time];
            }
        }

        // Folders
        // Folders: ⁨0⁩   •   ⁨0.0 MB⁩
        if ([translatedText containsString:@"Folders"])
        {
            NSRegularExpression *regex =
            [NSRegularExpression regularExpressionWithPattern:
             @"Folders:\\s*[\\u2068\\s]*(\\d+)[\\u2069\\s]*[•·]\\s*[\\u2068\\s]*([0-9]+(?:\\.[0-9]+)?)[\\u2069\\s]*MB"
             options:0
             error:nil];

            NSTextCheckingResult *match =
            [regex firstMatchInString:translatedText
                              options:0
                                range:NSMakeRange(0, translatedText.length)];

            if (match)
            {
                NSString *count =
                [translatedText substringWithRange:[match rangeAtIndex:1]];

                NSString *size =
                [translatedText substringWithRange:[match rangeAtIndex:2]];

                return [NSString stringWithFormat:@"文件夹：%@ • %@ MB",
                        count, size];
            }
        }
        
        
        
    #pragma mark - English Status


        if ([translatedText containsString:@"Needed"] &&
            [translatedText containsString:@"Free"])
        {

            translatedText =
            [translatedText stringByReplacingOccurrencesOfString:@"Needed"
                                                       withString:@"需要"];


            translatedText =
            [translatedText stringByReplacingOccurrencesOfString:@"Free"
                                                       withString:@"可用"];

        }




    #pragma mark - Media Processing


        if ([translatedText containsString:@"Merging"])
        {
            return @"正在合并";
        }


        if ([translatedText containsString:@"Re-encoding"])
        {
            return @"正在重新编码";
        }


        if ([translatedText containsString:@"Converting"])
        {
            return @"正在转换音频";
        }



        
    


   // =====================
   // Delete
   // =====================


       if ([translatedText hasPrefix:@"Delete "] &&
           [translatedText hasSuffix:@" items?"])
       {
           NSString *num =
           [translatedText stringByReplacingOccurrencesOfString:@"Delete "
                                                     withString:@""];


           num =
           [num stringByReplacingOccurrencesOfString:@" items?"
                                          withString:@""];


           return [NSString stringWithFormat:@"删除 %@ 个项目？", num];
       }
   
        if ([translatedText containsString:@"No folder"])
        {
            translatedText =
            [translatedText stringByReplacingOccurrencesOfString:@"No folder"
                                                      withString:@"无文件夹"];
        }

   // =====================
   // Shorts
   // =====================


       if ([translatedText containsString:@"Auto-scroll Shorts"])
       {
           if ([translatedText containsString:@"On"])
               return @"自动播放 Shorts - 开";

           if ([translatedText containsString:@"Off"])
               return @"自动播放 Shorts - 关";

           return @"自动播放 Shorts";
       }



       if ([translatedText hasPrefix:@"Hide Shorts screen elements"])
       {
           if ([translatedText containsString:@"On"])
               return @"隐藏 Shorts 界面元素 - 开";

           if ([translatedText containsString:@"Off"])
               return @"隐藏 Shorts 界面元素 - 关";

           return @"隐藏 Shorts 界面元素";
       }

        // =====================
        // Deleted / Undo 动态文本
        // =====================

        // Undo available for 8 seconds
        // Undo available for 7 seconds
        // Undo available for 1 second
        if ([translatedText hasPrefix:@"Undo available for "])
        {
            NSString *tail =
                [translatedText substringFromIndex:[@"Undo available for " length]];

            if ([tail hasSuffix:@" seconds"])
            {
                NSString *seconds =
                    [tail substringToIndex:
                     tail.length - [@" seconds" length]];

                return [NSString stringWithFormat:@"可撤销，剩余 %@ 秒", seconds];
            }

            if ([tail hasSuffix:@" second"])
            {
                NSString *seconds =
                    [tail substringToIndex:
                     tail.length - [@" second" length]];

                return [NSString stringWithFormat:@"可撤销，剩余 %@ 秒", seconds];
            }
        }


        // Undo
        if ([translatedText isEqualToString:@"Undo"])
        {
            return @"撤销";
        }

        if ([translatedText hasPrefix:@"Shorts per session — "])
        {
            NSString *count =
                [translatedText substringFromIndex:[@"Shorts per session — " length]];

            return [NSString stringWithFormat:@"每次会话 Shorts 数量 — %@", count];
        }
        
        
        if ([translatedText hasPrefix:@"Shorts per day — "])
        {
            NSString *count =
                [translatedText substringFromIndex:[@"Shorts per day — " length]];

            return [NSString stringWithFormat:@"每日 Shorts 数量 — %@", count];
        }


        if ([translatedText isEqualToString:@"Shorts per day"])
        {
            return @"每日 Shorts 数量";
        }


        if ([translatedText hasPrefix:@"Open for — "])
        {
            NSString *minutes =
                [translatedText substringFromIndex:[@"Open for — " length]];

            return [NSString stringWithFormat:@"开放时间 — %@ 分钟", minutes];
        }


        if ([translatedText hasPrefix:@"Locked for — "])
        {
            NSString *hours =
                [translatedText substringFromIndex:[@"Locked for — " length]];

            return [NSString stringWithFormat:@"锁定时间 — %@ 小时", hours];
        }


        if ([translatedText isEqualToString:@"Open for (minutes)"])
        {
            return @"开放时间（分钟）";
        }


        if ([translatedText isEqualToString:@"Locked for (hours)"])
        {
            return @"锁定时间（小时）";
        }
        
    // =====================
    // 字典
    // =====================


        NSDictionary *table = @{


    // =====================
    // iQTube
    // =====================


// =======================
// ASD Tools Settings
// =======================

@"ASD Tools Settings":
@"ASD 工具设置",

@"Use old quality picker":
@"使用旧版清晰度选择器",

@"Reverts the video quality selection menu to the classic version (lists all resolutions immediately).":
@"将视频质量选择菜单恢复为经典版本（立即显示所有分辨率）",
@"FEED":
@"主页",
@"Extra speed options":
@"额外播放速度选项",
@"Enable Picture In Picture (PiP)":
@"开启画中画",
@"Adds more video playback speed options up to 10x.":
@"增加更多视频播放速度选项，最高支持 10 倍速",

@"Disable hints":
@"禁用提示",
@"تم إلغاء التنزيل":
@"下载已取消",
@"نسخ معلومات الفيديو":
@"复制视频信息",
@"حفظ الصورة المصغرة": @"保存到照片",
@"حفظ الصورة المصغّرة": @"保存到照片",


@"Force miniplayer":
@"强制小窗播放",

@"Allows all videos, including those made for kids, to play in the miniplayer when dismissing the player.":
@"允许所有视频（包括儿童视频）在退出播放器后继续小窗播放",

@"Copy channel details and save the profile picture":
@"复制频道信息并保存头像",

@"Copy channel details and save profile or banner images":
@"复制频道信息并保存头像或频道横幅图片",

@"Drag active tabs to reorder them. WolfTube stays available so you cannot lock yourself out of the tool.":
@"拖动已启用的标签页进行排序。WolfTube 始终保持可用，避免你将自己锁定在工具之外。",

@"Choose, hide and reorder the main navigation tabs":
@"选择、隐藏并重新排序主导航标签页",

@"Music":
@"音乐",

@"History":
@"历史记录",

@"Live":
@"直播",

@"Notifications":
@"通知",

@"Sports":
@"体育",

@"Gaming":
@"游戏",
// =======================
// Video Action Buttons
// =======================


@"Always show progress bar":
@"始终显示进度条",

@"Makes the progress bar (seekbar) remains visible at all times while in fullscreen mode.":
@"全屏模式下始终显示进度条",

@"لا يوجد سجل تشخيص بعد.":
@"暂无诊断记录。",

@"Hide Like button":
@"隐藏点赞按钮",

@"Hide Like button in the action bar under the video overlay.":
@"隐藏视频覆盖层下方操作栏中的点赞按钮",


@"Hide Dislike button":
@"隐藏点踩按钮",

@"Hide Dislike button in the action bar under the video overlay.":
@"隐藏视频覆盖层下方操作栏中的点踩按钮",


@"Hide Share button":
@"隐藏分享按钮",

@"Hide Share button in the action bar under the video overlay.":
@"隐藏视频覆盖层下方操作栏中的分享按钮",


@"Hide Download button":
@"隐藏下载按钮",

@"Hide Download button in the action bar under the video overlay.":
@"隐藏视频覆盖层下方操作栏中的下载按钮",


@"Hide Clip button":
@"隐藏剪辑按钮",

@"Hide Clip button in the action bar under the video overlay.":
@"隐藏视频覆盖层下方操作栏中的剪辑按钮",


@"Hide Remix button":
@"隐藏 Remix 按钮",

@"Hide Remix button in the action bar under the video overlay.":
@"隐藏视频覆盖层下方操作栏中的 Remix 按钮",


@"Hide Save button":
@"隐藏保存按钮",

@"Hide Save button in the action bar under the video overlay.":
@"隐藏视频覆盖层下方操作栏中的保存按钮",

@"New name (without extension):":
@"新名称（不包含扩展名）:",
// =======================
// Shorts
// =======================


@"SHORTS":
@"短视频",

@"Shorts controls hidden":
@"Shorts 控件已隐藏",

@"Shorts controls shown":
@"Shorts 控件已显示",

@"Show Shorts controls":
@"显示 Shorts 控件",

@"Hide Comment button":
@"隐藏评论按钮",

@"Hide the Comment button in the Shorts player.":
@"隐藏 Shorts 播放器中的评论按钮",


@"Hide sound metadata button":
@"隐藏声音信息按钮",

@"Hide the button that shows the sound source or music metadata in the Shorts player.":
@"隐藏显示声音来源或音乐信息的按钮",


@"Hide products":
@"隐藏商品",

@"Hide tagged products and shopping links in the Shorts overlay.":
@"隐藏 Shorts 覆盖层中的商品标签和购物链接",


@"Hide recommendation bar":
@"隐藏推荐栏",

@"Hide the suggested action bar in the Shorts player (e.g. Try this sound, Shopping, Preview comment).":
@"隐藏 Shorts 播放器中的推荐操作栏（例如：尝试此声音、购物、预览评论）",


@"Hide commissions bar":
@"隐藏佣金栏",

@"Hide the bar that shows the video got commissions in the Shorts player.":
@"隐藏显示视频佣金信息的栏",


@"Hide subscriptions button":
@"隐藏订阅按钮",

@"Hide the Subscriptions button at the top of the Shorts player.":
@"隐藏 Shorts 播放器顶部的订阅按钮",


@"Hide live button":
@"隐藏直播按钮",

@"Hide the Live button at the top of the Shorts player.":
@"隐藏 Shorts 播放器顶部的直播按钮",


@"Hide lens button":
@"隐藏 Lens 按钮",

@"Hide the Lens button at the top of the Shorts player.":
@"隐藏 Shorts 播放器顶部的 Lens 按钮",


@"Hide trends button":
@"隐藏趋势按钮",

@"Hide the Trends button at the top of the Shorts player.":
@"隐藏 Shorts 播放器顶部的趋势按钮",


@"Hide link to full video":
@"隐藏完整视频链接",

@"Hide the link that redirects in a Short to a full video in the Shorts player.":
@"隐藏 Shorts 中跳转完整视频的链接",


@"Enable Shorts quality picker":
@"启用 Shorts 清晰度选择器",

@"Force enable the video quality selection menu in Shorts.":
@"强制启用 Shorts 视频质量选择菜单",


@"Always show seekbar":
@"始终显示进度条",

@"Ensure the progress/seek bar is always visible at the bottom of the Shorts player.":
@"确保 Shorts 播放器底部始终显示进度条",
// =======================
// TAB BAR
// =======================
@"Automatic (System) 🌐":
@"自动（跟随系统）🌐",

@"العربية 🇸🇦":
@"阿拉伯语 🇸🇦",

@"English 🇬🇧":
@"英语 🇬🇧",

@"Tiếng Việt 🇻🇳":
@"越南语 🇻🇳",

@"TAB BAR":
@"标签栏",


@"Hide tab indicators":
@"隐藏标签指示器",

@"Hide all tab indicators in the tab bar.":
@"隐藏标签栏中的所有指示器",


@"Hide tab labels":
@"隐藏标签文字",

@"Hide all tab labels in the tab bar.":
@"隐藏标签栏中的所有文字",


@"Hide Home tab":
@"隐藏首页标签",


@"Hide Shorts tab":
@"隐藏 Shorts 标签",


@"Hide Create button":
@"隐藏创建按钮",


@"Hide Subscriptions tab":
@"隐藏订阅标签",



// =======================
// Appearance
// =======================


@"APPEARANCE":
@"外观",


@"OLED dark mode":
@"OLED 深色模式",

@"Uses pure black (OLED) color for the app dark theme.":
@"使用纯黑 OLED 颜色作为应用深色主题",


@"OLED keyboard":
@"OLED 键盘",
@"تنزيل فيديو":
@"选择画质",

@"تنزيل صوت":
@"选择格式",

@"حفظ الترجمة بصيغة VTT":
@"保存字幕",

@"نسخ آخر سجل خطأ":
@"复制诊断",

@"لا توجد ترجمات لهذا الفيديو.": @"此视频没有字幕。",
@"لا توجد مصادر صوت": @"没有音频源。",
@"لا توجد مصادر فيديو/صوت": @"没有视频/音频源。",
@"جار تنزيل فيديو":
@"正在下载视频",

@"جار تنزيل صوت":
@"正在下载音频",
// =======================
// Miscellaneous
// =======================


@"MISCELLANEOUS":
@"其他",


@"Background playback":
@"后台播放",

@"Enables background playback for videos.":
@"启用视频后台播放",


@"Disables Shorts PiP":
@"禁用 Shorts 画中画",

@"Try to disables Shorts PiP, this might not 100% disables it.":
@"尝试禁用 Shorts 画中画，但可能无法完全禁用",


@"Block upgrade dialogs":
@"阻止升级提示",

@"Block the YouTube dialogs that ask you to upgrade the app.":
@"阻止 YouTube 要求升级应用的弹窗",


@"Hide 'Are you there?' dialog":
@"隐藏“你还在吗？”弹窗",

@"Hide the dialog when you are inactive in the app for too long.":
@"隐藏长时间未操作时出现的确认弹窗",


@"Fixes slows miniplayer":
@"修复小窗播放缓慢",

@"Fixes the miniplayer slowness of expanding the video, this only works in older YouTube versions.":
@"修复展开视频时小窗播放缓慢问题，仅适用于旧版 YouTube",


@"Hide like/dislike votes":
@"隐藏点赞/点踩提示",

@"Hide messages that pop up when you like/dislike videos.":
@"隐藏点赞或点踩视频时弹出的提示",



// =======================
// Language
// =======================


@"LANGUAGE":
@"语言",


@"Automatic (device)":
@"自动（设备）",


@"English":
@"英语",


@"Tiếng Việt":
@"越南语",


@"Español":
@"西班牙语",


@"Français":
@"法语",


@"العربية":
@"阿拉伯语",

@"Русский ":
@"俄语",
// =======================
// Common UI
// =======================



@"General":
@"通用",

@"Enabled":
@"已启用",

@"Disabled":
@"已禁用",

@"On":
@"开启",

@"Off":
@"关闭",

@"Enable":
@"启用",

@"Disable":
@"禁用",

@"Save":
@"保存",

@"Cancel":
@"取消",

@"Done":
@"完成",

@"Reset":
@"重置",

@"Default":
@"默认",

@"Automatic":
@"自动",

// =======================
// Video Quality
// =======================
@"Home":
@"首页",

@"Subscriptions":
@"订阅",

@"Library (You)":
@"媒体库（你）",

@"None":
@"无",

@"Brightness":
@"亮度",

@"Playback speed":
@"播放速度",

@"Volume":
@"音量",

@"Small (-1)":
@"小（-1）",

@"Normal (Default)":
@"正常（默认）",

@"Large (+1)":
@"大（+1）",

@"Extra large (+2)":
@"特大（+2）",

@"Max (+3)":
@"最大（+3）",

@"Top":
@"顶部",

@"Middle":
@"中间",

@"Bottom":
@"底部",

@"Video Quality":
@"视频质量",

@"Quality":
@"清晰度",

@"Resolution":
@"分辨率",

@"Playback quality":
@"播放质量",

@"Quality picker":
@"清晰度选择器",

@"Enable quality picker":
@"启用清晰度选择器",

@"Force quality picker":
@"强制清晰度选择器",

@"Default quality":
@"默认清晰度",

@"Auto":
@"自动",

// =======================
// Download
// =======================


@"Download":
@"下载",

@"Downloads":
@"下载内容",

@"Enable Download":
@"启用下载",

@"Download button":
@"下载按钮",

@"Show download button":
@"显示下载按钮",

@"Hide download button":
@"隐藏下载按钮",



// =======================
// Playback
// =======================


@"Background Audio":
@"后台播放",



@"Enable Background Playback":
@"启用后台播放",

@"Playback Speed":
@"播放速度",

@"Speed":
@"速度",


@"Normal":
@"正常",

@"Slow":
@"慢速",

@"Fast":
@"快速",


@"Enable PiP":
@"启用画中画",

@"Picture in Picture":
@"画中画",

@"Disable PiP":
@"禁用画中画",



// =======================
// Player
// =======================


@"Fullscreen":
@"全屏",

@"Miniplayer":
@"小窗播放",


@"Hide fullscreen video title":
@"隐藏全屏视频标题",

@"Hide the video title displayed at the top left in fullscreen mode.":
@"隐藏全屏模式左上角显示的视频标题",


@"Show progress bar":
@"显示进度条",




// =======================
// Buttons
// =======================


@"Hide Subscribe button":
@"隐藏订阅按钮",

@"Hide Subscribe button in the action bar under the video overlay.":
@"隐藏视频覆盖层下方操作栏中的订阅按钮",


@"Hide Search button":
@"隐藏搜索按钮",

@"Hide Search button in the action bar under the video overlay.":
@"隐藏视频覆盖层下方操作栏中的搜索按钮",


@"Hide Menu button":
@"隐藏菜单按钮",


@"Hide More button":
@"隐藏更多按钮",



// =======================
// Sponsor / Ads
// =======================


@"SponsorBlock":
@"SponsorBlock",

@"Block Ads":
@"屏蔽广告",

@"Disable Ads":
@"关闭广告",

@"Remove Ads":
@"移除广告",

@"Skip Sponsors":
@"跳过赞助片段",



// =======================
// YouTube Settings
// =======================


@"YouTube Settings":
@"YouTube 设置",

@"FFmpeg failed": @"转码失败",

@"Advanced Settings":
@"高级设置",

@"Experimental":
@"实验功能",

@"Features":
@"功能",

@"Options":
@"选项",


@"Arabic": @"阿拉伯语",
@"كردي ناوەندی": @"中库尔德语",

@"French": @"法语",
@"Русский": @"俄语",
@"فارسی": @"波斯语",


// =======================
// Alerts
// =======================


@"Are you there?":
@"你还在吗？",

@"Continue watching":
@"继续观看",

@"Upgrade":
@"升级",

@"Update":
@"更新",
@"Enable Picture in Picture (PiP)": @"启用画中画（PiP）",
        @"Play video in a floating window outside the app": @"在应用外以悬浮窗口播放视频",

        @"Boost the app audio up to 200%. When enabled, swipe vertically along the right edge of the screen to adjust. Resets to 100% on each launch.": @"将应用音量提升至最高200%。启用后，在屏幕右侧边缘上下滑动即可调节。每次启动重置为100%。",

        @"Download Manager": @"下载管理器",
        @"DOWNLOADING": @"下载设置",
        @"Replaces YouTube's video downloader with the AlasdStore one. With ablity to downloading videos, audios, captions, and thumbnails": @"使用 AlasdStore 下载器替代 YouTube 下载器，支持下载视频、音频、字幕和缩略图",

        @"Automatically saves downloaded videos and images directly to your Photos app.": @"自动将下载的视频和图片保存到照片应用",
        @"Automatically save to Photos": @"自动保存到照片",

        @"Hide subbar": @"隐藏顶部栏",
        @"Hide subbar at the top of the feed.": @"隐藏主页顶部栏",

        @"Hide music playlist generator": @"隐藏音乐播放列表生成器",
        @"Hide music playlist generator (Select music tunes in three) in the feed.": @"隐藏主页中的音乐播放列表生成器（三选一音乐推荐）",

        @"Hide posts": @"隐藏帖子",
        @"Hide posts in feed.": @"隐藏信息流中的帖子",

        @"Hide Shorts shelf": @"隐藏 Shorts 栏",
        @"Hide Shorts shelf in the feed, including in the Subscriptions tab.": @"隐藏信息流中的 Shorts 栏，包括订阅页面",


        @"Hides the subscribe button in channels and video descriptions.": @"隐藏频道和视频描述中的订阅按钮",

        @"Hide Shopping button": @"隐藏购物按钮",
        @"Hides the shopping/store button in channels descriptions.": @"隐藏频道描述中的购物/商店按钮",

        @"Hide Membership button": @"隐藏会员按钮",
        @"Hides the 'Join' button in channels and video descriptions.": @"隐藏频道和视频描述中的“加入”按钮",

        @"PLAYER": @"播放器",

        @"Hide autoplay switch": @"隐藏自动播放开关",
        @"Hide autoplay switch in the video overlay.": @"隐藏视频控制层中的自动播放开关",

        @"Hide cast button": @"隐藏投屏按钮",
        @"Hide cast button in the video overlay.": @"隐藏视频控制层中的投屏按钮",

        @"Hide previous/back button": @"隐藏上一个/返回按钮",
        @"Hide previous/back button in the video overlay.": @"隐藏视频控制层中的上一个/返回按钮",

        @"Hide next/skip button": @"隐藏下一个/跳过按钮",
        @"Hide next/skip button in the video overlay.": @"隐藏视频控制层中的下一个/跳过按钮",

        @"Replace Previous/Next buttons": @"替换上一/下一按钮",
        @"Replaces the Previous and Next video buttons in the player with Rewind and Fast Forward buttons.": @"将播放器中的上一视频和下一视频按钮替换为快退和快进按钮",

        @"Remove dark overlay": @"移除暗色遮罩",
        @"emove dark overlay from the video overlay.": @"移除视频控制层中的暗色遮罩",


        @"Remove Ambient lights": @"移除环境光效果",
        @"Removes the glowing ambient lights effects behind the video player.": @"移除播放器后方的发光环境光效果",

@"Hide all YouTube ads": @"隐藏所有 YouTube 广告",

@"Hide 'Includes paid promotion'": @"隐藏“包含付费推广”提示",

@"Portrait fullscren mode": @"竖屏全屏模式",

@"Automatically skip the sensitive content warning alert in some vidoes.": @"自动跳过部分视频中的敏感内容警告提示",

@"BASIC OPTIONS": @"基本选项",




        @"Auto disable captions": @"自动关闭字幕",

        @"Navigation bar": @"导航栏",
        @"Hide YouTube logo": @"隐藏 YouTube 标志",
        @"Use YouTube Premium logo": @"使用 YouTube Premium 标志",

        @"Hide notification button": @"隐藏通知按钮",
        @"Hide search button": @"隐藏搜索按钮",
        @"Hide voice search button": @"隐藏语音搜索按钮",


@"Restore settings": @"恢复设置",
@"Import settings": @"导入设置",
@"Export settings": @"导出设置",


@"Basic Options": @"基础选项",

@"Keep audio playing after leaving the app": @"离开应用后继续播放音频",


@"VOLUME BOOST (UP TO 200%)": @"音量增强（最高200%）",
@"VOLUME_BOOST": @"音量增强",

@"Hide YouTube logo in the navigation bar.": @"隐藏导航栏中的 YouTube 标志",
@"Use YouTube Premium logo instead of normal YouTube logo.": @"使用 YouTube Premium 标志替代普通 YouTube 标志",

@"NAVIGATION BAR": @"导航栏",

@"Hide captions button": @"隐藏字幕按钮",
@"Hide captions button in the video overlay.": @"隐藏视频控制层中的字幕按钮",

@"Remove dark overlay from the video overlay.": @"移除视频控制层中的暗色遮罩",

@"Hide 'Includes paid promotion' in the video overlay.": @"隐藏视频控制层中的“包含付费推广”提示",

@"Disable remaining time": @"隐藏剩余时间",
@"Disable the feature that shows how much time is left in a video when tapping the timestamp.": @"禁用点击时间戳后显示剩余时间的功能",

@"Always show remaining time": @"始终显示剩余时间",
@"Ensure the remaining time is always displayed by default in the player overlay.": @"默认在播放器控制层始终显示剩余时间",

@"Hide fullscreen actions": @"隐藏全屏操作按钮",
@"Hide quick action buttons (Like, Dislike, More videos, etc.) when the video is in fullscreen mode.": @"视频全屏时隐藏快捷操作按钮（点赞、点踩、更多视频等）",

@"Hide video title shown at the top left corner in fullscreen mode.": @"隐藏全屏模式左上角显示的视频标题",

@"Disable autoplay": @"禁用自动播放",
@"Prevent the video in playing automatically when opening the video.": @"打开视频时阻止自动播放",

@"Skip content warning": @"跳过内容警告",
@"Automatically skip the sensitive content warning alert in some videos.": @"自动跳过部分视频中的敏感内容警告",

@"Auto fullscreen": @"自动全屏",
@"Automatically enter fullscreen mode when starting video playback.": @"开始播放视频时自动进入全屏模式",

@"Portrait fullscreen mode": @"竖屏全屏模式",
@"Enables portrait fullscreen mode support.": @"启用竖屏全屏模式支持",


@"Disable captions": @"禁用字幕",
@"Automatically turns off closed captions (CC) whenever a new video starts playing.": @"每次开始播放新视频时自动关闭字幕",


@"Hide endscreen cards": @"隐藏结束画面卡片",
@"Hide endscreen cards shown before the video ends.": @"隐藏视频结束前显示的结束画面卡片",

@"Hide suggested videos": @"隐藏推荐视频",
@"Hide the grid of suggested videos that appears when a video finishes playing.": @"隐藏视频播放结束后显示的推荐视频列表",

@"Hide watermark": @"隐藏水印",
@"Hide channel watermark at the bottom of the video overlay.": @"隐藏视频控制层底部的频道水印",

@"Enable gestures controls": @"启用手势控制",
@"Swipe up or down on the left/right edges of the video screen to adjust brightness, volume, or playback speed.": @"在视频左右边缘上下滑动调节亮度、音量或播放速度",

@"Show gesture HUD": @"显示手势提示",
@"Displays the current percentage (%) on the screen when adjusting brightness, volume, or playback speed.": @"调节亮度、音量或播放速度时显示当前百分比",

@"Disables double tap": @"禁用双击",
@"Disables double tap to seek in the video overlay.": @"禁用视频控制层双击快进/快退",

@"Disables long hold": @"禁用长按",
@"Disables long hold to speed up the video in the video overlay.": @"禁用长按倍速播放",

@"Auto exit fullscreen": @"自动退出全屏",
@"Video saved to ASD Tools":
@"视频已保存到 ASD 工具",

@"Audio saved to ASD Tools":
@"音频已保存到 ASD 工具",

@"Failed to save to library":
@"保存到照片失败",

@"Save to Camera Roll":
@"保存到照片",

@"Gesture activation area":
@"手势触发区域",

@"Adjust the text and icon size of the gesture HUD.":
@"调整手势提示框中的文字和图标大小。",

@"Set the vertical position of the gesture HUD (Top, Middle, Bottom).":
@"设置手势提示框的垂直位置（顶部、中间、底部）。",

@"Gesture HUD size":
@"手势提示框大小",

@"Gesture HUD position":
@"手势提示框位置",

@"Adjust the area on the edges where gestures are active. (Setting to 50% splits the screen in half with no dead zone in the middle.)":
@"调整屏幕边缘手势触发范围。（设置为 50% 时，屏幕左右两侧各占一半，中间无无效区域。）",

@"Left side swipe gesture":
@"左侧滑动手势",

@"Right side swipe gesture":
@"右侧滑动手势",

@"You can select the tab you want to open when opening the app.":
@"你可以选择打开应用时默认显示的标签页。",

@"Default startup tab":
@"默认启动标签页",

@"Warning":
@"警告",

@"This will reset all settings to default. Do you want to continue?":
@"这将恢复所有设置为默认值，是否继续？",

@"Yes":
@"确定",

@"This will override the current settings. Do you want to continue?":
@"这将覆盖当前设置，是否继续？",

@"Hide search history": @"隐藏搜索历史",
@"Hide previous search history and suggestions when using the search bar.\nNOTE: Your search history will still be accessible in your other YouTube clients.": @"隐藏使用搜索栏时的历史记录和搜索建议。\n注意：你的搜索历史仍可在其他 YouTube 客户端中访问。",
@"Feed": @"主页",
@"Player": @"播放器",

@"AlasdStore preferences": @"AlasdStore 偏好设置",

@"Settings ": @"设置",
@"Settings": @"设置",
@" Settings": @"设置",
@"Volume Boost (up to 200%)": @"音量增强（最高200%）",

@"Cache management": @"缓存管理",
@"Clear cache": @"清除缓存",
@"Auto clear cache": @"自动清理缓存",
@"Automatically clears the app cache on startup.": @"启动时自动清除应用缓存",

@"تنزيل الفيديو": @"下载视频",
@"اختر الجودة": @"选择画质",
@"تنزيل الصوت": @"下载音频",
@"اختر الصيغة": @"选择格式",
@"تنزيل الترجمة": @"下载字幕",

@"نسخ التشخيص": @"复制诊断信息",

@"حفظ في الصور": @"保存到照片",

@"تم نسخ معلومات الفيديو": @"视频信息已复制",

    
    // 英文
    @"Download video": @"下载视频",
    @"Download audio": @"下载音频",
    @"Download subtitles": @"下载字幕",
    @"Save thumbnail": @"保存缩略图",
    @"Copy video info": @"复制视频信息",

@"Lossy (192k)": @"有损音质 (192k)",
@"Lossy, widely compatible": @"有损音质（兼容性最佳）",
@"Lossy, small file size": @"有损音质（文件较小）",
@"Vorbis lossy": @"Vorbis 有损格式",
@"Lossless compressed": @"无损压缩",
@"Apple lossless (M4A)": @"Apple 无损格式 (M4A)",
@"Uncompressed PCM": @"未压缩 PCM",
@"AAC container, passthrough when possible": @"AAC 容器（支持时直接传输）",
@"Saved to Photos": @"已保存到照片",


@"Disables snack bar when pressing some buttons or doing something in the app.": @"点击按钮或执行操作时禁用底部提示条",
@"Auto-scroll on": @"已开启自动播放",
@"Auto-scroll off": @"已关闭自动播放",
@"Screen elements hidden": @"已隐藏界面元素",
@"Screen elements shown": @"已显示界面元素",

@"Make the keyboard uses a pure black (OLED) color for dark theme.": @"让键盘深色主题使用纯黑（OLED）颜色",

@"Video": @"视频",
@"Audio": @"音频",

@"Appearance": @"外观",
@"Miscellaneous": @"其他",
@"Preferences": @"偏好设置",
@"Automatically exit fullscreen after the video ends.": @"视频结束后自动退出全屏",

@"Prefer DRC Audio": @"优先使用 DRC 音频",

@"Hide notification button in the navigation bar.": @"隐藏导航栏中的通知按钮",
@"Hide search button in the navigation bar.": @"隐藏导航栏中的搜索按钮",
@"Hide voice search button in the navigation bar.": @"隐藏导航栏中的语音搜索按钮",
@"Hide cast button in the navigation bar.": @"隐藏导航栏中的投屏按钮",

@"Downloading": @"下载中",

@" Volume Boost (up to 200%)": @"音量增强（最高200%）",

@"Tab bar": @"标签栏",

@"Load your preferences in a .plist file.": @"从 .plist 文件加载你的偏好设置",
@"Send out your preferences to a .plist file.": @"将你的偏好设置导出为 .plist 文件",
@"Load default settings like in fresh install.": @"加载全新安装时的默认设置",

@"Perferences": @"偏好设置",

@"Enable the ASD Tools download manager": @"启用 ASD Tools 下载管理器",

@"Disable the tutorial hints and interactive pop-ups.": @"禁用教程提示和交互式弹窗",




@"Hide the Like button in the Shorts player.": @"隐藏 Shorts 播放器中的点赞按钮",
@"Hide the Dislike button in the Shorts player.": @"隐藏 Shorts 播放器中的点踩按钮",
@"Hide the Share button in the Shorts player.": @"隐藏 Shorts 播放器中的分享按钮",
@"Hide the Remix button in the Shorts player.": @"隐藏 Shorts 播放器中的 Remix 按钮",



@"Hide Home tab in the tab bar.": @"隐藏标签栏中的主页标签",
@"Hide Shorts tab in the tab bar.": @"隐藏标签栏中的 Shorts 标签",
@"Hide Create button in the tab bar.": @"隐藏标签栏中的创建按钮",
@"Hide Subscriptions tab in the tab bar.": @"隐藏标签栏中的订阅标签",

@"Disables new miniplayer": @"禁用新版小窗播放器",
@"Use the old-style miniplayer instead of the new one, this only works in older YouTube versions.": @"使用旧版小窗播放器替代新版，仅适用于较旧的 YouTube 版本",

@"Disables snack bar": @"禁用提示条",
   

@"Hide YouTube's startup animations": @"隐藏 YouTube 启动动画",
@"Hide YouTube's startup animations when opening the app.": @"打开应用时隐藏 YouTube 启动动画",

@"Hide 'Play next in queue'": @"隐藏“加入播放队列”",
@"Hide the 'Play next in queue' option in the flyout menu.": @"隐藏弹出菜单中的“加入播放队列”选项",



@"Some hiding features may leave a blank box.": @"部分隐藏功能可能会留下空白区域",

@"NOTE: Some hiding features may leave a blank box.": @"注意：部分隐藏功能可能会留下空白区域",
@"🇸🇦   العربية": @"🇸🇦   阿拉伯语",

@"🇬🇧   English": @"🇬🇧   英语",

@"🇻🇳   Tiếng Việt": @"🇻🇳   越南语",

@"🇪🇸   Español": @"🇪🇸   西班牙语",

@"🇫🇷   Français": @"🇫🇷   法语" ,

@"🌐   Automatic (device)": @"🌐   自动（跟随设备）",

@"Русский 🇷🇺": @"俄语 🇷🇺",

@"Deutsch":
@"德语",

// =======================
// Translation test
// =======================


@"Test Language":
@"测试语言",

@"Chinese":
@"中文",

@"Chinese Simplified":
@"简体中文",

       // =======================
       //        iQTube
       // =======================

// Wolf / Video Player

@"Library":
@"媒体库",

@"Add to Wolf Queue":
@"添加到 Wolf 队列",

@"Watch Later Locally":
@"稍后本地观看",

@"A-B Repeat":
@"A-B 重复播放",

@"Audio Mode":
@"音频模式",

@"Translating transcript...":
@"正在翻译字幕",

@"Translating transcript…":
@"正在翻译字幕",

@"Transcript is unavailable for this video.":
@"此视频字幕不可用。",

@"Clear A-B Repeat":
@"清除 A-B 重复播放",

@"No transcript is available for this video.":
@"此视频没有可用字幕。",

@"Search Inside Video":
@"搜索视频内容",

@"Copy Link":
@"复制链接",

@"Share with Timestamp":
@"分享时间戳",

@"BRAIN ROT PROTECTION":
@"防沉迷保护",

@"Prevent doom scrolling":
@"防止长时间刷视频",

@"Download dubbed audio":
@"下载配音音轨",
// Wolf Video Player

@"Timestamped link copied":
@"带时间戳的链接已复制",

@"Video Mode restored":
@"视频模式已恢复",

@"A-B start saved":
@"A-B 起点已保存",

@"A-B end saved":
@"A-B 终点已保存",

@"Start A-B Repeat":
@"开始 A-B 重复播放",

@"Set Start • 01:50":
@"设置开始 • 01:50",

@"Set End • 01:50":
@"设置结束 • 01:50",

@"Added to Wolf Queue":
@"已添加到 Wolf 队列",

@"Saved to Watch Later Locally":
@"已保存到本地稍后观看",

@"Loading transcript...":
@"正在加载字幕...",

@"Loading transcript…":
@"正在加载字幕...",

@"Transcript copied":
@"字幕已复制",


@"Wolf Transcript":
@"Wolf 字幕",

@"Translate":
@"翻译",

@"Copy All":
@"复制全部",

@"Search inside video":
@"搜索视频内容",
@"Video Mode":
@"视频模式",

@"Shorts Auto Scroll enabled":
@"Shorts 自动播放已启用",

@"Disable Auto Scroll":
@"关闭自动播放",

@"Enable Auto Scroll":
@"启用自动播放",


// Wolf Video Player

@"Link copied":
@"链接已复制",

@"Shorts Auto Scroll disabled":
@"Shorts自动播放已关闭",

@"Open Transcript":
@"打开字幕",

@"A-B Repeat cleared":
@"A-B 重复播放已清除",

@"Audio Mode enabled":
@"音频模式已启用",

@"iQTube Settings":
@"iQTube 设置",

@"Mode":
@"模式",

@"Shorts per session — 10":
@"每次会话 Shorts 数量 — 10",

@"Shorts per session — %ld":
@"每次会话 Shorts 数量 — %ld",

@"Session":
@"会话",

@"Daily":
@"每日",

@"Time window":
@"时间范围",

@"Disable Shorts":
@"禁用 Shorts",

@"Shorts per session":
@"每次会话 Shorts 数量",

@"Playback & Quality":
@"播放与画质",

@"Not enough space on the device.":
@"设备空间不足。",

@"Needed":
@"需要",

@"Free":
@"可用",

@"Download button on videos":
@"视频下载按钮",

@"Replace YouTube's download button":
@"替换 YouTube 下载按钮",

@"Save location":
@"保存位置",

@"Download quality":
@"下载画质",

@"Choose quality":
@"选择画质",

@"Choose audio quality":
@"选择音频质量",

@"Save to Photos":
@"保存到照片",

@"Save in app":
@"保存到应用",

@"Share / Save":
@"分享 / 保存",

@"Downloaded":
@"已下载",

@"Shorts":
@"短视频",

@"Back":
@"返回",
@"Download failed":
@"下载失败",

@"Save failed":
@"保存失败",

@"FFmpegKit unavailable for audio conversion"
    : @"音频转换功能不可用",

@"FFmpegKit not loaded, diagnostics copied"
    : @"FFmpegKit 未加载，诊断信息已复制",

@"FFmpegKit required for %@"
    : @"%@ 需要 FFmpegKit",

@"Converting to %@"
    : @"正在转换为 %@",

@"FFmpegKit required for this stream"
    : @"此音频流需要 FFmpegKit",

@"No downloads yet.":
@"暂无下载",

@"No downloads here yet.":
@"暂无下载记录",

@"Where to save?":
@"保存位置",

@"Reopen the app to apply all settings.":
@"重新打开应用以应用设置",

@"Plays":
@"播放",

@"Play":
@"播放",

@"Rename":
@"重命名",

@"Delete":
@"删除",

@"New name (without extension)":
@"新名称（不含扩展名）",

@"Continue":
@"继续",

@"File name":
@"文件名",
@"ABOUT":
@"关于",
@"Preparing...":
@"准备中",

@"فشل تنزيل الصوت":
@"音频下载失败",



@"Play a video for a moment, then tap download.":
@"播放视频片刻后，再点击下载",


@"Edit the save name (without extension):":
@"编辑保存名称（不包含扩展名）",

@"That is not an iQTube backup.":
@"这不是 iQTube 备份",

@"Settings could not be saved":
@"设置保存失败",

@"Download cancelled":
@"下载已取消",

@"Open video":
@"打开视频",

@"Write video":
@"写入视频",

@"Saved to Files." :
@"已保存到文件",


@"No video" :
@"没有视频",


@"Save to Photos / Share" :
@"保存到照片 / 分享",

@"%lu downloads" :
@"%lu 个下载",

@"iQTube.download" :
@"iQTube 下载",

@"YouTube_%@.%@" :
@"YouTube_%@.%@",




@"Skip in-video segments" :
@"跳过视频片段",

@"Remplacer le bouton de YouTube" :
@"替换 YouTube 按钮",



@"Downloader" :
@"下载器",

@"ConfigureSettingsPanel" :
@"配置设置面板",

@"Downloads/" :
@"下载目录",

@"downloads" :
@"下载",

@"downloads.log" :
@"下载日志",

@"iQTube-Backup-%@" :
@"iQTube备份-%@",

@"iQTube.backup" :
@"iQTube备份",

@"iQTubeBackups" :
@"iQTube备份",

@"SettingsBackup.plist" :
@"设置备份文件",



@"Audio quality" :
@"音频质量",

@"Video quality" :
@"视频画质",

@"High quality" :
@"高质量",

@"Quality stats" :
@"质量统计",



@"Save to Both" :
@"同时保存",



@"Save to Files" :
@"保存到文件",

@"Share" :
@"分享",


@"Retry" :
@"重试",

@"Failed" :
@"失败",

@"Success" :
@"成功",

@"Progress" :
@"进度",

@"Saved Samples":
@"已保存样本",

@"Export full XMP metadata":
@"导出完整 XMP 元数据",

@"Export unrecognized metadata entries":
@"导出未识别的元数据条目",

@"Delete all Padding OBUs":
@"删除所有填充 OBUs",

@"Delete all filler (both NAL and SEI)":
@"删除所有填充数据（NAL 和 SEI）",

@"Export metadata as side data":
@"将元数据导出为附加数据",


@"Export failed":
@"导出失败",


@"Import failed":
@"导入失败",


@"Exporter la sauvegarde":
@"导出备份",

@"Importer la sauvegarde":
@"导入备份",


@"Download Options" :
@"下载选项",

@"Download Settings" :
@"下载设置",

@"Download location" :
@"下载位置",

@"Download folder" :
@"下载文件夹",

@"Save name" :
@"保存名称",


@"Select quality" :
@"选择画质",

@"Select audio quality" :
@"选择音频质量",


@"Legacy Quality Menu" :
@"旧版画质菜单",

@"Downloads Layout" :
@"下载布局",

@"Downloads Sort" :
@"下载排序",

@"Background PiP" :
@"后台画中画",


@"Transcript translated":
@"字幕翻译完成",

@"Interface":
@"界面",

@"Backup":
@"备份",

@"Export backup":
@"导出备份",

@"Import backup":
@"导入备份",

@"copy":
@"复制",

@"audio":
@"音频",

@"video":
@"视频",

@"View Options":
@"查看选项",

@"Layout":
@"布局",

@"Sort":
@"排序",

@"Cards":
@"卡片",

@"List":
@"列表",

@"Grid":
@"网格",

@"Newest":
@"最新",

@"Oldest":
@"最旧",

@"Largest":
@"最大",

@"Smallest":
@"最小",

@"Select all":
@"全选",

@"FEATURES":
@"功能",

@"Developer":
@"开发者",

@"TOOLS":
@"工具",

@"Background playback (PiP)":
@"后台播放（画中画）",

@"Fix playback issues":
@"修复播放问题",

@"Language":
@"语言",

@"Follow system":
@"跟随系统",

@"Smart Block":
@"智能屏蔽",

@"Smart Block (creator ads)":
@"智能屏蔽（创作者广告）",

@"Auto-skip":
@"自动跳过",

@"Show skip notice":
@"显示跳过提示",

@"Show on progress bar":
@"显示在进度条上",

@"SEGMENTS TO SKIP":
@"跳过片段",

@"sponsor":
@"赞助内容",

@"Skip":
@"跳过",

@"Self-promotion":
@"自我推广",

@"Interaction reminder":
@"互动提醒",

@"Intro":
@"片头",

@"Outro":
@"片尾",

@"Preview / recap":
@"预览 / 回顾",

@"Filler":
@"填充内容",

@"Default folder": @"默认文件夹",
@"Ask for folder before saving": @"保存前询问文件夹",
//@"No folder": @"不使用文件夹",
@"Progress style": @"进度样式",
@"Keep downloading after leaving": @"离开后继续下载",
@"Customise iQ buttons": @"自定义 iQ 按钮",
@"Bar": @"进度条",
@"Do nothing": @"不执行任何操作",
@"Circle": @"圆形",
@"Full menu": @"完整菜单",
@"Show this button": @"显示此按钮",
@"Tap": @"轻点",
@"Long press": @"长按",
@"Folders": @"文件夹",
@"Search": @"搜索",
@"New folder": @"新建文件夹",
@"Folder name:": @"文件夹名称：",
@"Move to folder…": @"移动到文件夹…",
@"LIBRARY": @"资料库",
@"VIDEO": @"视频",
@"Off-topic music":
@"无关音乐",
@"Shorts controls": @"Shorts 控制",
@"Separate buttons": @"独立按钮",
@"One iQ button": @"一个 iQ 按钮",
@"No folder": @"无文件夹",

@"Ask for name before saving":
@"保存前询问文件名",

@"High qualities (1440p / 4K)":
@"高画质（1440p / 4K）",

@"Always ask":
@"始终询问",

@"In app":
@"应用内",

@"Device (Photos)":
@"设备（照片）",

@"Both":
@"两者",

@"Ask every time":
@"每次询问",

@"Highest":
@"最高",

@"Join Telegram channel":
@"加入 Telegram 频道",

@"Auto-scroll Shorts":
@"自动播放Shorts",

@"Hide Shorts screen elements":
@"隐藏 Shorts 界面元素",

@"Copied":
@"已复制",

@"Copy description":
@"复制描述",

@"ON":
@"开启",

@"on":
@"开启",



@"OFF":
@"关闭",

@"off":
@"关闭",
@"Copy":
@"复制",

@"Hide end-screen cards":
@"隐藏结束卡片",

@"Hide Shorts":
@"隐藏 Shorts",

@"Premium logo":
@"Premium 标志",

@"Copy title":
@"复制标题",

@"Copy link":
@"复制链接",
@"Saved in app ✓":
@"已保存到应用 ✓",

@"موجود في ملفات التطبيق (iQTube).":
@"已存在于应用文件中（iQTube）。",

@"حسناً": @"好的",

//ASJTube
@"My library" : @"我的媒体库",
@"Search library" : @"搜索媒体库",
@"Playlists" : @"播放列表",
@"Watch later" : @"稍后观看",
@"Videos saved with ASJTube appear here." : @"使用 ASJTube 保存的视频会显示在这里。",
@"Audio saved with ASJTube appears here." : @"使用 ASJTube 保存的音频会显示在这里。",
@"No audio yet" : @"暂无音频",
@"No playlists yet" : @"暂无播放列表",
@"Make one from anything in your library." : @"从媒体库中的内容创建一个播放列表。",
@"Nothing saved yet" : @"暂无保存内容",
@"Hold the player and choose Watch later." : @"长按播放器，然后选择“稍后观看”。",
@"Autoplay next" : @"自动播放下一个视频",
@"New playlist" : @"新建播放列表",
@"Back up library" : @"备份媒体库",
@"Restore backup" : @"恢复备份",
@"Import from Files" : @"从“文件”导入",
@"folder" : @"文件夹",
@"Delete all" : @"全部删除",
@"Imported %lu" : @"已导入 %lu 项",
@"Name" : @"名称",
@"Create" : @"创建",
@"New playlist..." : @"新建播放列表…",
@"Nothing to back up" : @"没有可备份的内容",
@"Not enough free space to back up" : @"可用空间不足，无法备份",
@"Photo" : @"照片",
@"Transcript" : @"文字稿",
@"Tap to cancel" : @"轻点以取消",
@"Tap to dismiss" : @"轻点以关闭",
@"Could not undo" : @"无法撤销",
@"Could not save" : @"无法保存",
@"Other" : @"其他",
@"Media" : @"媒体",
@"No lyrics were found for this track." : @"未找到这首歌曲的歌词。",
@"Videos and audio saved on this device." : @"保存在此设备上的视频和音频。",
@"Background Playback" : @"后台播放",
@"Keeps audio going when the app is backgrounded or the screen locks." : @"切换到后台或锁定屏幕后继续播放音频。",
@"Autoplay video when is finished" : @"视频播放结束后自动播放",
@"Repeats the current video instead of moving to the next." : @"重复播放当前视频，而不是播放下一个视频。",
@"Remove recommended videos at the end" : @"移除视频末尾的推荐视频",
@"Removes the grid of suggested videos that covers the video as it ends, along with its hide button." : @"移除视频结束时出现的推荐视频网格及其隐藏按钮。",
@"Watch videos in high quality" : @"以高画质观看视频",
@"Pins the player to the best rendition the video has, instead of letting it settle for whatever the connection suggests. On a slow connection it buffers rather than dropping quality." : @"始终使用视频提供的最高画质，而不是根据网络状况自动调整。在网络较慢时会缓冲，而不会降低画质。",
@"Enable Picture in Picture" : @"启用画中画",
@"Keeps the video in a floating window when you leave the app - YouTube's videos and the library's own files both. It starts on its own; there is no button to press. While this is on, YouTube's own Picture in Picture row is hidden, because the setting that decides it is this one." : @"离开应用后，视频会继续以浮动窗口播放，包括 YouTube 视频和媒体库中的文件。无需点击按钮即可自动开启。启用此选项后，YouTube 自带的“画中画”设置项将被隐藏，因为此设置会统一控制画中画功能。",
@"Show progress bar in Shorts" : @"在 Shorts 中显示进度条",
@"Keeps the scrubber visible instead of hiding it until you touch the screen." : @"始终显示进度条，而不是触摸屏幕后才显示。",
@"Adds a lyrics button to the library player. Looks the track title up on lrclib.net when you tap it." : @"在媒体库播放器中添加歌词按钮。点击后会在 lrclib.net 上搜索歌曲名称。",
@"Spoken language" : @"视频语言",
@"The language being spoken in the clip. This one is worth getting right - the wrong answer here is what turns a translation into nonsense." : @"视频中使用的语言。请确保选择正确，否则翻译结果可能会完全失真。",
@"Translate into" : @"翻译成",
@"Install the pair once in Settings, Apps, Translate, Downloaded Languages - iOS will not download one without being asked there." : @"请先在“设置”>“App”>“翻译”>“已下载的语言”中下载对应语言。iOS 不会自动下载未指定的语言。",
@"Copy text" : @"复制文本",
@"When enabled, you can copy the title, description, comments, and posts." : @"启用后，可以复制标题、简介、评论和帖子内容。",
@"No downloads yet" : @"暂无下载",
@"Removes the Shorts tab and drops Shorts shelves from the feed." : @"移除 Shorts 标签页，并从信息流中隐藏 Shorts 内容栏。",
@"Open the app on Shorts" : @"打开应用时进入 Shorts",
@"Starts on the Shorts tab instead of Home. It only chooses the opening tab - you can move anywhere from there." : @"打开应用时直接进入 Shorts 标签页，而不是首页。此选项只决定启动时显示的标签页，之后仍可前往其他页面。",
@"Hide create video button" : @"隐藏创建视频按钮",
@"Removes the centre + from the tab bar." : @"移除标签栏中央的“+”按钮。",
@"Require Face ID to open" : @"打开时需要 Face ID",
@"Covers the app the moment it leaves the screen - including the picture the app switcher shows - and asks for Face ID, Touch ID or the passcode on the way back." : @"应用离开屏幕后立即隐藏内容，包括 App 切换器中显示的预览画面。返回应用时需要使用 Face ID、Touch ID 或密码解锁。",
@"Open links in Safari" : @"在 Safari 中打开链接",
@"Uses Safari instead of the in-app browser." : @"使用 Safari 打开链接，而不是应用内浏览器。",
@"Clear Screen": @"清空屏幕",
@"Manual Scroll": @"自动播放已关闭",
@"Auto Scroll": @"自动播放",
@"Shorts will play again instead": @"Shorts 将循环播放",
@"Shorts will scroll on their own": @"Shorts 将自动播放",
@"Later": @"稍后",
@"Relaunch": @"重新启动",
@"Removes ads that appear at the beginning and during the videos." : @"移除视频开始前和播放期间显示的广告。",
@"ASJ Tweaks" : @"ASJ Tweaks",
@"Support me, keep it growing" : @"支持我，让它继续成长",
@"Lyrics" : @"歌词",

@"This device lists no languages it can transcribe." : @"此设备没有可用于转录的语言。",
@"This device lists no languages it can translate into." : @"此设备没有可用于翻译的语言。",
@"Download Video" : @"下载视频",
@"Download Audio" : @"下载音频",
@"Download Photo" : @"下载图片",
@"Reopen YouTube to apply this change" : @"重新打开 YouTube 以应用此更改",
@"Preparing backup..." : @"正在准备备份…",
@"Backup failed" : @"备份失败",
@"Backup ready" : @"备份已准备就绪",

@"Preparing download" : @"正在准备下载",
@"Downloading video" : @"正在下载视频",
@"Downloading audio" : @"正在下载音频",
@"Processing" : @"正在处理",
@"Merge failed" : @"合并失败",
@"Download finished" : @"下载完成",
@"Cancelled" : @"已取消",
@"Nothing to download" : @"没有可下载的内容",
@"Nothing to download yet" : @"暂无可下载内容",
@"Not enough free space for this download" : @"可用空间不足，无法下载",
@"Needs %@ free, you have %@" : @"需要 %@ 可用空间，当前有 %@",
@"Saving thumbnail..." : @"正在保存缩略图…",
@"Thumbnail saved" : @"缩略图已保存",
@"Could not fetch thumbnail" : @"无法获取缩略图",
@"No thumbnail available" : @"没有可用的缩略图",
@"Saved to My library" : @"已保存到“我的媒体库”",
@"Saved to Photos and My library" : @"已保存到“照片”和“我的媒体库”",
@"Could not save the file" : @"无法保存文件",
@"Could not process the audio" : @"无法处理音频",
@"Could not process the video" : @"无法处理视频",
@"The downloaded streams have no usable tracks." : @"下载的视频流中没有可用的轨道。",
@"The video and audio downloads do not overlap." : @"下载的视频和音频无法匹配。",
@"Deleted:" : @"已删除：",
@"Undo available for %d seconds" : @"可撤销，剩余 %d 秒",
@"Already downloaded" : @"已下载",
@"Undo" : @"撤销",
@"This is already in your library. Download it again?" : @"此内容已在你的媒体库中。要再次下载吗？",
@"Untitled playlist" : @"未命名播放列表",
@"Saved to Watch later" : @"已保存到“稍后观看”",
@"Removed from Watch later" : @"已从“稍后观看”中移除",
@"Nothing is playing" : @"当前没有正在播放的内容",
@"Copy link with time" : @"复制带时间戳的链接",
@"Restoring..." : @"正在恢复…",
@"Library restored" : @"媒体库已恢复",
@"Nothing to restore" : @"没有可恢复的内容",
@"Locked" : @"已锁定",
@"Loading transcript" : @"正在加载文字稿",
@"Loop start set" : @"循环起点已设置",
@"Looping" : @"循环播放中",
@"Player locked. Long press to unlock." : @"播放器已锁定。长按以解锁。",
@"Set the end further along" : @"将循环终点设置得更靠后",
@"Go to time" : @"跳转到指定时间",
@"Enter a timestamp such as 01:34:20." : @"请输入时间戳，例如 01:34:20。",
@"Enter a valid time." : @"请输入有效的时间。",
@"Player unlocked" : @"播放器已解锁",
@"Transcript data is unavailable for this video." : @"此视频的文字稿数据不可用。",
@"Seeking is not available for this video." : @"此视频不支持拖动进度。",
@"Open a video and try again." : @"打开视频后重试。",
@"Open" : @"打开",
@"Remove" : @"移除",
@"Unlock YouTube" : @"解锁 YouTube",
@"Copy all" : @"全部复制",
@"Add to playlist" : @"添加到播放列表",
@"Pin" : @"置顶",
@"Unpin" : @"取消置顶",
@"Translation" : @"翻译结果",
@"Thanks for installing ASJTube." : @"感谢安装 ASJTube。",
@"Enjoy!" : @"尽情享用！",
@"OK" : @"好",
@"Links in description" : @"简介中的链接",
@"No links were found in the description." : @"简介中未找到链接。",
@"This video does not have a description." : @"此视频没有简介。",
@"Save picture" : @"保存图片",
@"Save channel picture" : @"保存频道图片",
@"Largest first - the widest one is usually the channel banner." : @"按尺寸从大到小排列，最宽的图片通常是频道横幅。",
@"Original size" : @"原始尺寸",
@"The picture could not be downloaded." : @"无法下载图片。",
@"Open a channel first, then try again." : @"请先打开频道，然后重试。",
@"stopped at %@" : @"停止于 %@",
@"Use device passcode" : @"使用设备密码",
@"Always start in the original audio" : @"始终使用原始音频",
@"Stops YouTube opening a video in an automatically dubbed language. The dubbed tracks are still there - pick one from the player's settings whenever you want it." : @"阻止 YouTube 自动以配音语言播放视频。配音音轨仍然保留，你可以随时在播放器设置中选择所需的音轨。",
                           //Cercube
            @"AUDIO": @"音频",
            @"Cached videos appear here": @"缓存的视频会显示在这里",
            @"Cercube Settings": @"Cercube 设置",
            @"Hide advertisements": @"隐藏广告",
            @"This option hides the advertisements globally in the app": @"此选项会在整个应用中隐藏广告",
            @"Add dislike count": @"显示点踩数量",
            @"Show dislikes count for videos": @"显示视频的点踩数量",

            @"Playback": @"播放",
            @"Skip sponsored segments": @"跳过赞助片段",
            @"Automatically skip sponsored segments in videos": @"自动跳过视频中的赞助片段",
            @"Auto replay": @"自动重播",
            @"This option indefinitely replays the same video once it finishes playing": @"视频播放结束后自动无限循环播放",

            @"Quality on Wi-Fi": @"Wi-Fi 画质",
            @"Quality on Mobile Data": @"移动网络画质",
            @"Cache": @"缓存",
            @"Highest quality": @"最高画质",
            @"Duration": @"保存时间",
            @"7 days": @"7 天",

            @"Couldn't Record Agreement": @"无法记录协议",
            @"Check your internet connection and try again.": @"请检查你的网络连接，然后重试。",
            @"Customization": @"自定义",
            @"Actions button": @"操作按钮",
            @"Player controls": @"播放器控件",
            @"Tabs layout": @"标签栏布局",
            @"Help": @"帮助",
            @"Follow us on X": @"在 X 上关注我们",
            @"Get support and the latest updates by following us.": @"关注我们，获取帮助和最新动态。",
            @"Follow @CercubeTweak": @"关注 @CercubeTweak",
            @"Use Instagram?": @"使用 Instagram？",
            @"Try out Rocket: the all-in-one tweak for Instagram with advanced privacy controls.": @"试试 Rocket：一款功能全面的 Instagram 插件，提供高级隐私控制功能。",
            @"Get it for free": @"免费下载",
            @"Automatically replay the same video once it finishes playing": @"视频播放结束后自动重播",
            @"Keep playing when the screen is locked or the app is in the background": @"锁定屏幕或应用在后台运行时继续播放",
            @"Pause caching": @"暂停缓存",
            @"Supercharge your YouTube experience!": @"全面提升 YouTube 使用体验！",

            @"cercube-launch-consent-page": @"Cercube 启动授权页面",
            @"Cleaning up...": @"正在清理...",
            @"Added to cache.": @"已添加到缓存。",
            @"What's new": @"最新动态",
            @"What's new in Cercube": @"Cercube 更新内容",
            @"Restart caching": @"重新缓存",
            @"Play on YouTube": @"在 YouTube 播放",
            @"Go to Channel": @"前往频道",
            @"By using this tweak, you agree to the full ": @"使用此插件，即表示你同意完整的",
            @"terms of service.": @"服务条款。",
            @"What's new\nin Cercube": @"Cercube 更新内容",
            @"What's new\r\nin Cercube": @"Cercube 更新内容",
            @"Dislike counts": @"不喜欢数量",
            @"Add dislike counts to be displayed for currently playing videos.": @"为当前播放的视频显示不喜欢数量。",
            @"Available in 14 languages": @"支持 14 种语言",
            @"Enjoy Cercube in your preferred language.": @"使用你偏好的语言体验 Cercube。",
            @"Customize your tab bar": @"自定义标签栏",
            @"Rearrange tab bar items and hide the ones you don't use.": @"重新排列标签栏项目，并隐藏不使用的项目。",
            @"High quality formats": @"高画质格式",
            @"Enjoy playback in higher quality with up to AV1 format in 4K.": @"享受更高画质的播放，最高支持 4K AV1 格式。",
            @"Error" : @"错误",
            @"Broken pipe. (3)" : @"管道连接已断开。(3)",
            @"DISMISS" : @"关闭",
            @"Cast button" : @"投屏按钮",
            @"Re-arrange tabs by long pressing on a tab and dragging it left or right" : @"长按标签并向左或向右拖动，即可重新排列标签栏",
            @"Restore defaults" : @"恢复默认设置",
            @"Automatically skip sponsored segments in videos." : @"自动跳过视频中的赞助片段。",            @"Other tweaks": @"其他插件",
            @"Cache this video": @"缓存此视频",
            @"Start Picture-in-Picture": @"开始画中画"



};


        NSString *dictionaryResult = table[text];

        if (dictionaryResult)
        {
            return dictionaryResult;
        }


        return translatedText;
        }
