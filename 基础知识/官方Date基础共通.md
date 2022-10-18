# 前言
这里主要讲解一些你在涉及Date官方数据库代码基本上写啥都要涉及相通的部分

本文章是以H佬所讲为基础上而扩展细讲部分内容，默认来看的都已经了解过H佬哔哩mod教程

这里是我认为非常有**必要了解的表**，这些表可以算是我们在数据库实现其他能力的基石

各个元素在表里大都是互相可绑的不是一对一关系

**注意：**
- **默认值**为“NULL”表示默认值为**空**,不是文本
- 在“**值类型**”后面加了“:star:”则表示为必填的值，注意你要么不在这个表增加新的值，要么建立这些必填的就必须进行定义
- 注释前面有**GS**表示是风云变幻内容，**RF**是迭起兴衰内容
- **RequirementType** 和 **EffectType** 与 **CollectionType** 是官方在游戏数据库主要的“底层接口”，我们是无法自己建立定义的，除非官方开放底层代码DLL
- 我各个表具体介绍中**表可填参数**会顺带中文讲一下大体是什么，然后如果有补充则是在**注释**

下面开始内容

---

# **一. 核心开始**
- **所有的各种Type变量**都需要先在这里定义的**实际类型**也就是KING
## **Kinds**
```xml
<!--PS：Kinds定义的‘实际类型’也就是KING这个表我们正常情况不需要定义，但我们需要了解这些表有哪些‘实际类型’-->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| Kind="实际类型" | TEXT:star: | NULL |
| Hash="散列值" | INTEGER | 0 |不用填，自动生成

## **Types**
```xml
<!-- PS：各种Type变量都需要先在Types这里定义的KING，KING指向Kinds表-->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| Type="各种Type变量" | TEXT:star: | NULL |
| Kind="实际类型" | TEXT:star: | NULL |
| Hash="散列值" | INTEGER | 0 |不用填，自动生成

**Kinds表**以及**Types**具体有哪些实际类型，这些是我的整理（值类型均="TEXT"）
<details><summary>Kinds表</summary>
PS：Kind 官方共设定90个值

|       Kind                   | 介绍           |     注释
| ---------------------------- | -------------- | -----------
| KIND_TRAIT                   | 特性            | 
| KIND_CIVILIZATION            | 文明            | 
| KIND_LEADER                  | 领袖            | 
| KIND_GOSSIP                  | 议程            | 
| KIND_BUILDING                | 建筑,奇观        | 
| KIND_DISTRICT                | 区域            | 
| KIND_IMPROVEMENT             | 改良            | 
| KIND_UNIT                    | 单位            |
| KIND_FORMATION_CLASS         | 单位类型        |
| KIND_ABILITY                 | 单位能力        |
| KIND_UNITCOMMAND             | 单位命令        |
| KIND_UNITOPERATION           | 单元技能操作    |
| KIND_PROMOTION_CLASS         | 单位晋升大类    |
| KIND_PROMOTION               | 单位晋升        |
| KIND_GREAT_PERSON_CLASS      | 伟人类型        | 
| KIND_GREAT_PERSON_INDIVIDUAL | 伟人个体        | 
| KIND_WMD                     | 核武器          |
| KIND_BELIEF                  | 信条            | 
| KIND_RELIGION                | 宗教            | 
| KIND_RESOURCE                | 资源            | 
| KIND_TECH                    | 科技            |
| KIND_CIVIC                   | 市政            | 
| KIND_POLICY                  | 政策            | 
| KIND_PROJECT                 | 项目            | 
| KIND_GOVERNOR                | 总督            | RF&GS
| KIND_GOVERNOR_PROMOTION      | 总督能力        | RF&GS
| KIND_NAMED_RIVER             | 河流名称        | GS
| KIND_NAMED_VOLCANO           | 火山名称        | GS
| KIND_NAMED_MOUNTAIN          | 山地名称        | GS
| KIND_NAMED_DESERT            | 沙漠名称        | GS
| KIND_NAMED_LAKE              | 湖泊名称        | GS
| KIND_NAMED_SEA               | 海洋名称        | GS
| KIND_NAMED_OCEAN             | 大洋名称        | GS
| KIND_COLLECTION              | 集合            | 对象合集,与下面两个在DynamicModifiers表定义修改器
| KIND_EFFECT                  | 效果类型        | 官方修改器真正的接口
| KIND_MODIFIER                | 修改器效果类型   | 由上面两个构成MODIFIER
| KIND_REQUIREMENTSET          | 需求设置        | 对需求限制进行整理关系进行约束(与非和关系)也就是构建一个限制集合
| KIND_REQUIREMENT             | 需求限制        | 最底层的限制，来约束修改器生效范围

