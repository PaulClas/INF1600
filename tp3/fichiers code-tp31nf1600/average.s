.global matrix_row_aver_asm

matrix_row_aver_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

		mov 16(%ebp), %esi 	#On met matorder dans %esi
        sub $4, %esp 		#espace pour r
        sub $4, %esp 		#espace pour c
        sub $4, %esp 		#espace pour elem
        #mov $0, -4(%ebp)	#On met r a 0, modif Paul
        
        jmp for1
		
for1 :
		#mov $0, %ebp		#ajout Paul
		cmp -4(%ebp), %esi	#On verifie si r < matorder
        ja temp
        jmp end
	
temp :
		#mov $0, -12(%ebp) 	#On met elem a 0
		#mov $0, -8(%ebp)	#On met c a 0
		mov $0, %ebp		#ajout Paul
		jmp for2
		
for2 :
		cmp -8(%ebp), %esi	#On verifie si c < matorder
		ja do				#On rentre dans l execution du do
		jmp division

do :
		mov -4(%ebp), %eax 		# On met r dans eax
		
		mul %esi				# On met r * matorder dans eax (matorder est deja dans esi)
		mov -8(%ebp), %ebx		# On met c dans ebx
		add %ebx, %eax 			# On met c + r * matorder dans eax
		
		mov 8(%ebp),%ecx 		# On met inmatdata dans ecx
		mov (%ecx, %eax, 4), %edx #On met inmatdata[c + r*matorder] dans %edx
		
		mov -12(%ebp), %ecx
		add %edx, %ecx
		mov %ecx, -12(%ebp) # on a fait le +=  inmatdata[c + r*matorder]
		
		jmp increment_c


division :
		mov -4(%ebp), %ebx	#On met r dans ebx
		mov 12(%ebp), %ecx	#On met outmatdata dans ecx
		
		xor %edx, %edx		#On met edx à 0 pour s'assurer de la division
		mov -12(%ebp), %eax	#On met elem dans eax
		idiv %esi			#elem/matorder va dans eax
							#et le reste va dans edx (mais on n'en a pas besoin, on fait une division entière)
		mov %eax, (%ecx, %ebx, 4) #outmatdata[r] = elem/matorder
		
		jmp increment_r		#On va incrementer r

increment_r:
		mov -4(%ebp), %ebx
		inc %ebx	
		mov %ebx, -4(%ebx)	#++r
		jmp for1
		
increment_c:
		mov -8(%ebp), %ebx
		inc %ebx
		mov %ebx, -8(%ebp) #++c
		jmp for2

end :
        leave          /* restore ebp and esp */
        ret
		
