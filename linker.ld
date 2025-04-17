/* linker.ld */

ENTRY(_start)

SECTIONS {
    /* Define memory layout */
    . = 0x100000;  /* Başlangıç adresi */

    .text :  {
        *(.text)  /* Tüm .text bölgesi, yani kod burada yer alacak */
    }

    .data :  {
        *(.data)  /* Veri segmenti */
    }

    .bss :  {
        *(.bss)  /* BSS (uninitialized) verileri */
    }

    /DISCARD/  { *(.note.GNU-stack) }
}

