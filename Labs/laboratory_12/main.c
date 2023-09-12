#include<stdio.h>
#include<string.h>
#include<stdlib.h>
int maxValue(int, int);
int write(int);
int main()
{
    char str[101];
    char str2[100];
    FILE *file;
    file = fopen("max.txt", "wb+");
    gets(str);
    int i=0, nr, max=0, max2;
    while(i<strlen(str))
    {
        if(str[i]<='9' && str[i]>='0')
        {
            //char str2[100];
            str2[0] = '\0';
            int j=0;
            while(str[i]<='9' && str[i]>='0')
            {
                str2[j] = str[i];
                j++;
                i++;
            }
            str2[j] = '\0';
            //printf("string: %s ", str2);
            nr = atoi(str2);
            //printf("value: %d\n", nr);
            max2 = maxValue(max, nr);
            max = max2;
            //printf("%d", max);
        }
        else{
            i++;
        }
        
    }
    nr = atoi(str2);
    //printf(" %d\n", nr);
    max2 = maxValue(max, nr);
    max = max2;
    fprintf(file, "%x", max);
    return 0;
}