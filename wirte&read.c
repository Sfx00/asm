#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

int ft_read(int fd, char *buffer, size_t length)
{
    struct stat statbuf;
    int size = fstat(fd, &statbuf);
    if(size < 0)
        return(-1);

    char *p = mmap(NULL, statbuf.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    if(!p)
        return(-1);

    int i = 0;
    while(i < length && i < statbuf.st_size)
    {
        buffer[i] = p[i];
        i++;
    }
    munmap(p, length);        
    return(i);
}


int ft_write(int fd, const char *buffer, size_t length)
{
    struct stat statbuf;
    int size = fstat(fd, &statbuf);
    if(size < 0)
        return(-1);

    char *p = mmap(NULL, statbuf.st_size, PROT_WRITE, MAP_SHARED, fd, 0);
    if(!p)
        return(-1);

    int i = 0;
    while(i < length && i < statbuf.st_size)
    {
        p[i] = buffer[i];
        i++;
    }
    munmap(p, length);
    return(i);
}


int main()
{
    char *p = (char *)malloc(sizeof(10));
    int fd = open("main.c", O_RDONLY);
    int a = ft_read(fd, p, 9);
    p[10] = '\0';
    printf("%s\n---->%d", p, a);
    
}