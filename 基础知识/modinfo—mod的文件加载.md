# 前言

modinfo是所有mod必备的(除非是那种替换官方文件的“mod”)

你可以理解为它是mod的身份证，这里记录了mod的有那些文件，以及加载mod文件的方法

游戏程序是读取他来确认mod各个文件应当怎么加载，当然部分文件实际是有加载规则的modinfo不设置也没问题，但这部分文件对在mod文件夹里位置有要求（例如mod的Platforms文件）

本文章是以H佬所讲为基础上而扩展细讲部分内容，默认来看的都已经了解过[H佬的 modinfo文件结构详解](https://www.bilibili.com/read/cv6792157)

回到正题下面开始讲解modinfo，这里都是我的经验总结

注意：

- 每一个mod在modindo要有自己的id，不能重复吗，如果重复则两个重复ID的mod实际会只有一个有效，屏蔽另一个mod效果，特别是测试自己mod更新了不同版本时，一定要把老版本删除，不然很可能新版本被老版本屏蔽效果。
- 任何一个 mod 文件名都不能与任何游戏原文件、或者其它玩家的 mod 文件重名，否者相同文件名会发生文件覆盖（部分文件可重复名字--主要是ArtDefs文件），除非一开始就是需要覆盖，例如修改官方部分文件，由于改动太多完全就打算进行覆盖，那么可以直接文件同名，在通过modinfo设置加载顺序进行覆盖
- Settings和Components应该是历史遗留问题总之Settings对应FrontEndActions实际效果一样，Components和InGameActions一样，实际效果没有区别

### modinfo的多语言说明gdf
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

#### mod测试
- Settings/FrontEndActions(前端加载项)

是游戏启动后就马上加载的，当游戏主菜单出现时，既前端加载过程完成，如果游戏已经启动后，你修改了mod文件是这里的那么一般需要重新启动
- Components/InGameActions(游戏内加载项)
是游戏开启对局加载的，你修改了这里的mod文件重新开局后一般就能体现，但如果确认自己修改确实没错，没有其他问题修改无效建议重启游戏在试一试(这是实践出来的)
- Components/InGameActions(游戏内加载项)
- UImod的布局XML是热加载可以实时修改并看效果，UI的lua部分和Lua脚本则和上两条情况一样

#### 加载顺序
- 几乎各个文件加载都可以写它例如UpdateText等等
```
<UpdateText id="xx">
  <Properties>
     <LoadOrder>100</LoadOrder>
  <Properties>
  <File>xxxx.xml</File>
</UpdateText>
```

#### UImod添加
- 一个UI需要同名的xmL和lua文件组成，用AddUserInterfaces添加
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

#### 添加地图
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