</details><details><summary>较少涉及部分</summary>

|       Kind                   | 介绍           |     注释
| ---------------------------- | -------------- | -----------
| KIND_DEAL_ITEM               | 交易项目        | 
| KIND_DIFFICULTY              | 游戏难度        | 
| KIND_DIPLOMATIC_ACTION       | 外交行动        | 
| KIND_DIPLOMATIC_STATE        | 外交状态        | 
| KIND_BARBARIAN_TRIBE         | 蛮族营地类型    | 
| KIND_ERA                     | 时代            | 
| KIND_FEATURE                 | 地貌            | 
| KIND_CAPABILITY              | 能力??          | 
| KIND_GAMESPEED               | 游戏速度        | 
| KIND_GAMESPEED_SCALING       | 游戏速度缩放?    | 
| KIND_GOODY_HUT               | 部落村庄奖励     | 
| KIND_GREATWORK               | 著作            | 
| KIND_HAPPINESS               | 宜居度等级      | 例如欣喜若狂，厌恶等等
| KIND_CONTINENT               | 大陆            | 
| KIND_MAPSIZE                 | 地图大小        | 
| KIND_NOTIFICATION            | 通知            | 
| KIND_SLOT                    | 槽位            | 
| KIND_QUEST                   | 任务            | 
| KIND_ROUTE                   | 道路            | 铁路等
| KIND_SCORING_CATEGORY        | 评分类别?       | 
| KIND_SCORING_LINE_ITEM       | 评分行项目?     | 
| KIND_TERRAIN                 | 地形            |
| KIND_TERRAIN_CLASS           | 地形大类        |
| KIND_GAMEMODE                | 游戏模式        |
| KIND_TURNPHASE               | ?              | 这四个貌似与时间设置有关
| KIND_TURNMODE                | ?              | 没兴趣研究
| KIND_TURNSEGMENT             | ?              |
| KIND_TURNTIMER               | ?              |
| KIND_DEFEAT                  | 失败类型        | 例如失败和时间耗尽
| KIND_VICTORY                 | 胜利类型        |
| KIND_VICTORY_STRATEGY        | 胜利战略        | 与AI获取胜利有关
| KIND_WAR                     | 战争类型        |
| KIND_YIELD                   | 产量类型        |
| KIND_PSEUDOYIELD             | 伪产量          | 用于AI
| KIND_DIPLOMACY_ALLIANCE      | 外交联盟类型    | RF&GS
| KIND_DIPLOMACY_EMERGENCY     | 外交紧急情况    | RF&GS
| KIND_GOVERNMENT              | 政体            |
| KIND_LOYALTY_LEVEL           | 忠诚度级别      | RF&GS
| KIND_MOMENT                  | 历史时刻        | RF&GS
| KIND_MOMENT_DATA             | 历史时刻数据    | RF&GS和历史时刻记录有关
| KIND_MOMENT_OUTCOME          | 历史时刻的成果  | RF&GS
| KIND_MOMENT_ILLUSTRATION     | 历史时刻插图    | RF&GS
| KIND_RESOLUTION              | 决议           | GS
| KIND_DISCUSSION              | 世界大会       | GS世界紧急情况，诺贝尔奖
| KIND_PROPOSAL_TYPE           | 世界提案类型    | GS
| KIND_VOTING_BLOCKER          | 投票类型        | GS例如你是目标文明无法投票
| KIND_PROPOSAL_BLOCKER        | 提案拦截        | GS当处于非议程时间打开世界议会效果
| KIND_MINORCIVBONUS           | 次要奖金类型    | GS城邦的奖励
| KIND_COASTAL_LOWLAND         | 沿海低地        | GS
| KIND_RANDOM_EVENT            | 随机事件        | GS随机灾害
| KIND_REALISM_SETTING         | 灾害级别设置    | GS
| KIND_ROCKBAND_RESULT         | 乐队演奏结果    | GS

</details>

