#include <stdio.h>

int sum(int n){
    if(n==0)
        return 0;
    return (n%10) + sum(n/10);
}

int main(){
    int n;
    scanf("%d",&n);

    printf("Sum = %d", sum(n));
}

2.
#include <stdio.h>

int reverse(int n, int rev){
    if(n==0)
        return rev;
    return reverse(n/10, rev*10 + n%10);
}

int main(){
    int n, r;

    scanf("%d",&n);

    r = reverse(n,0);

    if(n==r)
        printf("Palindrome");
    else
        printf("Not Palindrome");
}
