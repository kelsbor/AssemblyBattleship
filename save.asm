RandomMatrix PROC
    Random si
    cmp si,0
    je Level0
    cmp si,1
    je Level1
    cmp si,2
    je Level2
    cmp si,3
    je Level3
    cmp si,4
    je Level4
    cmp si,5
    je Level5

Level0:
    zerar si
    zerar bx

    mov al,MJ2[bx][si]
    mov MATRIXSHIP[bx][si],al
    inc si
    cmp si,20
    je zl0
    jmp Level0

zl0:
    add bx,si
    zerar si
    cmp bx,400
    je FRM
    jmp Level0

Level1:
    zerar si
    zerar bx

    mov al,MJ1[bx][si]
    mov MATRIXSHIP[bx][si],al
    inc si
    cmp si,20
    je zl1
    jmp Level1

zl1:
    add bx,si
    zerar si
    cmp bx,400
    je FRM
    jmp Level1

Level2:
    zerar si
    zerar bx

    mov al,MJ1[bx][si]
    mov MATRIXSHIP[bx][si],al
    inc si
    cmp si,20
    je zl2
    jmp Level2

zl2:
    add bx,si
    zerar si
    cmp bx,400
    je FRM
    jmp Level2

Level3:
    zerar si
    zerar bx

    mov al,MJ1[bx][si]
    mov MATRIXSHIP[bx][si],al
    inc si
    cmp si,20
    je zl3
    jmp Level3

zl3:
    add bx,si
    zerar si
    cmp bx,400
    je FRM
    jmp Level3

Level4:
    zerar si
    zerar bx

    mov al,MJ1[bx][si]
    mov MATRIXSHIP[bx][si],al
    inc si
    cmp si,20
    je zl4
    jmp Level4

zl4:
    add bx,si
    zerar si
    cmp bx,400
    je FRM
    jmp Level4

Level5:
    zerar si
    zerar bx

    mov al,MJ1[bx][si]
    mov MATRIXSHIP[bx][si],al
    inc si
    cmp si,20
    je zl5
    jmp Level5

zl5:
    add bx,si
    zerar si
    cmp bx,400
    je FRM
    jmp Level5

RandomMatrix ENDP