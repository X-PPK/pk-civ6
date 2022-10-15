# 前言

modinfo是所有mod必备的(除非是那种替换官方文件的“mod”)

你可以理解为它是mod的身份证，这里记录了mod的有那些文件，以及加载mod文件的方法

游戏程序是读取他来确认mod各个文件应当怎么加载，当然部分文件实际是有加载规则的modinfo不设置也没问题，但这部分文件对在mod文件夹里位置有要求（例如mod的Platforms文件）

本文章是以H佬所讲为基础上而扩展细讲部分内容，默认来看的都已经了解过[H佬的 modinfo文件结构详解](https://www.bilibili.com/read/cv6792157)

回到正题下面开始讲解modinfo

注意：

- 每一个mod在modindo要有自己的id，不能重复吗，如果重复则两个重复ID的mod实际会只有一个有效，屏蔽另一个mod效果，特别是测试自己mod更新了不同版本时，一定要把老版本删除，不然很可能新版本被老版本屏蔽效果。
- 任何一个 mod 文件名都不能与任何游戏原文件、或者其它玩家的 mod 文件重名，否者相同文件名会发生文件覆盖（部分文件可重复名字--主要是ArtDefs文件），除非一开始就是需要覆盖，例如修改官方部分文件，由于改动太多完全就打算进行覆盖，那么可以直接文件同名，在通过modinfo设置加载顺序进行覆盖


### modinfo整体
- 这里的汉字是说明
```
<?xml version="1.0" encoding="utf-8"?>
<Mod id="这里是mod的id" version="1">
  <Properties>
    <Name>这里是mod名字可用文本变量</Name>
    <Description>这里是mod详细介绍可用文本变量[-]</Descriptioxn>
    <Teaser>这里是mod概括提示可用文本变量[-]</Teaser>
    <Authors>这里是mod作者可用文本变量</Authors>
    <Homepage></Homepage>
    <SpecialThanks>这里写特别感谢可用文本变量[-]</SpecialThanks>
    <AffectsSavedGames>这里默认值为0，当为0时表示mod不影响存档，为1表示影响存档，不写这个就默认0</AffectsSavedGames>
    <CompatibleVersions>兼容版本1.2,2.0</CompatibleVersions>
  </Properties>
  <FrontEndActions>
  </FrontEndActions>
  <InGameActions>
  </InGameActions>
  <Files>
  </Files>
</Mod>
```

#### 更新数据库

```
    <UpdateDatabase id="">
      <File></File>
    </UpdateDatabase>
```

#### 更新文本

```
    <UpdateText id="">
      <File></File>
    </UpdateText>
```

#### 模组标题、描述等多语言支持，放在`<Properties>`同一级

```
  <LocalizedText>
    <Text id="">
      <en_US></en_US>
      <zh_Hans_CN></zh_Hans_CN>
    </Text>
  </LocalizedText>
```