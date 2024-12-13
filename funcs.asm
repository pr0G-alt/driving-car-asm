; init = initialize image data
; draw = draw image with initialized data

; clearDown = clear upper row when moving down
; clearUp = clear lower row when moving up
; clearRight = clear right column when moving left
; clearLeft = clear left row when moving right


rand proc
    mov ax, randSeed
    mov dx, 25173
    mul dx
    add ax, 13849
    mov randSeed, ax
    xor dx, dx
    mov cx, randSize
    div cx
    mov ax, dx
    
    mov bx, ax

    lea si, randArr
    shl bx, 1
    add si, bx

    mov ax, [si]
    mov randVal, ax

    ret
rand endp

init proc
    mov ax, width
    add ax, posX
    mov rowStop, ax 
    mov ax, height
    add ax, posY
    mov colStop, ax
   
    mov cx, posX
    mov dx, posY
    
    ret   
init endp

clip proc
    cmp colStop, 200
    jg clipDown
clipStart:
    mov ax, dx
    test ax, ax
    jns clipEnd
    inc dx
    add si, width
    jmp clipStart
clipEnd:
    ret
clipDown:
    mov colStop, 200
clip endp

draw proc
    mov ah, 0Dh
    mov bh, 0
    int 10h

    mov bl, al
    
    cmp bl, 18
    jne detectSkip
    mov detect, 1
    
detectSkip:
    
    mov ah, 0ch

drawLoop:
    
    mov al, [si]
    int 10h
    
    inc si
    inc cx
    cmp cx, rowStop
    jl drawLoop
    
    mov cx, posX
    inc dx
    cmp dx, colStop
    jl drawLoop

    ret
    
draw endp

clearDown proc 
    mov dx, colStop
    mov bx, 0
clearDown2:
    mov cx, posX
    dec dx
    mov ah, 0ch
clearDownLoop:
    mov al, 23
    int 10h
    inc cx
    cmp cx, rowStop
    jl clearDownLoop
    inc bx
    cmp bx, speed
    jl clearDown2

    ret
clearDown endp

clearUp proc
    mov bx, height
    cmp colStop, bx
    jl clearUpSkip

    mov bx, 0
    mov cx, posX
    mov dx, posY
clearUp2:
    mov ah, 0ch
clearUpLoop:
    mov al, 23
    int 10h
    inc cx
    cmp cx, rowStop
    jl clearUpLoop
    inc dx
    mov cx, posX
    inc bx
    cmp bx, speed
    jl clearUp2
clearUpSkip:
    ret
clearUp endp

clearRight proc
    dec rowStop
    mov cx, rowStop
    mov bx, 0
clearRight2:
    mov dx, posY
    mov ah, 0ch
clearRightLoop:
    mov al, 23
    int 10h
    inc dx
    cmp dx, colStop
    jl clearRightLoop
    dec cx
    inc bx
    cmp bx, speed
    jl clearRight2
    
    ret
clearRight endp

clearLeft proc
    mov cx, posX
    mov bx, 0
clearLeft2:
    mov dx, posY
    mov ah, 0ch
clearLeftLoop:
    mov al, 23
    int 10h
    inc dx
    cmp dx, colStop
    jl clearLeftLoop
    inc cx
    inc bx
    cmp bx, speed
    jl clearLeft2
    
    ret
clearLeft endp