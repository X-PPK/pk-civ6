# 前言
这里主要讲解一些你在涉及Date官方数据库代码基本上写啥都要涉及相通的部分

本文章是以H佬所讲为基础上而扩展细讲部分内容，默认来看的都已经了解过H佬哔哩mod教程

注意在“值类型”前面加了X则表示为必填的值

下面开始内容

## 必需要了解的表
- 这些表可以算是我们在数据库实现其他能力的基石

### **一. 核心开始**
- 所有的各种Type变量都需要先在这里定义的**实际类型**也就是KING
#### **Kinds**
```
<!-- PS：Kinds 定义的 ‘实际类型’ 也就是KING 这个表我们正常情况不需要定义，但我们需要了解这些表有哪些‘实际类型’ -->
<Kinds
	Kind="实际类型"		X值类型="TEXT"		默认值="NULL"
	Hash="散列值"		值类型="INTEGER"	默认值="0"		注释="不用填，自动生成"
/>
```

#### **Types**
```
<!-- PS：各种Type变量都需要先在Types这里定义的KING，KING指向Kinds表-->
<Types
	Type="各种Type变量"	X值类型="TEXT"		默认值="NULL"
	Hash="散列值"		X值类型="INTEGER"	默认值="0"		注释="不用填，自动生成"
	Kind="实际类型"		值类型="NULL"		默认值="false"	注释="官方例子明治维新"
/>
```

**Kinds表**以及**Types**具体有哪些实际类型，这些是我的整理（值类型均="TEXT"）
<details><summary>Kinds表</summary>

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
| KIND_MODIFIER                | 修改器类型      | 由上面两个构成MODIFIER
| KIND_REQUIREMENTSET          | 需求设置        | 对需求设置进行整理关系约束与非和关系
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
| KIND_HAPPINESS               | 宜居度等级?      | 
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

### **二. 修改器**
- 各种能力主要就是修改器来实现的在通过各个XXXModifiers表来绑定到XXX上
- 关于修改器这里推荐使用H佬的文明6辅助工具来写，同时这里是以H佬[修改器教程](https://www.bilibili.com/video/BV1zt41167qA/)打底的
#### **DynamicModifiers**
