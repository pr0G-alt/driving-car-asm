; diffKey = wait to prees 1 or 2 for difficulty
; enterKey = wait to press ENTER

; rand = generate a random value from an array

; init = initialize image data
; clip = avoid problems with drawing outside the frame
; draw = draw image with initialized data

; clearDown = clear upper row when moving down
; clearUp = clear lower row when moving up
; clearRight = clear right column when moving left
; clearLeft = clear left row when moving right

diffKey proc
diffWait:
    mov ah, 0h
    int 16h
    
    ; check the pressed key to specify difficulty ;
    cmp al, '1'
    je easyMode
    cmp al, '2'
    je hardMode
    cmp al, 1bh ; ESC key
    je exit1
    
    jmp diffWait
    
easyMode:
    mov diff, 1 ; hole speed
    ret   
hardMode:
    mov diff, 2
    ret
exit1:
    mov ax, 4C00h
    int 21h
    ret
diffKey endp

enterKey proc
enterWait:
    mov ah, 0h
    int 16h
    cmp al, 0dh ; ENTER key
    je return
    cmp al, 1bh
    je exit2

    jmp enterWait
    
exit2:
    mov ax, 4C00h
    int 21h
return:
    ret
enterKey endp

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
    cmp colStop, 200 ; check if vertical position is out of the bottom of the window
    jge clipDown
clipStart:
    mov ax, dx
    test ax, ax ; check if vertical is out of the top of the window (negative)
    jns clipEnd
    inc dx
    add si, width ; go to the next row until reaching the row supposed to be drawn
    jmp clipStart
clipEnd:
    ret
clipDown:
    mov colStop, 200
    ret
clip endp

draw proc
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
    mov al, 23 ; dark grey
    int 10h
    inc cx
    cmp cx, rowStop
    jl clearDownLoop
    inc bx
    cmp bx, speed ; clear number of rows depending of speed count
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