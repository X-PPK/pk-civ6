# 前言
这里主要讲解一些你在涉及Date官方数据库代码基本上写啥都要涉及相通的部分

本文章是以H佬所讲为基础上而扩展细讲部分内容，默认来看的都已经了解过H佬哔哩mod教程

注意
- 在“**值类型**”前面加了**X**则表示为必填的值
- 注释前面有**GS**表示是风云变幻内容，**RF**是迭起兴衰内容
- **必需要了解的表**，这些表可以算是我们在数据库实现其他能力的基石
- **默认值="NULL"** 表示默认值为**空**,不是文本

下面开始内容

## **一. 核心开始**
- **所有的各种Type变量**都需要先在这里定义的**实际类型**也就是KING
### **Kinds**
```
<!-- PS：Kinds 定义的 ‘实际类型’ 也就是KING 这个表我们正常情况不需要定义，但我们需要了解这些表有哪些‘实际类型’ -->
<Kinds
	Kind="实际类型"		X值类型="TEXT"		默认值="NULL"
	Hash="散列值"		值类型="INTEGER"	默认值="0"		注释="不用填，自动生成"
/>
```

### **Types**
```
<!-- PS：各种Type变量都需要先在Types这里定义的KING，KING指向Kinds表-->
<Types
	Type="各种Type变量"	X值类型="TEXT"		默认值="NULL"
	Hash="散列值"		X值类型="INTEGER"	默认值="0"		注释="不用填，自动生成"
	Kind="实际类型"		X值类型="TEXT"		默认值="NULL"
/>
```

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

### **Tags**
- 区分开文本文件里文本变量用到的那个Tag，完全和这里的Tag是两码事情
```
<!-- PS: Tags表是一个定义标签的表，拥有给其他各种Type变量进行标签，用于对拥有相同标签的Type变量对象进行统一的操作，
		 例如对多个单位增加一个陆军tag标签，赋予相同的AI行为逻辑 -->
<Tags
	Tag="标签ID自己定义"	X值类型="TEXT"	默认值="NULL"
	Vocabulary="散列值"	值类型="TEXT"	默认值="NULL"	注释="官方这里都有赋予值，这里就是抄官方"
/>
```
### **TypeTags**
- 定义了Tag后就需要给Type变量赋予标签，而这就要用到TypeTags表
```
<!-- PS: TypeTags表是对Type变量赋予标签Tag，注意这不是必须的，Type变量可不标记标签 -->
<TypeTags
	Type="各种Type变量"	X值类型="TEXT"	默认值="NULL"
	Tag="标签ID自己定义"	X值类型="TEXT"	默认值="NULL"
/>
```
<details><summary>官方TypeTags表绑定Type变量类型：</summary>

|       Type         | 注释
| ------------------ | --------------
| UnitType| 单位Type变量
| UnitAbilityType| 单位能力的Type变量
| ResourceType | 资源的Type变量
| ModifierType| 修改器的Type变量

</details>

