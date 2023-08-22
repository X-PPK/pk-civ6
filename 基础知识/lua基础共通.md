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

- 使战例子

local n = math.random(3);

n的随机范围1，2，3

local m = Game.GetRandNum(3);

m的随机范围0，1，3

所以如果我这里是从1开始随机数生成那么使用

local n = Game.GetRandNum(3) + 1;

（如果不是从1开始肯定要修改，关键看你自己随机范围喽）

#### lua查询游戏数据库方法
- 是的你可以直接在lua获得游戏数据库内容，有两种方法
##### 常规简单方法
##### 复杂高级方法
- 使用官方lua一个接口：DB.Query，它执行一个查询语句
- 你可以用它来直接在lua里面建立一个更为复杂的表，而不是专门跑到数据库去专门建立一个表，我个人认为这个方法值得推广
- 下面是示范：
```lua
local results = DB.Query([[
	select UnitAbilityType, Value
	from UnitAbilityModifiers as uam, ModifierArguments as ma
	where uam.ModifierId = ma.ModifierId and ma.Name = 'Amount' and
	uam.ModifierId in (
		select ModifierId
		from Modifiers as m
		where m.ModifierType in (
			select dm.ModifierType
			from DynamicModifiers as dm
			where dm.EffectType = 'EFFECT_ADJUST_UNIT_EXPERIENCE_MODIFIER'))
]]);
-- 下面我来详细说明一下，如果你对sql熟悉的话————没错这里用的就是sql的语言
-- local results = DB.Query([[执行一个查询语句，将查询结果存储在本地变量results中。
-- 注意到该语句使用了两个方括号"[["来引用查询语句，是为了避免在语句中有特殊字符需要转义。
-- 下面的逗号可以看成分开但同步进行的操作
-- select UnitAbilityType, Value
-- 这里是要获得两个参数的UnitAbilityType, Value
--    from UnitAbilityModifiers as uam, ModifierArguments as ma
-- 这部分是查询语句的核心部分，指定了查询的目标列UnitAbilityType, Value 所分别对应查询的表 UnitAbilityModifiers, ModifierArguments。
-- 其中as相当于加了一个中间变量名（别名），也就是后面用uam代替UnitAbilityModifiers，用ma代替ModifierArguments
--[[ --这段就是需要满足的条件通过and将前面两者联系起来 ，这里用and联系各个关系表示需要同时满足
	where uam.ModifierId = ma.ModifierId and ma.Name = 'Amount' and
	uam.ModifierId in (
		select ModifierId
		from Modifiers as m
		where m.ModifierType in (
			select dm.ModifierType
			from DynamicModifiers as dm
			where dm.EffectType = 'EFFECT_ADJUST_UNIT_EXPERIENCE_MODIFIER'))));
]] --条件1 uam.ModifierId = ma.ModifierId，也就是ModifierArguments 和UnitAbilityModifiers 表的参数ModifierId相同时的UnitAbilityType和Value
-- 条件2 ma.Name = 'Amount' 也就是ModifierArguments的参数Name要为Amount
-- 条件3 uam.ModifierId要满足 in (条件）这是继续套娃，到这里就懒得解释那么清楚，还不懂就去好好学习sql
```

#### LUA数据可视化方法
使用 `print()` 函数来打印 table，但是它只会输出 table 的地址。为了更好地可视化 table 数据，你可以使用 Lua 内置的 `table` 库中的一些函数来实现。

下面是一个示例，展示了如何使用 `table` 库的一些函数来格式化输出 table 数据：
- 通过递归地遍历 table 中的每个键值对，并根据值的类型进行判断，我们可以将 table 的内容格式化输出得更加清晰可读。你可以根据需要对 `printTable()` 函数进行扩展和自定义，以适应不同的数据结构和输出格式。
```lua
local function printTable(t, indent)
    indent = indent or 0

    for k, v in pairs(t) do
        if type(v) == "table" then
            print(string.rep(" ", indent) .. k .. ": {")
            printTable(v, indent + 4)
            print(string.rep(" ", indent) .. "}")
        else
            print(string.rep(" ", indent) .. k .. ": " .. tostring(v))
        end
    end
end

-- 示例数据
local data = {
    name = "皮凯",
    age = 120,
    address = {
        star = "皮皮星",
        state = "幻想国",
        city = "滑稽乡",
        street = "皮稽街K号"
    },
    hobbies = {"吃饭", "睡觉", "打豆豆"}
}

printTable(data)
```

运行这段代码将会输出以下结果：

```
name: 皮凯
age: 120
address: {
    star: 皮皮星
    state: 幻想国
    city: 滑稽乡
    street: 皮稽街K号
}
hobbies: {
    1: 吃饭
    2: 睡觉
    3: 打豆豆
}
```
##### 补充： `indent + 4` 是用来增加每一级嵌套的缩进量的。在 `printTable()` 函数中，我们使用递归来处理嵌套的 table。每进入一层嵌套，我们都会增加缩进的量，以便在输出中呈现出层次结构的清晰可读性。

在上面例子中，每次递归调用 `printTable()` 函数时，我们将 `indent` 参数增加 4，这样每层嵌套的缩进增加 4 个空格。

具体如下面这个示例的嵌套 table：

```lua
local data = {
    name = "John",
    address = {
        street = "123 Main St",
        city = "New York"
    }
}
```

第一级的键值对 `name` 和 `address` 的输出将有一个缩进（4个空格），而第二级的键值对 `street` 和 `city` 将有两个缩进（8个空格），以此类推。

增加缩进量有助于在输出中显示层次结构，更好地可视化嵌套的 table 数据。你可以根据需要自定义缩进量的大小。
