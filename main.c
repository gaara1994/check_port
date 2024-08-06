#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

int main(int argc, char *argv[])
{
    // 参数校验
    if (argc != 2)
    {
        fprintf(stderr, "Usage: %s <port>\n", argv[0]);
        return EXIT_FAILURE;
    }

    // 参数转成int类型
    int port = atoi(argv[1]);
    char command[100];
    // 拼接命令
    sprintf(command, "sudo lsof -i :%d", port);
    // 执行命令
    int res = system(command);

    // 检查 system() 的返回值
    if (res == -1)
    {
        fprintf(stderr, "Failed to execute command: %s\n", strerror(errno));
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}