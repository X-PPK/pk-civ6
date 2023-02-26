咕咕咕，先整理数据库后面来写lua

#### lua随机数生成
- （注意在lua实现随机数生成如果是联机模式就必须保证随机数生成一致，否则数据不同步会有bug

在文明6的lua里目前已知有两个随机生成树工具

- 第一个就是lua自带的随机数生成工具math.random，这个无法保证数据库同步

使用例子

math.random()，产生[0, 1)之间的浮点随机数。

math.random(n)，产生[1, n]之间的整数。

math.random(m, n)，产生[m, n]之间的整数


- 第二个就是官方的一个随机数生成工具，这个可以保证联机情况下数据同步

Game.GetRandNum()，这个我没测试过，不晓得

Game.GetRandNum(n)，产生[0, n-1]之间的整数。

Game.GetRandNum(m, n)，产生[m-1, n-1]之间的整数

也就是说一般使用Game.GetRandNum要加1（他属于game环境的lua）