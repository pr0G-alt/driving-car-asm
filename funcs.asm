; background = draw background
; init = initialize sprite data
; draw = draw sprite
; clearDown = clear upper row when moving down
; clearUp = clear lower row when moving up
; clearRight = clear right column when moving left
; clearLeft = clear left row when moving right


background proc
    lea si, bgData
    mov cx, 0
    mov dx, 0
    mov ah, 0ch
    
bgLoop:
    mov al, [si]
    int 10h
    inc si
    inc cx
    cmp cx, 320
    je bgNextLine
    jmp bgLoop
    
bgNextLine:
    mov cx, 0
    inc dx
    cmp dx, 200
    jne bgLoop

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
    mov cx, posX
    mov dx, colStop
    dec dx
    mov ah, 0ch
clearDownLoop:
    mov al, 23
    int 10h
    inc cx
    cmp cx, rowStop
    jl clearDownLoop
    
    ret
clearDown endp

clearUp proc
    mov cx, posX
    mov dx, posY
    mov ah, 0ch
clearUpLoop:
    mov al, 23
    int 10h
    inc cx
    cmp cx, rowStop
    jl clearUpLoop
    
    ret
clearUp endp

clearRight proc
    dec rowStop
    mov cx, rowStop
    mov dx, posY
    mov ah, 0ch
clearRightLoop:
    mov al, 23
    int 10h
    inc dx
    cmp dx, colStop
    jl clearRightLoop
    
    ret
clearRight endp

clearLeft proc
    mov cx, posX
    mov dx, posY
    mov ah, 0ch
clearLeftLoop:
    mov al, 23
    int 10h
    inc dx
    cmp dx, colStop
    jl clearLeftLoop
    
    ret
clearLeft endp