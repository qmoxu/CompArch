.model small
.stack 100h
.data
    parameters db 255 DUP ('$')
    paramsLen db ?
.code
main PROC
    mov ax, @data
    mov ds, ax
    call params
    mov ah, 9
    lea dx, params
    int 21h
    mov ax, 4C00h
    int 21h
main ENDP

params PROC
    xor ch, ch
    mov cl, es:[80h]  
    dec cl
    mov paramsLen, cl
read_one:
    test cl, cl        
    jz toRet
    mov si, 81h        
    add si, cx
    mov bx, offset params
    add bx, cx
    mov al, es:[si]
    mov byte ptr [bx-1], al
    dec cl
    jmp read_one
toRet:
    ret
params ENDP

END main