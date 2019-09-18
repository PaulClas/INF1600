.globl matrix_equals_asm

matrix_equals_asm:
        push %ebp      /* Save old base pointer */
        mov %esp, %ebp /* Set ebp to current esp */
		
		mov 16(%ebp), %esi 	#On met matorder dans %esi
        push $0
        push $0
        jmp for1
        

	for1:

		mov -4(%ebp), %edx
		cmp %edx, %esi		#On verifie si r < matorder
        ja temp
        jmp end
		
		
	temp:
		mov $0, %edx		#mettre c a 0
		mov %edx, -8(%ebp)	#ajout Paul
		jmp for2
		
	for2:
		mov -8(%ebp), %edx
		cmp %edx, %esi		#On verifie si c < matorder
		ja  if				#On rentre dans l'evaluation du if
		jmp increment_r		#On va incrementer r


	if:
		mov -4(%ebp), %eax 		# On met r dans eax
		
		xor %edx, %edx			#On met edx à 0 pour s'assurer de la multiplication
		mul %esi				# On met r * matorder dans eax (matorder est deja dans esi)
		mov -8(%ebp), %ecx		# On met c dans ebx
		add %ecx, %eax 			# On met c + r * matorder dans eax
		
		mov 8(%ebp),%ebx 		# On met inmatdata1 dans ebx
		mov (%ebx, %eax, 4), %edx #On met inmatdata1[c + r*matorder] dans %edx
		
		mov 12(%ebp),%edx 		# On met inmatdata2 dans edi
		mov (%edx, %eax, 4), %edi	#On met inmatdata2[c + r*matorder] dans %edi
		
		cmp %edi, %edx
		
		#On verifie la condition du if
		
		
		je true
		jmp increment_c

	increment_r:
		mov -4(%ebp), %ebx
		inc %ebx	
		mov %ebx, -4(%ebp)	#++r
		jmp for1
		
		
	increment_c:
		mov -8(%ebp), %ebx
		inc %ebx
		mov %ebx, -8(%ebp) #++c
		jmp for2

	true:
		mov $0, %eax
		leave   
		ret


	end:
		mov $1, %eax
		leave
		ret

