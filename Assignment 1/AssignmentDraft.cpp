#include<stdio.h>
#include<stdlib.h>

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

    // char filename1[100],filename2[100];
    // printf("Enter first file location\n");
    // scanf("%s",&filename1);

    // printf("Enter second file location\n");
    // scanf("%s",&filename2);

    f1 = fopen(filename1 ,"r");
    f2 = fopen(filename2 ,"r");
    O1 = fopen(filename3 ,"w");
    O2 = fopen(filename4 ,"w");

    if(f1 == NULL)
    {
        printf("Cannnot open file %s \n", filename1 );
    }
    if(f2 == NULL)
    {
        printf("Cannnot open file %s \n", filename2 );
    }

    char Name[50][100];
    char Name2[50][100];
    char Address[50][100];
    char Address2[50][100];
    char BG[50][5];
    char Salary[50][10];


    // char fileOne[10000];
    // char fileTwo[10000];


    //code for file1

    char c;
    int i = 0 ;

    // while(1)
    // {
    //     fscanf(f1,"%c",&c);
    //     if(c == EOF)
    //     {
    //         fileOne[i] = EOF;
    //         break;
    //     }
    //     fileOne[i] = c;
    //     ++i;
    // }
    
    
    while(c!='.') //problem here, doesn't show anything if EOF, shows first row if \n
    {

    for(int  j = 0 ;  ; j++)
    {
        fscanf(f1,"%c",&c);
        if(c == ',')
        {
            Name[i][j] = '\0';
            break;
        }
        Name[i][j] = c;
    }

    for(int  j = 0 ;  ; j++)
    {
        fscanf(f1,"%c",&c);
        if(c == ',')
        {
            Address[i][j] = '\0';
            break;
        }
        Address[i][j] = c;
    }

    for(int  j = 0 ;  ; j++)
    {
        fscanf(f1,"%c",&c);
        if(c == '\n' || c == '.')
        {
            BG[i][j] = '\0';
            break;
        }
        BG[i][j] = c;
    }
    
    ++i;

    }


    

   
    

    









    //code for file 2
    i = 0;
    c = ' ';
    while(c!='.') //problem here, doesn't show anything if EOF, shows first row if \n
    {

    for(int  j = 0 ;  ; j++)
    {
        fscanf(f2,"%c",&c);
        if(c == ',')
        {
            Name2[i][j] = '\0';
            break;
        }
        Name2[i][j] = c;
    }

    for(int  j = 0 ;  ; j++)
    {
        fscanf(f2,"%c",&c);
        if(c == ',')
        {
            Address2[i][j] = '\0';
            break;
        }
        Address2[i][j] = c;
    }

    for(int  j = 0 ;  ; j++)
    {
        fscanf(f2,"%c",&c);
        if(c == '\n' || c == '.')
        {
            if(c == '\n')
                Salary[i][j] = '\0';
            else
                Salary[i][j] = '.';
            break;
        }
        Salary[i][j] = c;
    }
    
    ++i;

    }




    //output version 1 here
    i=0;
    char ch;
    while(ch != '.')
    {
        for(int j = 0 ; ; j++)
        {
            ch = Name[i][j];
            if(ch == '\0')
            {
                fputc(',',O1);
                break;
            }
            fprintf(O1,"%c",ch);
        }

        for(int j = 0 ; ; j++)
        {
            ch = Address[i][j];
            if(ch == '\0')
            {
                fputc(',',O1);
                break;
            }
            fprintf(O1,"%c",ch);
        }

        for(int j = 0 ; ; j++)
        {
            ch = BG[i][j];
            if(ch == '\0')
            {
               fputc(',',O1);
                break;
            }
            fprintf(O1,"%c",ch);
        }

        for(int j = 0 ; ; j++)
        {
            ch = Salary[i][j];
            if(ch == '\0' || ch == '.')
            {
                if(ch == '\0')
                    fputc('\n',O1);
                else
                    fputc('.',O1);
                break;
            }
            fprintf(O1,"%c",ch);
        }

        

        
    ++i;





    }







    //output version 2 here
    
    //finding B+ blood type

  









    printf("%s\n",Name[2]);
    printf("%s\n",Address[3]);
    printf("%s\n",BG[4]);
    // printf("%s\n",Name[1]);
    // printf("%s\n",Address[1]);
    // printf("%s\n",BG[1]);
    //printf("%c\n",c);

    fclose(f1);
    fclose(f2);
    fclose(O1);
    fclose(O2);



    return 0;





}
