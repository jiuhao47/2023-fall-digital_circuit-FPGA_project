#include <stdio.h>
#include <stdbool.h>
int main(void)
{
    int n, count = 0;
    scanf("%d", &n);
    bool number[n + 1]; // 素数列表
    int prime[n + 1];
    memset(number, true, sizeof(number));
    for (int i = 2; i <= n; i++)
    {
        if (number[i]) // 1
            prime[count++] = i;
        for (int j = 0; j < count && prime[j] * i <= n; j++) // 2
        {
            number[prime[j] * i] = false;
            if (i % prime[j] == 0)
                break;
        }
    }
    for (int i = 2; i < n + 1; i++)
        if (number[i] == true)
            printf("%d\n", i);
    return 0;
}

// 欧式筛法的C实现