.data
	/* Votre programme assembleur ici... */
	i:
        .int 0
    j:
        .int 10

.global func_s

func_s:	
	mov i, %eax
	add $1, %eax
	mov %eax, i
	
	mov j, %ecx
	cmp %eax, %ecx
	jae for
	
	ret
	
for:
    mov d, %edx
    mov e, %ebx
    add %edx, %ebx
    mov b, %edx
    sub %edx, %ebx
    mov %ebx, a
    mov b, %ebx
    sub $1000, %ebx
    mov c, %edx
    add $500, %edx
    cmp %ebx, %edx
    ja ifu
    jna else
    
ifu: 
    mov c, %ebx
    sub $500, %ebx
    mov %ebx, c
    mov b, %edx
    cmp %ebx, %edx
    ja ifd
    jmp func_s
    
ifd:
    mov b, %ebx
    sub $500, %ebx
    mov %ebx, b
    jmp func_s

else:
    mov e, %ebx
    mov b, %edx
    sub %ebx, %edx
    mov %edx, b
    mov d, %edx
    add $500, %edx
    mov %edx, d

    jmp func_s
    
    
    
    
    
