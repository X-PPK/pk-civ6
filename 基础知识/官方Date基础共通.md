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
<details><summary>Kind列常用值</summary>	

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
| KIND_COLLECTION              | 集合            | 
| KIND_EFFECT                  | 效果类型        | 
| KIND_MODIFIER                | 修改器类型      | 由上面两个构成MODIFIER
| KIND_REQUIREMENT             | 需求限制        | 
| KIND_REQUIREMENTSET          | 需求设置        | 
</details>

- Types：
```
<!-- PS：各种Type变量都需要先在Types这里定义的KING，KING指向Kinds表-->
<Types
	Type="各种Type变量"	X值类型="TEXT"		默认值="NULL"
	Hash="散列值"		X值类型="INTEGER"	默认值="0"		注释="不用填，自动生成"
	Kind="实际类型"		值类型="NULL"		默认值="false"	注释="官方例子明治维新"
/>
```