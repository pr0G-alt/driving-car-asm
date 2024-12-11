; background = draw background
; init = initialize sprite data
; draw = draw sprite
; clearDown = clear upper row when moving down
; clearUp = clear lower row when moving up
; clearRight = clear right column when moving left
; clearLeft = clear left row when moving right


background proc
    mov posX, 0
    mov posY, 0
    lea si, bgData
    mov width, 320
    mov height, 200
    call init
    call draw
    
    ret
background endp

init proc
    mov ax, width
    add ax, posX
    mov rowStop, ax
    mov ax, height
    add ax, posY
    mov colStop, ax
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
    cmp dx, colStop
    jne drawLoop

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
    cmp bx, 2
    jl clearDown2
    
    ret
clearDown endp

clearUp proc
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
    cmp bx, 2
    jl clearUp2
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
    cmp bx, 2
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
    cmp bx, 2
    jl clearLeft2
    
    ret
clearLeft endp