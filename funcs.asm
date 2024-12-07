init proc
    mov ax, width
    add ax, posX
    mov rowStop, ax
    mov ax, width
    mov bx, height
    mul bx
    mov area, ax
    mov cx, posX
    mov dx, posY
    
    ret
init endp

draw proc
    mov ah, 0ch
    
drawLoop:
    mov al, [si]
    int 10h

    inc si
    inc cx
    cmp cx, rowStop
    je nextLine
    jmp drawLoop
    
nextLine:
    mov cx, posX
    inc dx
    cmp si, area
    jne drawLoop
    
    ret
draw endp