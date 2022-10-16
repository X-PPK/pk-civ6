# 前言

modinfo是所有mod必备的(除非是那种替换官方文件的“mod”)

你可以理解为它是mod的身份证，这里记录了mod的有那些文件，以及加载mod文件的方法

游戏程序是读取他来确认mod各个文件应当怎么加载，当然部分文件实际是有加载规则的modinfo不设置也没问题，但这部分文件对在mod文件夹里位置有要求（例如mod的Platforms文件）

本文章是以H佬所讲为基础上而扩展细讲部分内容，默认来看的都已经了解过[H佬的 modinfo文件结构详解](https://www.bilibili.com/read/cv6792157)

回到正题下面开始讲解modinfo，这里都是我的经验总结，部分我也没用过，希望有懂得带佬给予补充

注意：

- 每一个mod在modindo要有自己的id，不能重复吗，如果重复则两个重复ID的mod实际会只有一个有效，屏蔽另一个mod效果，特别是测试自己mod更新了不同版本时，一定要把老版本删除，不然很可能新版本被老版本屏蔽效果。
- 任何一个 mod 文件名都不能与任何游戏原文件、或者其它玩家的 mod 文件重名，否者相同文件名会发生文件覆盖（部分文件可重复名字--主要是ArtDefs文件），除非一开始就是需要覆盖，例如修改官方部分文件，由于改动太多完全就打算进行覆盖，那么可以直接文件同名，在通过modinfo设置加载顺序进行覆盖
- Settings和Components应该是历史遗留问题总之Settings对应FrontEndActions实际效果一样，Components和InGameActions一样，实际效果没有区别

### modinfo的多语言说明（二级节点）
- 可以直接上文本，不中间增加文本变量，但这样只支持一种语言
- modinfo的文本想支持多种语言就只能通过LocalizedText定义文本变量在不同语言的文本，我们无法通过UpdateText来增加，官方的方法是直接游戏本体添加对应文本这个我门做不到
- 注意中文字符在游戏英文等部分拉丁语言状态下是无法显示字体的，所以建议和俺一样爱写中文的最好写一个对应英文，不然他们看到你的mod是一片乱码，就包括作者名
```
<?xml version="1.0" encoding="utf-8"?>
<Mod id="这里是mod的id" version="1">
  <Properties>
    <Name>测试mod</Name>
    <Description>LOC_PPK_DESCRIPTION</Description>
    <Teaser>LOC_PPK_TEASER</Teaser>
    <Authors>LOC_PPK_AUTHORS</Authors>
    <SpecialThanks>LOC_PPK_THANK</SpecialThanks>
    <CompatibleVersions>1.2,2.0</CompatibleVersions>
  </Properties>
  <LocalizedText>
    <Text id="LOC_PPK_AUTHORS">
      <en_US>[COLOR:ResCultureLabelCS]Handsome Kai(Pipikai)[ENDCOLOR]</en_US>
      <zh_Hant_HK>[COLOR:ResCultureLabelCS]帅气的凯（皮皮凯）[ENDCOLOR]</zh_Hant_HK>
      <zh_Hans_CN>[COLOR:ResCultureLabelCS]帅气的凯（皮皮凯）[ENDCOLOR]</zh_Hans_CN>
      <ja_JP>[COLOR:ResCultureLabelCS]帅气的凯「皮皮凯」[ENDCOLOR]</ja_JP>
    </Text>
    <Text id="LOC_PPK_DESCRIPTION">
      <en_US>XXXXX</en_US>
      <zh_Hans_CN>一个测试mod</zh_Hans_CN>
    </Text>
  </LocalizedText>
</Mod>
```

### mod测试（二级节点）
- Settings/FrontEndActions(前端加载项)

是游戏启动后就马上加载的，当游戏主菜单出现时，既前端加载过程完成，如果游戏已经启动后，你修改了mod文件是这里的那么一般需要重新启动
- Components/InGameActions(游戏内加载项)

是游戏开启对局加载的，你修改了这里的mod文件重新开局后一般就能体现，但如果确认自己修改确实没错，没有其他问题修改无效建议重启游戏在试一试(这是实践出来的)
- UImod的布局XML是热加载可以实时修改并看效果，UI的lua部分和Lua脚本则和上两条情况一样

### 选择性加载 Criteria（二级节点）
- Criteria有很多，你可以针对整个DLC，亦或者只是DLC里的一个模式，或者一个MOD，当然只是MOD里的一个模式也一样可以，一个Criteria针对也可以选择多个，例如GS和RF任意一个启动我们Criteria就启动
#### 下面是我的一些例子
```
    	<ActionCriteria>
		<Criteria id="PPKHAGI_mod"><!-- 这个是针对mod活跃才加载的文件，这里填入mod的ID -->
			<ModInUse>fba4a935-06f0-414b-973d-5ffcd80c6d0e</ModInUse>
		</Criteria>
		<Criteria id="BaseRulesets"><!-- 这个是针对官方标准版活跃才加载的文件 -->
			<RuleSetInUse>RULESET_STANDARD</RuleSetInUse>
		</Criteria>
		<Criteria id="Expansion_1"><!-- 这个是针对官方RF活跃才加载的文件 -->
			<RuleSetInUse>RULESET_EXPANSION_1</RuleSetInUse>
		</Criteria>
		<Criteria id="Expansion_2"><!-- 这个是针对官方GS版活跃才加载的文件 -->
			<RuleSetInUse>RULESET_EXPANSION_2</RuleSetInUse>
		</Criteria>
		<Criteria id="Expansion_1_2"><!-- 这个是针对官方RF或GS版活跃才加载的文件，这个如果玩家只有RF没有买GS不会启动 -->
			<RuleSetInUse>RULESET_EXPANSION_1,RULESET_EXPANSION_2</RuleSetInUse>
		</Criteria>
		<Criteria id="Indonesia_KhmerScenario"><!-- 这个是针对情景的文件，不同情景的RuleSetInUse值抄官方 -->
			<RuleSetInUse>RULESET_SCENARIO_INDONESIA_KHMER</RuleSetInUse>
		</Criteria>
		<Criteria id="PPKHAGI_XP1"><!-- 这个是针对官方RF下mod活跃才加载的文件-->
			<ModInUse>fba4a935-06f0-414b-973d-5ffcd80c6d0e</ModInUse>
			<RuleSetInUse>RULESET_EXPANSION_1</RuleSetInUse>
		</Criteria>
		<Criteria id="Ethiopia_Mode"><!-- 这个是针对官方结社模式才加载的文件，ConfigurationId这里输入模式ID，Value为1表示模式启动，为0关闭-->
			<ConfigurationValueMatches>
				<Group>Game</Group>
				<ConfigurationId>GAMEMODE_SECRETSOCIETIES</ConfigurationId>
				<Value>1</Value>
			</ConfigurationValueMatches>
		</Criteria>
	</ActionCriteria>
```
#### 关于领袖的Criteria（这个的用处主要避免一些情景模式加载这个领袖文件导致的BUG）
```
    	<ActionCriteria>
		<Criteria id="Expansion2AndBeyond" any="1"><!-- 这个是针对官方GS下领袖LEADER_XX或LEADER_XX2活跃才加载的文件-->
			<GameCoreInUse>Expansion2</GameCoreInUse>
			<LeaderPlayable>Players:Expansion2_Players::LEADER_XX,Players:Expansion2_Players::LEADER_XX2</LeaderPlayable>
		</Criteria>
		<Criteria id="Australia_Expansion1" any="1"><!-- 这个是针对官方RF下领袖LEADER_JOHN_CURTIN活跃才加载的文件-->
			<LeaderPlayable>Players:Expansion1_Players::LEADER_JOHN_CURTIN</LeaderPlayable>
			<RuleSetInUse>RULESET_EXPANSION_1</RuleSetInUse>
		</Criteria>
		<Criteria id="Expansion2AndBeyond" any="1"><!-- 这个是针对官方GS下领袖LEADER_XX或LEADER_XX2活跃才加载的文件-->
			<LeaderPlayable>Players:Expansion2_Players::LEADER_XX,Players:Expansion2_Players::LEADER_XX2</LeaderPlayable>
		</Criteria>
		<Criteria id="Australia" any="1"><!-- 这个是针对官方GS或RF或标准下领袖LEADER_JOHN_CURTIN活跃才加载的文件-->
			<LeaderPlayable>Players:StandardPlayers::LEADER_JOHN_CURTIN,StandardPlayers::LEADER_JOHN_CURTIN,Players:Expansion1_Players::LEADER_JOHN_CURTIN,Players:Expansion2_Players::LEADER_JOHN_CURTIN</LeaderPlayable>
			<RuleSetInUse>RULESET_STANDARD,RULESET_EXPANSION_1,RULESET_EXPANSION_2</RuleSetInUse>
		</Criteria>
	</ActionCriteria>
```
#### 额外扩展 ，官方GS和RF的Criteria还可以用GameCoreInUse，但这个没有对应官方标准版的值，这是官方后面更新添加内容
```
    	<ActionCriteria>
		<Criteria id="Expansion_1"><!-- 这个是针对官方RF活跃才加载的文件 -->
			<GameCoreInUse>Expansion1</GameCoreInUse>
		</Criteria>
		<Criteria id="Expansion_2"><!-- 这个是针对官方GS版活跃才加载的文件 -->
			<GameCoreInUse>Expansion2</GameCoreInUse>
		</Criteria>
	</ActionCriteria>

```


### 加载顺序（4级节点）
- 几乎各个文件加载都可以写它例如UpdateText等等
```
<UpdateText id="xx">
  <Properties>
     <LoadOrder>100</LoadOrder>
  <Properties>
  <File>xxxx.xml</File>
</UpdateText>
```

### 导入文件ImportFiles （3级节点）
- 它可以说是普通的文件导入，但给予了LoadOrder加载顺序，和Criteria选择性加载后，它也可以是实现兼容或者针对性修改其他DLC或mod的一个方法
- 如果只是普通的用它文件甚至没啥用，比如你添加一个修改游戏内数据库的你用这个就没有意义应该用UpdateDatabase
- 它可以用于直接的添加DDS美术素材，调用这个素材时的素材调用名就是这个DDS素材的文件名加后缀（可以去看我的mod PPK's UI 就是这样，因为需要的素材太少直接这样添加反而比专门导入官方工具方便多了，亦或者你需要测试素材也可以用这个方法，本人实战ICON.xml可调用和UI可调用）
#### 普通文件覆盖
- 会根据加载顺序自动覆盖同名文件
```
<ImportFilesid="xx">
  <Properties>
     <LoadOrder>100</LoadOrder>
  <Properties>
  <File>xxxx.xml</File>
</ImportFiles>
```
#### 给予Criteria
- 表示只有在GS活跃的情况下才加载这个mod（不是GS这个DLC启动，是GS活跃）--这个适用与其他mod或DLC
```
<ImportFilesid="xx" criteria="Expansion_2 ">
  <Properties>
     <LoadOrder>100</LoadOrder>
  <Properties>
  <File>xxxx.xml</File>
</ImportFiles>
```

### UImod添加（3级节点）
- 一个UI需要同名的xmL和lua文件组成，用AddUserInterfaces(游戏内加载项)添加
```
<AddUserInterfaces id="xx">
  <Properties>
     <LoadOrder>100</LoadOrder>
  <Properties>
  <File>xxxxUI.xml</File>
</AddUserInterfaces>
<Files>
   <File>xxxxUI.xml</File>
   <File>xxxxUI.lua</File>
</Files>
```
实际效果如上就能将UI添加成功了，但个人建议在增加一步，具体是为了可能的UI兼容，后面UI教程会讲
```
<ImportFiles id="xx">
  <Properties>
     <LoadOrder>100</LoadOrder>
  <Properties>
  <File>xxxxUI.xml</File>
  <File>xxxxUI.lua</File>
</ImportFiles>
```
- UI的lua脚本替换ReplaceUIScript(游戏内加载项)，这个常常与UImod兼容有关，我会在UI兼容教程讲述

### 添加地图（3级节点）
- 好吧这个我也懂得不多，没有深入研究过地图相关的这里分享一段我以前写的总结记得当时是给一个制作地图的朋友发的，我现在已经忘记这些了，有可能有错。还有一个相关的AddMap我没用过
```
<?xml version="1.0" encoding="utf-8"?>
<Mod id="XWK_0000_0000_0000">（这里是mod的id每个mod的id要不同自己改数字，一样会冲突使其中一个无法启动或是只有一个生效，括号里的是说明，看完删除）
	<Properties>
		<Name>在选择mod的页面显示的名字</Name>
        <Stability>Final</Stability>
		<Teaser>关于这个mod的小说明</Teaser>
		<Description>在选择mod的页面显示的说明可以详细介绍mod</Description>
	    <Authors>作者名字</Authors>	
		<CompatibleVersions>1.2,2.0</CompatibleVersions>
		<SpecialThanks>这里写感谢的人，没有吧这行删除。</SpecialThanks>
	</Properties>
    <FrontEndActions>
      <AddWorldBuilderMap id="AddSEAMap">
        <Properties>
          <Name>在创建游戏选择地图的页面显示的名字</Name>
          <Description>在创建游戏选择地图的页面显示的说明</Description>
          <Group>（填你地图的规则集，这行可以删除）例如StandardMaps是标准规则</Group>
        </Properties>
        <File>Maps/XXX.Civ6Map（这里打入这个地图mod中Civ6Map文件的路径这些括号汉字都要删除）</File>
      </AddWorldBuilderMap>
    </FrontEndActions>
    <Files>
      <File>Maps/XXX.Civ6Map(上同)</File>
    </Files>
</Mod>
```
### 其他（3级节点）
UpdateDatabase：更新数据库

UpdateIcons：更新/加入图标库

UpdateText：更新/加入文本库

UpdateColors：更新/加入颜色库

UpdateArt：更新/加入艺术文件

AddGameplayScripts：添加游戏脚本(游戏内加载项)

UpdateAudio 更新/加入音频(游戏内加载项)

ps：一定要区分游戏脚本和UI脚本，在游戏内加载方法不一样（官方的lua有两个环境要区分开，他们的官方接口很多不一样，你不能在其中一个环境调用另一个环境接口）