## **二. 修改器**
- 各种能力主要就是修改器
- 关于修改器这里推荐使用H佬的文明6辅助工具来写，同时这里是以H佬[修改器教程](https://www.bilibili.com/video/BV1zt41167qA/)打底的
### **DynamicModifiers**
- 一般用官方已经定义好的几百个ModifierType就够用了
```
<!-- PS：这个是定义修改器效果类型的表，官方已经写了很多很多修改器效果，能实现很多效果，但我们有时还是需要来自己定义一些修改器效果类型 -->
<DynamicModifiers
	ModifierType="修改器效果类型"	X值类型="TEXT"	默认值="NULL"
	CollectionType="生效的对象集合"	X值类型="TEXT"	默认值="NULL"
	EffectType="效果接口"	        X值类型="TEXT"	默认值="NULL"	注释="官方给我们真正的数据库修改接口"
/>
```
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

### **Modifiers**
```
<!-- PS：Modifiers 这个是定义修改器的表，自己设定一个修改器ID 并给予对应修改器效果，以及设定修改器生效时机和限定范围-->
<Modifiers
	ModifierId="修改器ID"							X值类型="TEXT"		默认值="NULL"
	ModifierType="修改器效果类型"					X值类型="TEXT"		默认值="NULL"
	RunOnce="生效的对象集合"						    值类型="BOOLEAN"	默认值="false"
	NewOnly="效果接口"	        					值类型="BOOLEAN"	默认值="false"
	Permanent="生效的对象集合"						值类型="BOOLEAN"	默认值="false"
	Repeatable="生效的对象集合"						值类型="BOOLEAN"	默认值="false"
	OwnerRequirementSetId="生效对象要满足条件"		值类型="TEXT"		默认值="NULL"
	SubjectRequirementSetId="修改器生效要达到条件"	值类型="TEXT"		默认值="NULL"
	OwnerStackLimit="生效对象堆栈限制??"			    值类型="INTEGER"	默认值="NULL"	注释="官方最后这里貌似弃用全为默认数值NULL，有待我们测试具体定义什么"
	SubjectStackLimit="修改器堆栈限制??"			    值类型="INTEGER"	默认值="NULL"	注释="根据我的翻译和理解，貌似是这个修改器的叠加数量上限"
/>
PS：OwnerRequirementSetId和SubjectRequirementSetId填入的都是RequirementSetId，当然他们非必填值
```
### ModifierArguments
```
<!--PS：ModifierArguments是定义ModifierId参数的地方，大部分修改器效果ModifierType都需要定义参数，
		举个例子总不可这个修改器效果是加文化，不给它加多少的参数。但也有部分ModifierType不用参数，只用Modifiers表绑定就能生效 -->
<ModifierArguments
	ModifierId="修改器ID"	X值类型="TEXT"	默认值="NULL"
	Name="参数类型"			X值类型="TEXT"	默认值="NULL"
	Value="参数值"			X值类型="TEXT"	默认值="NULL"	注释="这里的参数值类型实际看Name的值，例如如果是BOOLEAN类那么Value就要填BOOLEAN值"
	Extra="额外的"			值类型="TEXT"	默认值="NULL"	注释="额外的参数值1"
	SecondExtra="第二额外"	值类型="TEXT"	默认值="NULL"	注释="额外的参数值2"
/>
```
### ModifierStrings
```
<!--PS：ModifierStrings是定义ModifierId文本的地方，大部分ModifierId是不需要这个的，但在一些地方还是需要的
		例如，在给单位的修改器上，由于修改器改变了单位属性，而这种改变是满足了生效条件（例如某种地形加战斗力）临时拥有的
		所以给告诉玩家这个临时效果怎么来的，就需要用到这里的文本 -->
<ModifierStrings
	ModifierId="修改器ID"				X值类型="TEXT"	默认值="NULL"
	Context="(事情发生的)背景?上下文"	X值类型="TEXT"	默认值="NULL"	注释="抄官方，俺也不懂，猜测和其他不同Context的文本顺序有关"
	Text="文本或文本变量"				X值类型="TEXT"	默认值="NULL"
/>
```
### 怎么将修改器赋予到需要的对象
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
| GovernorModifiers                    | GovernorType="总督Type变量"               | RF&GS 将修改器与总督绑定--总督初始能力
| GovernorPromotionModifiers           | GovernorPromotionType="总督晋升Type变量"  | RF&GS 将修改器与总晋升能力绑定
| ComplimentModifiers                  | CommemorationType="时代着力点Type变量"    | RF&GS 与CommemorationModifiers的表内容一样，官方应该弃用了，数据库内为空
| AllianceEffects                      | AllianceType="同盟关系Type变量"           | RF&GS 将修改器与同盟关系绑定，它还有一个LevelRequirement确认修改器生效级别要求
| EmergencyBuffs                       | EmergencyType="突发事件Type变量"          | RF&GS 紧急缓冲表 给突发事件在缓冲阶段给予修改器，它还有一个Description是文本讲述突发事件缓存情况效果

</details><details><summary>其他可直接绑修改器ID的表</summary>

|        表        | 被绑对象                         | 注释
| ---------------- | ------------------------------- |------------------------
| EmergencyRewards | EmergencyType="突发事件Type变量" | RF&GS 这个是定义突发事件奖励的表有多个需要定义的量，其中就可以直接绑定修改器ModifierId
| GoodyHutSubTypes | SubTypeGoodyHut="村庄Type变量"   | 定义村庄效果类型的表，有待研究，可直接绑修改器ModifierId
| esolutionEffects | ResolutionType="决议的Type变量"  | GS 决议效果的表，有待研究，可直接绑修改器ModifierId

</details>

## 三. REQ修改器限制
- 这个是对修改器效果进行约束限制，在我们需要的时候生效，不需要的时候无效

### Requirements

### RequirementArguments

### RequirementStrings

### RequirementSets

### RequirementSetRequirements