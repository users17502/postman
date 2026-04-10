#include <stdio.h>

struct hotel{
    char name[20];
    char address[30];
    int grade;
    int rooms;
    float charge;
};

void lessCharge(struct hotel h[], int n, float value){
    int i;
    for(i=0;i<n;i++){
        if(h[i].charge < value)
            printf("%s\n",h[i].name);
    }
}

void searchGrade(struct hotel h[], int n, int g){
    int i;
    for(i=0;i<n;i++){
        if(h[i].grade == g)
            printf("%s\n",h[i].name);
    }
}

int main(){
    struct hotel h[50];
    int n,i,g;
    float value;

    scanf("%d",&n);

    for(i=0;i<n;i++){
        scanf("%s %s %d %d %f",
        h[i].name,h[i].address,
        &h[i].grade,&h[i].rooms,&h[i].charge);
    }

    scanf("%f",&value);
    lessCharge(h,n,value);

    scanf("%d",&g);
    searchGrade(h,n,g);
}
