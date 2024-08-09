#ifndef COMMON_UTILS__H
#define COMMON_UTILS__H

#if defined(__ASSEMBLER__)
#   define U(_x)       (_x)
#   define UL(_x)      (_x)
#   define ULL(_x)     (_x)
#   define L(_x)       (_x)
#   define LL(_x)      (_x)
#else
#   define U(_x)       ((unsigned int)(_x))
#   define UL(_x)      ((unsigned long)(_x))
#   define ULL(_x)     ((unsigned long long)(_x))
#   define L(_x)       ((long)(_x))
#   define LL(_x)      ((long long)(_x))
#endif

#endif  /* !COMMON_UTILS__H */
