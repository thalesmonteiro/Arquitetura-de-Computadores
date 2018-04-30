;------------------------------------------
; Função que converte de ASCII to Integer
;------------------------------------------
atoi:
    push    ebx             ; Guarda os valores na pilha para serem restaurados depois da execução da função
    push    ecx             
    push    edx             
    push    esi             
    mov     esi, eax        ; move para esi o numero a ser convertido
    mov     eax, 0          ; inicializa com 0
    mov     ecx, 0          
 
.multiplicaLoop:
    xor     ebx, ebx        ; Define os bits pra 0
    mov     bl, [esi+ecx]   ; Move um byte para bl
    cmp     bl, 48          ; Compara bl com o valor 48 da Ascii (char 0)
    jl      .fim            
    cmp     bl, 57          ; Compara bl com o valor 57 (char 9)
    jg      .fim            
    cmp     bl, 10          ; Compara bl com o valor 10 (nova linha)
    je      .fim            
    cmp     bl, 0           ; Compara bl com o valor 0 (final da string)
    jz      .fim     
 
    sub     bl, 48          ; converte bl para ascii 
    add     eax, ebx        ; adiciona ebx para o valor inteiro em eax (bl faz parte de ebx)
    mov     ebx, 10         ; move o valor 10 em decimal para ebx
    mul     ebx             ; multiplica eax por ebx 
    inc     ecx             ; Incrementa ecx (contador de registro)
    jmp     .multiplicaLoop ; continua em multiplicaLoop
 
.fim:
    mov     ebx, 10         ; move 10 para ebx
    div     ebx             ; divide eax por ebx
    pop     esi             ; Retorna para a pilha os valores puxados no inicio
    pop     edx             
    pop     ecx             
    pop     ebx             

ret

;------------------------------------------
; Converte de Inteiro pra String e Exibe
;------------------------------------------
itoa:
    push    eax             ; Guarda os valores na pilha para serem restaurados depois
    push    ecx            
    push    edx            
    push    esi            
    mov     ecx, 0          ; Conta quantos bytes precisamos para printar
 
divideLoop:
    inc     ecx             ; incrementa o numero de caracteres a ser exibido
    mov     edx, 0          ; esvazia edx
    mov     esi, 10         ; guarda 10 em esi 
    idiv    esi             ; divide eax by esi
    add     edx, 48         ; Converte edx para sua representação em ascii- edx guarda o valor depois das instruções de divide
    push    edx             ; pega edx(representação em string do inteiro) da pilha
    cmp     eax, 0          ; verifica se o inteiro pode ser divido
    jnz     divideLoop      ; se nao for zero jump para DivideLoop
 
ExibeLoop:
    dec     ecx             ; conta os byte que é colocado na pilha
    mov     eax, esp        ; move esp para eax para ser printado
    call    sprint          ; chama a função de print
    pop     eax             ; remove o ultimo caractere da pilha
    cmp     ecx, 0          ; verifica se foi printado todos os bytes
    jnz     ExibeLoop       ; se diferente de zero pula para ExibeLoop
 
    pop     esi             ; restaura os valores para a pilha
    pop     edx             
    pop     ecx             
    pop     eax             
    ret


;--------------------------------
; Função que exibe como String
;--------------------------------
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    
    push    ebx
    mov     ebx, eax
 
nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar
 
finished:
    sub     eax, ebx
    pop     ebx
 
    mov     edx, eax
    pop     eax
 
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h
 
    pop     ebx
    pop     ecx
    pop     edx
    ret