## **Tags**
- 区分开文本文件里文本变量用到的那个Tag，完全和这里的Tag是两码事情
```xml
<!-- PS: Tags表是一个定义标签的表，拥有给其他各种Type变量进行标签，用于对拥有相同标签的Type变量对象进行统一的操作，
		 例如对多个单位增加一个陆军tag标签，赋予相同的AI行为逻辑 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| Tag="标签ID自己定义" | TEXT:star: | NULL |
| Vocabulary="词汇表" | TEXT | NULL | 指向Vocabularies表，暂未深入研究，这里我就是抄官方。

## **TypeTags**
- 定义了Tag后就需要给Type变量赋予标签，而这就要用到TypeTags表
```xml
<!-- PS: TypeTags表是对Type变量赋予标签Tag，注意这不是必须的，Type变量可不标记标签 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| Type="各种Type变量" | TEXT:star: | NULL |
| Tag="标签ID自己定义" | TEXT:star: | NULL | 指向Vocabularies表，暂未深入研究，这里我就是抄官方。
<details><summary>官方TypeTags表绑定Type变量类型：</summary>

|       Type         | 注释
| ------------------ | --------------
| UnitType| 单位Type变量
| UnitAbilityType| 单位能力的Type变量
| ResourceType | 资源的Type变量
| ModifierType| 修改器的Type变量
</details>

---

