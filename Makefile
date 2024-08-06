# Makefile 用于编译简单的C程序

# 设置编译器
CC=gcc

# 设置编译标志，-Wall 用于开启所有警告，-g 用于生成调试信息
CFLAGS=-Wall -g

# 定义源文件列表
SOURCES=main.c

# 通过模式替换将源文件扩展名从 .c 替换为 .o，生成目标文件列表
OBJECTS=$(SOURCES:.c=.o)

# 定义可执行文件的名称
PROGRAM=check_port

# 编译目标 "all"，用于编译并链接程序
all: $(PROGRAM)

# 规则：编译并链接目标文件生成可执行文件
$(PROGRAM): $(OBJECTS)
	# 使用 $(CC) 编译器和 $(CFLAGS) 标志将目标文件链接成可执行文件
	$(CC) $(CFLAGS) -o $@ $^

# 规则：将源文件编译为目标文件
%.o: %.c
	# 使用 $(CC) 编译器和 $(CFLAGS) 标志编译源文件为目标文件
	$(CC) $(CFLAGS) -c $< -o $@

# 清理目标，用于删除编译产生的目标文件和可执行文件
clean:
	# 删除所有目标文件和可执行文件
	rm -f $(OBJECTS) $(PROGRAM)

# 运行目标，用于运行编译后的程序
run: $(PROGRAM)
	# 运行可执行文件并传递参数 $(ARG)，ARG 可以在 make 命令行中指定
	./$(PROGRAM) $(ARG)

# 设置 ARG 变量，如果没有在命令行中指定，则默认为空
ARG ?=

# 默认目标设置为 "all"
.DEFAULT_GOAL := all


# 添加 install 目标
install: $(PROGRAM)
	# 检查目录是否存在，如果不存在则创建
	test -d /usr/local/bin || mkdir -p /usr/local/bin
	# 将可执行文件复制到 /usr/local/bin
	cp $(PROGRAM) /usr/local/bin/

# 添加 uninstall 目标
uninstall:
	# 移除安装的可执行文件
	rm -f /usr/local/bin/$(PROGRAM)