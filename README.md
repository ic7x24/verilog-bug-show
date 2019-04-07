# Verilog错误代码展示:仿真错误

## Syntax error, unexpected / not declared

常见基本语法错误

- 模块声明`parameter`缺少`#` 
- 端口列表不全
- `,`或者`;`
- 括号匹配不全
- `begin`和`end`匹配不全
- 关键字拼写错误
- 缺少`endmodule`
- 特殊符号`'` , `\``,  `?`, `:`, `"`
- 非ASCII字符，全角半角错误
- 常量或参数没有正确定义
- 变量或者端口没有正确声明
- 模块没有正确定义
- `include路径未添加

## Illegal reference/port/left-hand side to ...

变量类型定义错误

- wire变量在always描述中赋值
- 使用assign针对reg类型赋值
- 实例化的输出端口连接到reg类型
- `<=` 与`< =` : 多了空格

## Can't resolve multiple ..

赋值方式错误

- 阻塞赋值与非阻塞赋值混用
- 同一信号在多处被赋值驱动
- 在两个以上always内对同一变量赋值
