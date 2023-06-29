#ifndef __STRING_H__
#define __STRING_H__

void* memcpy(void* dest, const void* src, size_t len);

void* memset(void* dest, int byte, size_t len);

void *malloc(size_t size);

void free(void *ptr);

long read(int fd, void *buf, size_t count);

int close(int fd);

int open(const char *pathname, int flags, ...);

#endif
