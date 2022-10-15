# 前言
这里主要讲解一些你在涉及Date官方数据库代码基本上写啥都要涉及相通的部分

本文章是以H佬所讲为基础上而扩展细讲部分内容，默认来看的都已经了解过H佬哔哩mod教程

注意在“值类型”前面加了X则表示为必填的值

下面开始内容

## 必需要了解的表
- 这些表可以算是我们在数据库实现其他能力的基石

### **核心开始**
- 所有的各种Type变量都需要先在这里定义的**实际类型**也就是KING
```
<!-- PS：Kinds 定义的 ‘实际类型’ 也就是KING 这个表我们正常情况不需要定义，但我们需要了解这些表有哪些‘实际类型’ -->
<Kinds
	Kind="实际类型"		X值类型="TEXT"		默认值="NULL"
	Hash="散列值"		值类型="INTEGER"	默认值="0"		注释="不用填，自动生成"
/>
```
Kinds表具体有哪些实际类型，这些是我们可以用到（值类型均="TEXT"）	

|       Kind       |                            注释                            |  说明  |
| ---------------- | ---------------------------------------------------------- | ------ |
| 设置金币          | `pPlayer:GetTreasury():SetGoldBalance(100)`                |        |
| 加减金币          | `pPlayer:GetTreasury():ChangeGoldBalance(-5)`              |        |
| 根据百分比加减金币 | `pPlayer:GetTreasury():ChangeGoldBalanceByPercentage(10)`  |        |
| 加总督点数        | `pPlayer:GetGovernors():ChangeGovernorPoints(1)`           |        |
| 加外交决议        | `pPlayer:GetDiplomacy():ChangeFavor(10)`                   |        |
| 加外交胜利点数     | `pPlayer:GetStats():ChangeDiplomaticVictoryPoints(1)`      | ❌无效 |
| 加影响力点数      | `pPlayer:GetInfluence():ChangeTokensToGive(1)`             |        |
| 加文化            | `pPlayer:GetCulture():ChangeCurrentCulturalProgress(1000)` | 一次性 |
| 加信仰            | `pPlayer:GetReligion():ChangeFaithBalance(50)`             |        |
| 判断是否是AI      | `pPlayer:IsAI()`                                           |        |
| 判断是否健在      | `pPlayer:IsAlive()`                                        |        |
| 判断是否是人类玩家 | `pPlayer:IsHuman()`                                        |        |
| 判断是否是野蛮人   | `pPlayer:IsBarbarian()`                                    |        |
| 判断是否是主流文明 | `pPlayer:IsMajor()`                                        |        |

- Types：
```
<!-- PS：各种Type变量都需要先在Types这里定义的KING，KING指向Kinds表-->
<Types
	Type="各种Type变量"	X值类型="TEXT"		默认值="NULL"
	Hash="散列值"		X值类型="INTEGER"	默认值="0"		注释="不用填，自动生成"
	Kind="实际类型"		值类型="NULL"		默认值="false"	注释="官方例子明治维新"
/>
```
| KIND_TRAIT                   |
| KIND_BARBARIAN_TRIBE           |
| KIND_BELIEF                   |
| KIND_BUILDING                   |
| KIND_CIVIC                   |
| KIND_CIVILIZATION               |
| KIND_DEAL_ITEM               |
| KIND_DIFFICULTY               |
| KIND_DIPLOMATIC_ACTION       |
| KIND_DIPLOMATIC_STATE           |
| KIND_DISTRICT                   |
| KIND_ERA                       |
| KIND_FEATURE                   |
| KIND_CAPABILITY               |
| KIND_COLLECTION               |
| KIND_EFFECT                   |
| KIND_MODIFIER                   |
| KIND_REQUIREMENT               |
| KIND_REQUIREMENTSET           |
| KIND_GAMESPEED               |
| KIND_GAMESPEED_SCALING       |
| KIND_GOODY_HUT               |
| KIND_GOSSIP                   |
| KIND_GREAT_PERSON_CLASS       |
| KIND_GREAT_PERSON_INDIVIDUAL |
| KIND_GREATWORK               |
| KIND_HAPPINESS               |
| KIND_IMPROVEMENT               |
| KIND_LEADER                   |
| KIND_CONTINENT               |
| KIND_MAPSIZE                   |
| KIND_NOTIFICATION               |
| KIND_POLICY                   |
| KIND_SLOT                       |
| KIND_PROJECT                   |
| KIND_QUEST                   |
| KIND_RELIGION                   |
| KIND_RESOURCE                   |
| KIND_ROUTE                   |
| KIND_SCORING_CATEGORY           |
| KIND_SCORING_LINE_ITEM       |
| KIND_TECH                       |
| KIND_TERRAIN                   |
| KIND_TERRAIN_CLASS           |
| KIND_GAMEMODE                   |
| KIND_TURNPHASE               |
| KIND_TURNMODE                   |
| KIND_TURNSEGMENT               |
| KIND_TURNTIMER               |
| KIND_ABILITY                   |
| KIND_UNITCOMMAND               |
| KIND_UNITOPERATION           |
| KIND_PROMOTION_CLASS           |
| KIND_PROMOTION               |
| KIND_UNIT                       |
| KIND_FORMATION_CLASS           |
| KIND_DEFEAT                   |
| KIND_VICTORY                   |
| KIND_VICTORY_STRATEGY           |
| KIND_WMD                       |
| KIND_WAR                       |
| KIND_YIELD                   |
| KIND_PSEUDOYIELD               |
| KIND_DIPLOMACY_ALLIANCE       |
| KIND_DIPLOMACY_EMERGENCY       |
| KIND_GOVERNMENT               |
| KIND_GOVERNOR                   |
| KIND_GOVERNOR_PROMOTION       |
| KIND_LOYALTY_LEVEL           |
| KIND_MOMENT                   |
| KIND_MOMENT_DATA               |
| KIND_MOMENT_OUTCOME           |
| KIND_MOMENT_ILLUSTRATION       |
| KIND_RESOLUTION               |
| KIND_DISCUSSION               |
| KIND_PROPOSAL_TYPE           |
| KIND_VOTING_BLOCKER           |
| KIND_PROPOSAL_BLOCKER           |
| KIND_MINORCIVBONUS           |
| KIND_NAMED_RIVER               |
| KIND_NAMED_VOLCANO           |
| KIND_NAMED_MOUNTAIN           |
| KIND_NAMED_DESERT               |
| KIND_NAMED_LAKE               |
| KIND_NAMED_SEA               |
| KIND_NAMED_OCEAN               |
| KIND_COASTAL_LOWLAND           |
| KIND_RANDOM_EVENT               |
| KIND_REALISM_SETTING           |
| KIND_ROCKBAND_RESULT           |