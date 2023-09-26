# Sid Meier's Civilization VI开发工具（Sid Meier's Civilization VI Development Tools）
- 如果你已经steam上下载官方工具Sid Meier's Civilization VI Development Tools，那么可以在steamapps\common\Sid Meier's Civilization VI SDK\Documentation查看到官方原教程,只需要把我汉化的教程html文件下载加入就可以使用
- 如果你没有下载，也可以下载我这里的文件使用记得除了html文件其他也要，或者说我这里“CIV6官方教程汉化”文件夹整个直接打包就是了
- 官方原教程我这里也有文件打包到：“英文原版html.zip”
- 为了正常使用html文件记得不要动其他文件夹及里面照片名字，否则html文件或者md文件无法正常显示图片
- LoadOrder，HallofFame_Frontend，HallofFame_Backend三个html教程官方都全整合到Civ6Docs里了，所以我就不在转为md文件了

## 包含的工具

### ModBuddy

ModBuddy是一个专为模组制作者设计的集成开发环境（IDE），它基于微软的Visual Studio 2013。这个工具是用于开发模组的主要工具。

然而，需要注意的是，并非一定需要使用这个工具来创建模组。.modinfo格式是纯粹的XML，可以手动编写。

### Steam Workshop Uploader

（Steam创意工坊上传工具）

这个上传工具是一个独立的工具，用于将模组上传到Steam创意工坊。

### FireTuner

(Fire调试器)

FireTuner是一个可以连接到游戏的运行时调试控制台。对于设计师来说，在游戏进行时检查各种游戏性方面非常有用。

### Art/Asset Tools

（艺术/资源工具）

SDK中包含了一套艺术工具。这些工具可以通过ModBuddy的“工具”菜单访问。其中许多资源工具需要打开一个模组项目才能启动。

## Additional Development Assets

（额外的开发资源）

对于大多数与艺术相关的模组，需要中间游戏资源才能正确引用和/或替换这些资源。这些资源很大（大约30 GB）。为了减小那些不需要这些资源的模组制作者的下载大小，它们已被移动到一个单独的Steam工具入口中。

这些资源存储在“Sid Meier's Civilization VI开发资源”中。

ModBuddy将尝试自动发现这些资源，但如果它们被安装到自定义位置，可能会遇到问题。在ModBuddy中，导航到Tools->Options->Civilization VI（“工具”->“选项”->“Civilization VI”），将'Civilization VI Assets Path'（“Civilization VI资源路径”）设置为资源的根文件夹。

默认情况下，通常是： C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization VI SDK Assets
