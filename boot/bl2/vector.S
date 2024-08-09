#include <library/common/asm_macros_common.S>
#include <library/common/asm_macros_aarch64.S>

    .globl  runtime_exceptions

    .globl  sync_exception_sp_el0
    .globl  irq_sp_el0
    .globl  fiq_sp_el0
    .globl  serror_sp_el0

    .globl  sync_exception_sp_elx
    .globl  irq_sp_elx
    .globl  fiq_sp_elx
    .globl  serror_sp_elx

    .globl  sync_exception_aarch64
    .globl  irq_aarch64
    .globl  fiq_aarch64
    .globl  serror_aarch64

    .globl  sync_exception_aarch32
    .globl  irq_aarch32
    .globl  fiq_aarch32
    .globl  serror_aarch32


vector_base runtime_exceptions

/* ---------------------------------------------------------------------
 * Current EL with SP_EL0 : 0x0 - 0x200
 * ---------------------------------------------------------------------
 */
vector_entry sync_exception_sp_el0
    b .
end_vector_entry sync_exception_sp_el0

vector_entry irq_sp_el0
    b .
end_vector_entry irq_sp_el0


vector_entry fiq_sp_el0
    b .
end_vector_entry fiq_sp_el0


vector_entry serror_sp_el0
    b .
end_vector_entry serror_sp_el0

/* ---------------------------------------------------------------------
 * Current EL with SP_ELx: 0x200 - 0x400
 * ---------------------------------------------------------------------
 */
vector_entry sync_exception_sp_elx
    b .
end_vector_entry sync_exception_sp_elx

vector_entry irq_sp_elx
    b .
end_vector_entry irq_sp_elx

vector_entry fiq_sp_elx
    b .
end_vector_entry fiq_sp_elx

vector_entry serror_sp_elx
    b .
end_vector_entry serror_sp_elx

/* ---------------------------------------------------------------------
 * Lower EL using AArch64 : 0x400 - 0x600
 * ---------------------------------------------------------------------
 */
vector_entry sync_exception_aarch64
    b .
end_vector_entry sync_exception_aarch64

vector_entry irq_aarch64
    b .
end_vector_entry irq_aarch64

vector_entry fiq_aarch64
    b .
end_vector_entry fiq_aarch64

vector_entry serror_aarch64
    b .
end_vector_entry serror_aarch64

/* ---------------------------------------------------------------------
 * Lower EL using AArch32 : 0x600 - 0x800
 * ---------------------------------------------------------------------
 */
vector_entry sync_exception_aarch32
    b .
end_vector_entry sync_exception_aarch32

vector_entry irq_aarch32
    b .
end_vector_entry irq_aarch32

vector_entry fiq_aarch32
    b .
end_vector_entry fiq_aarch32

vector_entry serror_aarch32
    b .
end_vector_entry serror_aarch32
