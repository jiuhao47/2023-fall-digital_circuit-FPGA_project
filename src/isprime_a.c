#include <stdio.h>
#define MAXSIZE 100000
int main()
{
    int num[MAXSIZE];
    for (int i = 0; i < MAXSIZE; i++)
    {
        num[i] = 1;
    }
    for (int i = 2; i * i <= MAXSIZE; i++)
    {
        if (num[i])
        {
            for (int j = i + i; j < MAXSIZE; j += i)
            {
                num[j] = 0;
            }
        }
    }

    for (int i = 0; i < MAXSIZE; i++)
    {
        if (num[i])
        {
            printf("%d ", i);
        }
    }
    return 0;
}