# **二. 修改器**
- 各种能力主要就是修改器
- 关于修改器这里推荐使用H佬的文明6辅助工具来写，同时这里是以H佬[修改器教程](https://www.bilibili.com/video/BV1zt41167qA/)打底的
## **DynamicModifiers**
- 一般用官方已经定义好的几百个ModifierType就够用了
```xml
<!-- PS：这个是定义修改器效果类型的表，官方已经写了很多很多修改器效果，能实现很多效果，但我们有时还是需要来自己定义一些修改器效果类型 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| ModifierType="修改器Type变量" | TEXT:star: | NULL |
| CollectionType="生效的对象集合" | TEXT:star: | NULL |
| EffectType="效果接口" | TEXT:star: | NULL | 官方给我们真正的数据库修改接口

<details><summary>CollectionType对象集合整理</summary>

PS：CollectionType 官方共设定41个值

|       CollectionType                | 注释
| ----------------------------------- | --------------
| COLLECTION_ALLIANCE_CITIES          |
| COLLECTION_ALLIANCE_COMBATS         |
| COLLECTION_ALLIANCE_DISTRICTS       |
| COLLECTION_ALLIANCE_PLAYERS         |
| COLLECTION_ALLIANCE_TRADEROUTES     |
| COLLECTION_ALLIANCE_TRAINED_UNITS   |
| COLLECTION_ALLIANCE_UNITS           |
| COLLECTION_ALL_CITIES               |
| COLLECTION_ALL_DISTRICTS            |
| COLLECTION_ALL_PLAYERS              |
| COLLECTION_ALL_PLOT_YIELDS          |
| COLLECTION_ALL_UNITS                |
| COLLECTION_CITY_DISTRICTS           |
| COLLECTION_CITY_PLOT_YIELDS         |
| COLLECTION_CITY_TRAINED_UNITS       |
| COLLECTION_COMBAT_RESULTS           |
| COLLECTION_EMERGENCY_CAPITAL_CITIES |
| COLLECTION_EMERGENCY_CITIES         |
| COLLECTION_EMERGENCY_COMBATS        |
| COLLECTION_EMERGENCY_DISTRICTS      |
| COLLECTION_EMERGENCY_PLAYERS        |
| COLLECTION_EMERGENCY_TRADE_ROUTES   |
| COLLECTION_EMERGENCY_UNITS          |
| COLLECTION_MAJOR_PLAYERS            |
| COLLECTION_OWNER                    |
| COLLECTION_OWNER_CITY               |
| COLLECTION_PLAYER_ALLIANCES         |
| COLLECTION_PLAYER_BUILT_CITIES      |
| COLLECTION_PLAYER_CAPITAL_CITY      |
| COLLECTION_PLAYER_CAPTURED_CITIES   |
| COLLECTION_PLAYER_CITIES            |
| COLLECTION_PLAYER_CITY_STATE_UNITS  |
| COLLECTION_PLAYER_COMBAT            |
| COLLECTION_PLAYER_DISTRICTS         |
| COLLECTION_PLAYER_GOVERNORS         |
| COLLECTION_PLAYER_PLOT_YIELDS       |
| COLLECTION_PLAYER_TRAINED_UNITS     |
| COLLECTION_PLAYER_UNITS             |
| COLLECTION_SINGLE_PLOT_YIELDS       |
| COLLECTION_UNIT_COMBAT              |
| COLLECTION_UNIT_NEAREST_OWNER_CITY  |

</details>
PS：DynamicModifiers表我暂未进行过深入研究，暂时没有注释，ModifierType和EffectType太多了暂没精力整理

## **Modifiers**
- ps：我OwnerRequirementSetId没用过不确定理解是否到位
- PS：OwnerRequirementSetId和SubjectRequirementSetId填入的都是RequirementSetId，当然他们非必填值
```xml
<!-- PS：Modifiers 这个是定义修改器的表，自己设定一个修改器ID 并给予对应修改器效果，以及设定修改器生效时机和限定范围-->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| ModifierId="修改器ID" | TEXT:star: | NULL |
| ModifierType="修改器Type变量" | TEXT:star: | NULL |
| RunOnce="只对当前的对象有效" | BOOLEAN | false |
| NewOnly="只对之后的对象有效" | BOOLEAN | false |
| Permanent="执行一次永久有效" | BOOLEAN | false |
| OwnerRequirementSetId="所有者要满足条件" | TEXT | NULL | 例如修改器本身生效时机
| SubjectRequirementSetId="被影响者要满足条件" | TEXT | NULL | 被修改器修改对象要满足条件，例如是限定丘陵生效，如果是修改器是绑单位上，就需要单位移动到丘陵才有效
| Repeatable="可重复?" | BOOLEAN | false | 官方就一个地方有用到它,有待研究
| SubjectStackLimit="修改器堆栈限定??" | INTEGER | NULL | 根据我的翻译和理解，貌似是这个修改器的叠加数量上限
| OwnerStackLimit="生效对象堆栈限定??" | INTEGER | NULL | 官方最后这里貌似弃用全为默认数值NULL，有待我们测试具体定义什么

## ModifierArguments
```xml
<!--PS：ModifierArguments是定义ModifierId参数的地方，大部分修改器效果ModifierType都需要定义参数，
	举个例子总不可这个修改器效果是加文化，不给它加多少的参数。但也有部分ModifierType不用参数，只用Modifiers表绑定就能生效 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| ModifierId="修改器ID" | TEXT:star: | NULL |
| Name="名称" | TEXT:star: | NULL | 这里的实际填参数值类型
| Value="参数值" | TEXT:star:| NULL | 这里的参数值类型实际看Name的值，例如如果是BOOLEAN类那么Value就要填BOOLEAN值
| Extra="额外的" | TEXT | NULL | 额外的参数值1
| SecondExtra="第二额外" | TEXT | NULL | 额外的参数值2
| Type="类型" | TEXT | ARGTYPE_IDENTITY| 这里的官方均保持默认值ARGTYPE_IDENTITY，完全可以无视这个存在，这个俺没研究过

## ModifierStrings
```xml
<!--PS：ModifierStrings是定义ModifierId文本的地方，大部分ModifierId是不需要这个的，但在一些地方还是需要的
		例如，在给单位的修改器上，由于修改器改变了单位属性，而这种改变是满足了生效条件（例如某种地形加战斗力）临时拥有的
		所以给告诉玩家这个临时效果怎么来的，就需要用到这里的文本 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| ModifierId="修改器ID" | TEXT:star: | NULL |
| Context="(事情发生的)背景?上下文" | TEXT:star: | NULL | 抄官方，俺也不太懂，猜测和其他不同Context的文本顺序有关
| Text="文本或文本变量" | TEXT:star: | NULL |

## 怎么将修改器赋予到需要的对象
- 将修改器效果赋予对象的表
<details><summary>较为常规"XXModifier"表</summary>

|        表                            | 被绑对象                                 | 注释
| ------------------------------------ | --------------------------------------- |------------------------
| TraitModifiers                       | TraitType="特性Type变量"                 | 将修改器与特性绑定，在通特性绑文明或领袖
| BeliefModifiers                      | BeliefType="信条特性Type变量"            | 将修改器与信条绑定
| BuildingModifiers·                   | BuildingType="建筑/奇观Type变量"         | 将修改器与信条绑定
| CivicModifiers                       | CivicType="市政Type变量"                 | 将修改器与信条绑定
| TechnologyModifiers                  | TechnologyType="科技Type变量"            | 将修改器与信条绑定
| DistrictModifiers                    | DistrictType="区域Type变量"              | 将修改器与信条绑定v
| GovernmentModifiers                  | GovernmentType="政体Type变量"            | 将修改器与信条绑定
| GreatPersonIndividualBirthModifiers  | GreatPersonIndividualType="伟人Type变量" | 将修改器与伟人绑定
| GreatPersonIndividualActionModifiers | GreatPersonIndividualType="伟人Type变量" | 将修改器与伟人激活能力绑定，它还有一个AttachmentTargetType确认能力激活修改器生效对象
| GreatWorkModifiers                   | GreatWorkType="著作,遗物Type变量"        | 将修改器与著作/遗物绑定
| ImprovementModifiers                 | ImprovementType="改良Type变量"           | 将修改器与改良绑定
| PolicyModifiers                      | PolicyType="政策Type变量"                | 将修改器与政策卡绑定
| ProjectCompletionModifiers           | ProjectType="项目Type变量"               | 项目完成的修改器效果
| UnitAbilityModifiers                 | UnitAbilityType="单位能力Type变量"        | 单位能力拥有的修改器效果
| UnitPromotionModifiers               | UnitPromotionType="单位晋升Type变量"      | 单位晋升拥有的修改器效果
| GameModifiers                        |                  /                       | 这个表只需要ModifierId，应该是是直接把修改器效果绑全局的?(待测试研究)
| CommemorationModifiers               | CommemorationType="时代着力点Type变量"    | RF&GS 时代着力点的修改器效果
| ~~ComplimentModifiers~~              | ~~CommemorationType="时代着力点Type变量"~~ | ~~RF&GS~~ 与CommemorationModifiers的表内容一样，官方应该弃用了，数据库内为空
| GovernorModifiers                    | GovernorType="总督Type变量"               | RF&GS 将修改器与总督绑定--总督初始能力
| GovernorPromotionModifiers           | GovernorPromotionType="总督晋升Type变量"  | RF&GS 将修改器与总晋升能力绑定
| AllianceEffects                      | AllianceType="同盟关系Type变量"           | RF&GS 将修改器与同盟关系绑定，它还有一个LevelRequirement确认修改器生效级别要求
| EmergencyBuffs                       | EmergencyType="突发事件Type变量"          | RF&GS 紧急缓冲表 给突发事件在缓冲阶段给予修改器，它还有一个Description是文本讲述突发事件缓存情况效果

</details><details><summary>其他可直接绑修改器ID的表</summary>

|        表        | 被绑对象                         | 注释
| ---------------- | ------------------------------- |------------------------
| EmergencyRewards | EmergencyType="突发事件Type变量" | RF&GS 这个是定义突发事件奖励的表有多个需要定义的量，其中就可以直接绑定修改器ModifierId
| GoodyHutSubTypes | SubTypeGoodyHut="村庄Type变量"   | 定义村庄效果类型的表，有待研究，可直接绑修改器ModifierId
| esolutionEffects | ResolutionType="决议的Type变量"  | GS 决议效果的表，有待研究，可直接绑修改器ModifierId

</details>

---

# 三. REQ修改器限定
- 这个是对修改器效果进行约束，在我们需要的时候生效，不需要的时候无效，确定一个生效范围
- **与Modifiers的关系**：先Requirements表开始，在这里定义好底层限制后再指向RequirementSets表，再在RequirementSets表被整理汇集构成完整的限定集合最后在递交到Modifiers表关联绑定修改器ModifierId确定修改器的生效范围
## Requirements
```xml
<!-- PS: Requirements表是定义底层限定的地方， -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| RequirementId="子限定ID自己定义" | TEXT:star: | NULL |
| RequirementType="限定Type变量" | TEXT:star: | NULL | 官方给我们修改器限定接口
| Likeliness="可能性??" | INTEGER | 0 | 官方最后这里貌似弃用全为默认数值0，有待我们测试具体定义什么,个人猜测有可能是修改器达到子限定的生效条件后还需要这里的给予概率?
| Impact="影响??" | INTEGER | 0 | 官方最后这里貌似弃用全为默认数值0，有待我们测试具体定义什么,个人猜测有可能是修改器被影响范围??
| Inverse="反转" | BOOLEAN | false | 当这个为true时，子限定的范围反转，例如一个REQ原本限定生效范围是城市人口达到7人有效，结果加了一个Inverse为true,那么就变成不达到7人口有效，达到7入口无效"
| Persistent="持久的?" | BOOLEAN | false | 官方仅在部分涉及AI胜利的修改器有用这个
| ProgressWeight="进度权重?"  | INTEGER | 0 | 官方仅在部分涉及AI胜利的修改器有用这个
| Triggered="已触发?" | BOOLEAN | false | 官方这个仅在战争状态下的修改器有关，有待深入研究
| Reverse="颠倒?反转?" | BOOLEAN | false | 官方最后这里貌似弃用全为默认数值false，有待我们测试具体定义什么

**PS**: RequirementType太多了暂没精力整理

## RequirementArguments
- 这个表和ModifierArguments差不多，实际他们的表里元素以及与对应其他表关系差不多
```xml
<!-- PS：RequirementArguments表是定义RequirementId参数的地方，当然部分限制RequirementType是不需要定义参数，不用写RequirementArguments表 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| RequirementId="子限定ID自己定义" | TEXT:star: | NULL |
| Name="名称" | TEXT:star: | NULL | 这里的实际填参数值类型
| Value="参数值" | TEXT:star:| NULL | 这里的参数值类型实际看Name的值，例如如果是BOOLEAN类那么Value就要填BOOLEAN值
| Extra="额外的" | TEXT | NULL | 额外的参数值1
| SecondExtra="第二额外" | TEXT | NULL | 额外的参数值2
| Type="类型" | TEXT | ARGTYPE_IDENTITY| 这里的官方均保持默认值ARGTYPE_IDENTITY，完全可以无视这个存在，这个俺没研究过


## RequirementStrings
- 这个我们基本用不到，了解一下好了
```xml
<!--PS：RequirementStrings 是定义RequirementId文本的地方，大部分RequirementId是不需要这个的，但在一些地方还是需要的
	官方的例子貌似都与胜利有关，由于胜利是达到一定的“限定”要求（也就是REQ）就生效的，所以需要一些文本来描述 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| RequirementId="子限定ID自己定义" | TEXT:star: | NULL |
| Context="(事情发生的)背景?上下文" | TEXT:star: | NULL | 抄官方，俺也不太懂，猜测和其他不同Context的文本顺序有关
| Text="文本或文本变量" | TEXT:star: | NULL |


## RequirementSets
```xml
<!-- PS: RequirementSets表是对定义RequirementSetId限定集合内各个子限定之间处于什么状态，修改器就生效 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| RequirementSetId="限定集合ID自己定义" | TEXT:star: | NULL |
| RequirementSetType="限定集合Type" | TEXT:star: | NULL | 确定限定集合的子限定关系，官方给了3种类型

</details><details><summary>RequirementSetType的三种类型</summary>
PS：REQUIREMENTSET_TEST_NONE这个我查表官方实际没有用到

| RequirementSetType      | 对子限定要求
| ----------------------- | ------------------------------- 
| REQUIREMENTSET_TEST_ALL | 全部子限定符合，这个限定集合才符合，修改器生效
| REQUIREMENTSET_TEST_ANY | 任意子限定符合，这个限定集合才符合，修改器生效
| REQUIREMENTSET_TEST_NONE| 子限定全不符合，这个限定集合才符合，修改器生效

</details>

## RequirementSetRequirements
- 这里是将RequirementId集合到RequirementSetId
```xml
<!-- PS: RequirementSetRequirements表是对RequirementId底层限制在RequirementSetId进行绑定，
         组成一个大的集合，注意RequirementSetId可以绑一个也可以多个RequirementSetType -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| RequirementSetId="限定集合ID自己定义" | TEXT:star: | NULL |
| RequirementId="子限定ID自己定义" | TEXT:star: | NULL | 

---

# 四. Trait相通的特性
- 文明6的一个重要的游戏内容————每个文明/领袖的特色(包括特性特殊能力，特殊专有单位，特殊专有区域，特殊专有改良，特殊专有总督等等)，而他们的共同核心就是类型是
- Trait具体是特殊能力，还是特殊专有单位，又或者是特殊专有区域等等由它绑定的具体内容有关
    - 首先按它绑定的特性“享受者”可分为文明特性，领袖特性，议程特性
    - 然后按它绑定的特性"从属者"可绑的有单位，建筑，区域，改良，总督
    - 以及一些特殊的绑定，绑定这个不能建立的区域，不能招募伟人类型，不能享受的相邻区域————官方例子是刚果那个领袖的特殊能力：宗教转换
**KIND_TRAIT**的特性Type变量-**TraitType**
- 首先定义**TraitType**前面讲了，这里就跳过
- 一个**TraitType**就是一个特性，其中他的核心表是必须的
## 核心表
### Traits
- 直接定义特性的表，哪怕没有文本也需要定义的必须表
```xml
<!-- PS：Traits 表是定义一个特性名称和介绍的，当然也可以不定义名称和介绍，而是作为一个隐形的特性修改，我们更多是
	 亦或者多个特性绑一个文明/领袖时，为了显得更加精简，只有一个特性有文本介绍但将多个特性的能力全简述出来了 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| TraitType="特性Type变量" | TEXT:star: | NULL |
| Name="标题文本变量" | LocalizedText | NULL | 特性的标题
| Description="说明文本变量" | LocalizedText | NULL | 特性的文本介绍
| InternalOnly="仅限内部?" | BOOLEAN | false |看下面
- **InternalOnly**：仅游戏内部计算使用的特性，官方例子太空竞赛项目里的大 ，中，小3个火箭建筑个就是internal only的建筑，在太空项目时火箭建筑也在一步一步建造美术素材明显可以看到这个过程（本人这个未深入研究，了解有限）或许我们可以研究一下这个用这个来整点什么
### Leader或Civilization亦或者Agenda——Traits
- 虽然实际一个**TraitType**可以同时绑多个文明和领袖，但是这样会导致问题，例如一个文明和这个文明的领袖都绑了一个特殊能力，会导致文明的这个特性生效一次，领袖又生效一次对于像特殊能力很可能是效果直接叠加翻倍，所以我们应当做出选择，策划好这个特性到底是**文明特性还是领袖特性**，而这里就要用到给**文明**和**领袖**绑特性的表**LeaderTraits**表和**CivilizationTraits**表
####  CivilizationTraits
```xml
<!-- PS：CivilizationTraits 表是将TraitType绑到CivilizationType领袖的，
	 让TraitType成为了领袖特性，或是TraitType绑定的单位/建筑等等成为文明特殊单位/建筑等等 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| TraitType="特性Type变量" | TEXT:star: | NULL |
| CivilizationType="文明Type变量" | TEXT:star: | NULL | 

####  LeaderTraits
```xml
<!-- PS：LeaderTraits 表是将TraitType帮到LeaderType领袖的，
	让TraitType成为了领袖特性，或是TraitType绑定的单位/建筑等等成为领袖特殊单位/建筑等等 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| TraitType="特性Type变量" | TEXT:star: | NULL |
| LeaderType="领袖Type变量" | TEXT:star: | NULL | 

####  AgendaTraits
PS: 议程相关的是我感兴趣但暂时未深入研究的，有待研究
```xml
<!-- PS：AgendaTraits 表是将TraitType绑到AgendaType议程上 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| TraitType="特性Type变量" | TEXT:star: | NULL |
| AgendaType="文明Type变量" | TEXT:star: | NULL | 

####  补充 AiLists表
- 这里了解就好，后面教程会有专门讲述，知道还有这个地方要用到TraitType，实际上这个AI倾向也可以不定义，只是那样这个领袖modAI下可能会很菜
- AiLists表 也可以直接绑TraitType，但TraitType是代替领袖/议程Type进行绑定

<details><summary>:sparkles:我的理解</summary>
- 首先议程AgendaType也可以理解成一种领袖特色东西，他是直接通过HistoricalAgendas表将两者绑在一起而不是TraitType
- AgendaType更像是为了区分其他特色能力而专门增加的具有独立的文本名称和介绍
- 同时这里讲述一个相关的也要用到TraitType的地方——AiLists表
    - 这个表与AI的行为倾向逻辑有关(这游戏AI逻辑我们可调控的属实少，或者说官方AI是智障)
在这个表中我们可以把我们定义的AI倾向绑定到领袖或者议程上，而这里绑定不是直接绑领袖/议程Type上，而是绑TraitType在通过TraitType绑领袖/特性

PS: 我的理解通过对领袖/议程的不同特性Type来绑AI倾向，做到领袖/议程是多元倾向（也就是官方框架结构就是这样设计）
</details>

## 可直接绑TraitType成为特性的对象
- 常规的特殊XX(单位/建筑/改良等等)都是直接在定义自己的时候绑定TraitType
- 例如如特殊单位就是在单位的核心定义表Units可直接绑TraitType
### 常规特色相关表的表
- 这些表都是可以直接填的TraitType的，直接绑TraitType

|        表                  | 特色的对象      | 通过TraitType中间这样一绑
| -------------------------- | -------------- |-----------
| Buildings                  | 建筑/奇观表     | 特色建筑就这样诞生
| Districts                  | 区域            | 专有区域诞生
| Improvements               | 改良表          | 特色改良诞生
| Units                      | 单位表          | 特色单位诞生
| TraitModifiers             | 特色绑修改器ID表 | 特色能力诞生
| Governors                  | 总督表          | RF&GS特色总督
| DiplomaticVisibilitySources| 外交可见性来源?? | 未涉足，待研究，记得可以设定文明/领袖特色外交可见性，或许与这个有关

PS: 然后除了这里常规的可以通过绑表实现“特色”的外，实际还可以通过LUA来实现一些“特色”，例如特色政策卡

### 特殊的
- 这个官仅在**刚果-姆本巴·恩津加**领袖的特性：“**宗教转换**” 有使用过
    -具体特性效果：无法建造圣地区、获得大预言家，或创建宗教。从已成为多数刚果城市信仰的宗教中获得信仰值。每次完成一个姆班赞或剧院广场区时获得一位（城市主流宗教的）使徒。
#### ExcludedDistricts
```xml
<!-- PS：ExcludedDistricts 表是让TraitType增加一个不能造某区域的能力，在通过CivilizationTraits或LeaderTraits，让领袖/文明不能造这个区域 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| TraitType="特性Type变量" | TEXT:star: | NULL |
| DistrictType="区域Type变量" | TEXT:star: | NULL | 

#### ExcludedAdjacencies
```xml
<!-- PS：ExcludedAdjacencies 表是让TraitType增加一个相邻加成无效的能力，在通过CivilizationTraits或LeaderTraits，让领袖/文明这个相邻加成无效 -->

```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| TraitType="特性Type变量" | TEXT:star: | NULL |
| YieldChangeId="相邻加成ID" | TEXT:star: | NULL | 这个是自己在Adjacency_YieldChanges表设定起名并定义的加成关系的ID

#### ExcludedGreatPersonClasses
```xml
<!-- PS：ExcludedGreatPersonClasses 表是让TraitType增加一个不能获得这个类型伟人点数和招募这个类型伟人的能力，
	在通过CivilizationTraits或LeaderTraits，让领袖/文明不能招获得这个类型伟人点数和招募这个类型伟人 -->
```
| 表可填参数 | 值类型 | 默认值 | 注释
| -- | -- | :--: | --
| TraitType="特性Type变量" | TEXT:star: | NULL |
| GreatPersonClassType="伟人类型Type变量" | TEXT:star: | NULL | 

#### 特殊的TraitType
- 部分特殊的TraitType能非常有效帮助我们修改游戏，我们很有必要了解一些
- 非常希望有带佬补充
1) **TRAIT_LEADER_MAJOR_CIV**
    - 这个是modder用的非常多的官方TraitType
    - 这个TraitType字面意思是主要文明，但实测貌似对所有文明有效，通过这个TraitType我们可以把修改器自己绑它身上从而达到一次性绑所有文明上
    - 如果是增加单位什么的就没必要绑这里，以为非特性单位等就是全文明都有可建造的

2) **TRAIT_LEADER_BARBARIAN**
    - 这个是野蛮人的TraitType，可以把一些修改器，甚至单位等等绑这里增强野蛮人，当然也可以削弱

3) **TRAIT_LEADER_FREE_CITIES**
    - 这个是自由城邦的TraitType，和野蛮人同理