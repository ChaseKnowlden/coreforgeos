org 0x7C00
use16

start:
mov si, hello
call printfunc

mov si, cr
call printfunc
jmp start

forever:
    jmp forever

;usage
; mov si, STR_ADDR
; call printfunc
printfunc:
    lodsb               ; loads [si] into al then (since DF = 0) si++
    or al, al           ; if al == 0
    jz .printfunc_end
    mov ah, byte 0Eh    ; setup the INT10,E interrupt
    mov bx, word 03h
    int 10h             ; call the interrupt
    jmp printfunc
.printfunc_end:
    ret


hello:      db "Hello, boot world!",0
cr:         db 13h,0

pad:        db 510 - ($ - $$) dup 0
boot_sig:   db 55h, 0AAh
