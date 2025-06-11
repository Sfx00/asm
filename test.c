
#include <stdlib.h>

typedef struct s_list
{
    void    *content;
    struct s_list   *next;
} t_list;


void ft_lstadd_front(t_list **p, t_list *new);

#include <stdio.h>

int main()
{
    char *str = "hello";
    char *new = ft_strdup(str);
    printf("%s", new);
    free(new);
}