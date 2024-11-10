.model small
.stack 100h
.data
    arr db 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.code
main proc
    mov ax,@data
    mov ds,ax

    call random
    call transforma
    mov ah,2
L1:
    

    mov ah,4CH
    int 21h
main endp

random proc
    mov ah, 0
    int 1ah

    mov ax, dx
    mov dx, 0
    mov bx, 100
    div bx

    mov cl,al

LR1:
    cmp si,20
    je LR2
    inc si
    loop LR1
    jmp Rfim
LR2:
    xor si,si
    loop LR1
Rfim:
    ret
random endp

transforma proc
    xor ax,ax
    xor dx,dx
    xor cx,cx
    xor bx,bx
    mov bl,10
    mov al,arr[si]

LT1:
    div bx   ;o problema está nesta parte, em AX
    push dx
    inc cx
    cmp al,20h
    jge AXbugado
    cmp al,0
    je LP1
    jmp LT1

AXbugado:
    jmp LP1

LP1:
    xor ax,ax
    mov ah,2
    xor dx,dx
    pop dx
    add dl,30h
    int 21h
    loop LP1
    ret

Tfim:
ret
transforma endp
end main