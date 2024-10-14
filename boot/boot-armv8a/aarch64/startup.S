#include <common/asm_macros.S>

    .globl  image_entrypoint

func image_entrypoint
    mov x0, #0
    mov x1, #1
    mov x2, #2
    mov x3, #3
    mov x4, #4
    mov x5, #5
    b   .
endfunc image_entrypoint
