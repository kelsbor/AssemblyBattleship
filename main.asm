title AssemblyBattleship
zerar MACRO reg
    xor reg,reg
ENDM
.model small
.data
    matrixuser      db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
                    db 20 dup('+')
    matrixbarco
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
                    db 20 dup('?')
.stack 0100h
.code

print_matrix PROC
    mov ah, 2
    zerar bx
    zerar si

    printar:
        cmp bx,20
        je pular
        mov dl, matrix[bx + si]
        int 21h
        inc bx
        jmp printar

    pular:
        cmp si,380
        je fim
        mov dl, 10
        int 21h
        add si,20
        zerar bx
        jmp printar

    fim:
        mov ah, 4CH
        int 21h
print_matrix ENDP

main PROC
    mov ax, @data
    mov ds, ax

    call print_matrix

    mov ah, 4CH
    int 21h 
main ENDP
END main
