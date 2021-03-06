package WordList::Char::ZH::HSK5;

our $DATE = '2016-02-04'; # DATE
our $VERSION = '0.01'; # VERSION

use utf8;

use WordList;
our @ISA = qw(WordList);

our %STATS = ("num_words_contains_whitespace",0,"num_words_contains_unicode",621,"num_words",621,"shortest_word_len",1,"longest_word_len",1,"avg_word_len",1,"num_words_contains_nonword_chars",0); # STATS

1;
# ABSTRACT: HSK (level 5 only) characters

=pod

=encoding UTF-8

=head1 NAME

WordList::Char::ZH::HSK5 - HSK (level 5 only) characters

=head1 VERSION

This document describes version 0.01 of WordList::Char::ZH::HSK5 (from Perl distribution WordList-ZH-HSK), released on 2016-02-04.

=head1 SYNOPSIS

 use WordList::Char::ZH::HSK5;

 my $wl = WordList::Char::ZH::HSK5->new;

 # Pick a (or several) random word(s) from the list
 my $word = $wl->pick;
 my @words = $wl->pick(3);

 # Check if a word exists in the list
 if ($wl->word_exists('foo')) { ... }

 # Call a callback for each word
 $wl->each_word(sub { my $word = shift; ... });

 # Get all the words
 my @all_words = $wl->all_words;

=head1 DESCRIPTION

=head1 STATISTICS

 +----------------------------------+-------+
 | key                              | value |
 +----------------------------------+-------+
 | avg_word_len                     | 1     |
 | longest_word_len                 | 1     |
 | num_words                        | 621   |
 | num_words_contains_nonword_chars | 0     |
 | num_words_contains_unicode       | 621   |
 | num_words_contains_whitespace    | 0     |
 | shortest_word_len                | 1     |
 +----------------------------------+-------+

The statistics is available in the C<%STATS> package variable.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/WordList-ZH-HSK>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-WordList-ZH-HSK>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=WordList-ZH-HSK>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<WordList::Char::ZH::HSK>

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__DATA__
丑
丝
临
义
乏
乖
乙
乡
亏
产
享
亿
代
令
仿
企
伟
伴
伸
似
余
佛
佩
依
促
俊
俗
俱
倡
偷
偿
傍
催
傻
兄
充
兑
兔
兵
兼
册
军
农
冠
冲
冻
凌
凭
击
创
初
删
制
刺
剪
劝
劣
劲
劳
势
勤
勿
匀
匆
匹
升
华
卧
卷
厂
厘
厢
厦
县
叉
叙
古
召
吐
吓
吧
吨
含
启
吵
吹
吻
呆
咨
咬
品
哈
哲
唉
唯
善
喊
喷
嗓
嗯
嘉
器
嚏
团
固
圆
圈
土
均
坦
型
域
培
堆
塘
墙
壁
壶
夕
夜
夸
夹
奈
套
妇
妙
妨
姑
委
姥
姻
姿
威
娘
娱
娶
婆
媒
嫁
嫩
孕
孝
宁
守
官
宝
宠
宣
宴
宽
宿
寂
寓
寞
寻
寿
射
尘
尚
尺
尾
屈
屉
届
屋
属
屿
岛
岸
巨
巴
币
布
帘
席
幅
幕
幻
幼
庆
库
府
废
庭
延
弯
弱
强
归
录
形
彻
彼
征
待
德
忍
念
忽
怨
恋
恢
恨
恭
恳
恶
悄
悠
悲
惠
惭
愁
愧
慌
慎
慧
慰
憾
戒
战
扇
托
执
扩
扶
承
抄
抓
投
抖
抢
披
押
拆
拍
拐
拥
拦
括
拳
拼
挑
挡
挣
挤
挥
振
捐
损
捡
掌
控
措
描
插
握
搜
搞
摄
摆
摇
摔
摘
摩
摸
撕
撞
操
政
敌
敏
救
敬
斗
斜
施
旦
旬
昆
映
显
晒
晕
智
暗
曾
替
朗
朝
木
未
杀
权
村
构
析
枪
架
某
柔
柜
柴
核
桃
桔
档
梨
梳
棋
椒
模
欠
欣
欧
歇
武
歪
殊
毒
毫
毯
氛
汇
池
沉
沟
治
泛
泪
洒
洞
派
浅
浇
测
浏
浓
涂
润
涨
淘
淡
渐
湿
源
滑
滚
滩
滴
漏
漠
潮
灰
灵
灾
炒
炭
炮
炸
烂
烈
烫
煤
煮
熬
燃
燥
版
状
犹
狂
狡
独
狮
猪
献
猴
猾
率
玉
王
玻
珍
璃
甩
甲
略
疗
疯
疲
痒
痛
皂
盆
益
盖
盼
盾
眉
眠
睁
瞎
瞧
矛
矩
石
砍
硬
碍
碎
碰
神
私
秘
秩
称
移
税
稳
窄
立
竹
筑
类
粘
粮
糊
糙
糟
素
索
紫
繁
纯
纲
纳
纷
组
织
绕
络
统
绪
绳
维
绸
综
缓
编
缩
罚
置
群
翅
耽
肃
肌
肠
股
肩
胁
胃
胆
背
胜
胡
胶
胸
脆
脖
腐
腰
膀
臭
致
舅
舍
良
艰
艳
苗
英
范
荐
荣
营
蔬
薄
藏
虚
虫
虹
蛇
蜂
蜜
蝴
蝶
血
衡
补
裁
装
裔
裹
览
触
订
训
讽
设
访
诊
诗
询
谓
谦
谨
豆
豪
豫
贝
贡
财
账
贴
贷
贸
赏
赔
赞
趁
趋
跃
践
踩
蹲
躲
轮
软
载
辅
辈
辑
辞
辩
达
迅
返
违
迫
述
迹
追
退
逃
透
逐
递
途
逗
造
逻
遗
遵
避
配
酱
醉
醋
采
钓
铃
链
销
锁
锅
闪
闭
闯
闲
防
阵
阶
阻
陆
陌
限
隔
雄
集
雷
雾
震
霉
青
靠
革
鞭
顶
项
顿
领
频
颗
飘
食
饰
馒
驶
驾
骂
骤
骨
髦
鬼
魅
麦
鼠
齐
齿
龙
