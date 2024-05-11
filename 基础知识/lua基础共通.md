咕咕咕，先整理数据库后面来写lua

#### lua随机数生成
- （注意在lua实现随机数生成如果是联机模式就必须保证随机数生成一致，否则数据不同步会有bug

在文明6的lua里目前已知有两个随机生成树工具

- 第一个就是lua自带的随机数生成工具math.random，这个无法保证数据库同步

使用例子

math.random()，产生[0, 1)之间的浮点随机数。

math.random(n)，产生[1, n]之间的整数。

math.random(m, n)，产生[m, n]之间的整数

注意：正常情况 n,m不能是负数，m要大于n，m最大值推测和你启动游戏版本是32位和64位有关

- 第二个就是官方的一个随机数生成工具，这个可以保证联机情况下数据同步
正常使用n要大于1
且为整数
否则：
Game.GetRandNum(1)，只会返回1
Game.GetRandNum()，只会返回1

大于1时：
Game.GetRandNum(n)，产生[0, n-1]之间的整数。

其他情况：
如果你输入数值是分数n.m（lua中应该称呼浮点）那么会自动向下取整，
Game.GetRandNum(n.m) 产生[0, n-1]之间的整数，与m小数部分无关

数值限定范围应该是二进制16位，既10进制数值65,535，也就是正常情况Game.GetRandNum最大生成范围是0~65,535，包括0和65,535
如果你输入数值是负数实测应该是循环回到支持最大数，既65,535
我无法确定最大是65,535，实测中输入非常大参数超过65,535，随机生成数值均未超过65,535，但多次大于64,000，也有过大于65,000，根据这个判段应该是16位

也就是说一般使用Game.GetRandNum要加1（他属于game环境的lua）

- 使战例子

local n = math.random(3);

n的随机范围1，2，3

local m = Game.GetRandNum(3);

m的随机范围0，1，2

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
local data = {
    name = "皮凯",
    address = {
        star = "皮皮星",
        state = "幻想国"
    }
}
```

第一级的键值对 `name` 和 `address` 的输出将有一个缩进（4个空格），而第二级的键值对 `star` 和 `state` 将有两个缩进（8个空格），以此类推。

增加缩进量有助于在输出中显示层次结构，更好地可视化嵌套的 table 数据。你可以根据需要自定义缩进量的大小。

#### do...end 语句用法

```lua
local localFunc = function() -- 额外扩展 或者这样声明 local function localFunc() -- 两种声明方式结果一样 第一种是声明localFunc变量对于后续定义的匿名函数，第二种直接声明函数localFunc，结果角度都一样都由localFunc变量指向对应函数，所以一般情况，这个就看个人习惯
```

- 在 Lua 中，do...end 语句用于创建一个匿名的代码块，它可以包含任意的 Lua 语句，包括定义局部变量和函数。这种用法通常用于在需要的地方临时封装一段代码，而不必定义一个单独的函数。换句话说 do...end 用来创建一个局部作用域，其中定义的变量和函数只在这个代码块内有效，不会污染全局环境。

- 是不是初看觉得类似把do...end 部分代码块用local声明为一个局部函数，然后在这里调用运行该函数，直接do...end 做到同样效果但更加精简且省略这些步骤

```lua
-- 两者初看结果相同
do
    local x = 123
    print(x)
end
local localFunc = function()
    local x = 123
    print(x)
end
localFunc()
```
- 但实际上单独看这里最后效果是这样，但实际应用中不止于此，在 Lua 中，do...end 并不直接等同于将代码块声明为一个局部函数并立即调用它。do...end 主要用于创建一个新的作用域，而不是定义函数。只是最后效果类似单个局部函数直接声明直接调用。
- 区别1，这些在 do...end 块内定义的局部变量和函数执行完毕后就会被销毁，它们的作用域仅限于 do 和 end 之间的代码。如下正常情况只有在调用他的外部如xx才会被使用，否则无法直接调用，而局部函数可以调用变量名直接重复调用

```lua
function xx()
    do
        local x = 123
        print(x)
    end
    --省略其他代码
end
```

- 区别2，在 Lua 中，使用 local 关键字声明的函数或变量已经具有局部作用域，这意味着它们不会污染全局作用域。不过，do...end 提供了更细粒度的作用域控制，它的主要作用在于进一步限制局部变量和函数的可见范围，使得它们仅在该代码块内有效。
换句话说，当谈到“污染外部作用域”的问题时，local 函数本身就已经解决了这个问题，因为它仅在其声明的范围内可见。但是，do...end 块提供了额外的层次，即：
    - 局部函数声明 (local function ... end 或 local ... = function ... end)：确保函数定义在局部作用域内，不会与外部作用域中的同名函数冲突。但这个local函数本身的声明有可能发生污染
    - do...end 块：不仅限于函数定义，它还可以用于任何代码块，进一步限制了所有在该块内声明的局部变量和函数的作用域，使得这些定义在块外不可见，


```lua
function xx()
    do
        local x = 123
        print(x)
    end
    --省略其他代码
    -- 这里的例子可能较为愚蠢，但在实际应用可能由于变量名类似或者字母大小写或者更换代码维护人员等问题导致发生污染
    local localFunc = function()
        local x = 123
        print(x)
    end
    -- 省略其他代码
    localFunc = yyy -- 发生污染，变成yyy函数了
    --省略其他代码
    localFunc() -- 此时就变成yyy运行了


    --省略其他代码 （这里作为一段新代码来看）
    local localFunc = function() print("333") end -- 其他维护人员没注意localFunc 已被声明
    localFunc()
end
```

- 总计：如果为了进一步排除被变量名污染干扰，应当使用do...end ，可以避免一些维护错误，当然local函数并运行可实现相同效果，使用 local局部函数，主要是可以多次被使用，而do...end 虽然更安全精简但不能被多次调用只能在运行外部时运行一次，也就是如果只是运行一次的局部函数需求采用do...end 或许可以更精简和安全，但多次还是需要使用 local局部函数，当然他们可以互相嵌套，总之结合实际需要来