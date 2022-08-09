#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main()
{
    FILE *f1;
    FILE *f2;
    FILE *O1;
    FILE *O2;

    char filename1[100] = "D:\\SWE-20\\CSE 4307 DBMS\\Assignment 1\\file1.txt";
    char filename2[100] = "D:\\SWE-20\\CSE 4307 DBMS\\Assignment 1\\file2.txt";


    char filename3[100] = "D:\\SWE-20\\CSE 4307 DBMS\\Assignment 1\\OutputV1.txt";
    char filename4[100] = "D:\\SWE-20\\CSE 4307 DBMS\\Assignment 1\\OutputV2.txt";


    f1 = fopen(filename1 ,"r");
    f2 = fopen(filename2 ,"r");
    O1 = fopen(filename3 ,"w");
    O2 = fopen(filename4 ,"w");

    if(f1 == NULL || f2 == NULL || O1 == NULL || O2 == NULL)
    {
        printf("Cannnot open file(s)");
    }

    // char *Name[50];
    // //char *Name2[50];
    // char *Address[50];
    // //char *Address2[50];
    // char *BG[50];
    // char *Salary[50];

    
    char file1[10000];
    char file2[10000];
    


    while(fgets(file1,10000,f1) && fgets(file2,10000,f2))
    {
        char *name;
        char *address;
        char *BG;
        char *salary;
        char *data1[3];
        char *data2[3];

        char *token1 = strtok(file1, ",");

            int i = 0;
            while(token1 != NULL)
            {
                data1[i++] = token1;
                token1 = strtok(NULL, ",");
            }

            int j = 0;
            char *token2 = strtok(file2, ",");
            while(token2 != NULL)
            {
                data2[j++] = token2;
                token2 = strtok(NULL, ",");
            }

            name = data1[0];
            address = data1[1];
            BG = data1[2];
            salary = data2[2];
            
            int k = 0;
            
            while(BG[k] != '\0')
            {
                if(BG[k] == '\n')
                {
                    BG[k] = '\0';
                }
                ++k;
            }



            fprintf(O1, "%s,%s,%s,%s" , name,address,BG,salary);

            if(BG[0] == 'B' && BG[1] == '+')
            {
                fprintf(O2, "%s,%s,%s,%s" , name,address,BG,salary);
            }

    }

    printf("Complete!");

    fclose(f1);
    fclose(f2);
    fclose(O1);
    fclose(O2);

    return 0;
}