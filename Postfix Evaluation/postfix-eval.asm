; (C) Copyright 2018
; Georgescu Alin

%include "io.inc"

%define MAX_INPUT_SIZE 4096

section .bss
	    expr resb MAX_INPUT_SIZE

section .data
        ten dd 10

section .text
global CMAIN
CMAIN:
        push ebp
        mov ebp, esp
        
        GET_STRING expr, MAX_INPUT_SIZE
        
        xor eax, eax
        mov ecx, 0

repeta:
        xor edx, edx
        ; parcurgere sir caracter cu caracter
        mov dl,  byte [expr + ecx]

        ; algoritmul de opreste la intalnirea caracterului nul
        cmp edx, 0
        je final_sir
        
        cmp dl, ' '
        je spatiu
        
        cmp dl, '-'
        je minus
        
        cmp dl, '+'
        je adunare
        
        cmp dl, '*'
        je inmultire
        
        
        cmp dl, '/'
        je impartire

        ; caracterul este cifra, nu semn / spatiu
        mov ebx, edx
        sub ebx, '0'
        imul dword [ten]

        ; caz numere negative
        test eax, eax
        jl negativ

        ; caz numere pozitive
        add eax, ebx

        ; caz particular pentru numar nul
        test eax, eax
        jz zero

        jmp continua

negativ:
        ; adaugare cifra in numar negativ
        sub eax, ebx

continua:
        inc ecx
        jmp repeta

spatiu:
        cmp eax, 0
        je continua

zero:
        push eax
        xor eax, eax
        jmp continua

minus:
        ; verific daca - este pentru numar negativ sau scadere
        inc ecx
        mov dl,  byte [expr + ecx]

        cmp dl, ' '
        je scadere

        cmp dl, 0
        je scadere

        mov eax, 0
        sub dl, '0'
        sub eax, edx
        inc ecx

        jmp repeta
        
scadere:
        pop ebx
        pop eax
        sub eax, ebx
        push eax
        xor eax, eax
        xor ebx, ebx

        jmp continua
        
adunare:
        pop ebx
        pop eax
        add eax, ebx
        push eax
        xor eax, eax
        xor ebx, ebx

        jmp continua

inmultire:
        pop ebx
        pop eax
        imul eax, ebx
        push eax
        xor eax, eax
        xor ebx, ebx
        xor edx, edx

        jmp continua
        
impartire:
        pop ebx
        pop eax
        cdq
        idiv ebx
        push eax
        xor eax, eax
        xor ebx, ebx
        xor edx, edx   

        jmp continua
        
final_sir:
        pop eax
        PRINT_DEC 4, eax
        NEWLINE

        xor eax, eax
        pop ebp
        ret
