.globl matrix_multiply_asm

matrix_multiply_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
                push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

		mov 20(%ebp), %esi 	#On met matorder dans %esi
        sub $4, %esp 		#espace pour r -4(%ebp)
        sub $4, %esp 		#espace pour c -8(%ebp)
        sub $4, %esp 		#espace pour i -12(%ebp)
		sub $4, %esp 		#espace pour elem -16(%ebp)
        #mov $0, -4(%ebp)	#On met r a 0, modif Paul
		push $0				#ajout Paul
        
        jmp for1
		
for1 :
		cmp -4(%ebp), %esi	#On verifie si r < matorder
        ja temp
        jmp end
	
temp :
		#mov $0, -8(%ebp)	#On met c a 0
		jmp for2
		
for2 :
		cmp -8(%ebp), %esi	#On verifie si c < matorder
		ja temp2			
		jmp increment_r

temp2 :
		#mov $0, -16(%ebp)	#On met elem a 0, modif Paul
		#mov $0, -12(%ebp) 	#On met i a 0, modif Paul
		mov $0, %ebp		#ajout Paul
		jmp for3

for3 :
		cmp -12(%ebp), %esi	#On verifie si i < matorder
		ja do				#On rentre dans l execution du do
		jmp attribution
		
do :
		mov -4(%ebp), %eax 		# On met r dans eax
		
		xor %edx, %edx			#On s'assure que edx est bien à 0
		mul %esi				# On met r * matorder dans eax (matorder est deja dans esi)
		mov -12(%ebp), %ebx		# On met i dans ebx
		add %ebx, %eax 			# On met i + r * matorder dans eax
		
		mov 8(%ebp),%ecx 		# On met inmatdata1 dans ecx
		mov (%ecx, %eax, 4), %ebx #On met inmatdata1[i + r*matorder] dans %ebx
		
		mov -12(%ebp), %eax 	# On met i dans eax
		
		xor %edx, %edx			#On s'assure que edx est bien à 0
		mul %esi				#On met i * matorder dans eax (matorder est deja dans esi)
		mov -8(%ebp), %edx		#On met c dans edx
		add %edx, %eax 			#On met c + i * matorder dans eax
		
		mov 12(%ebp),%ecx 		#On met inmatdata2 dans ecx
		mov (%ecx, %eax, 4), %edx #On met inmatdata2[c + i*matorder] dans %edx
		
		mov %edx, %eax
		xor %edx, %edx			#On s'assure que edx est bien à 0
		mul %ebx				#On met inmatdata2[c + i*matorder] * inmatdata1[i + r*matorder] dans eax
		
		mov -16(%ebp), %ecx
		add %eax, %ecx
		mov %ecx, -16(%ebp) 	# on a fait le elem += inmatdata2[c + i*matorder] * inmatdata1[i + r*matorder]
		
		jmp increment_i

attribution :
		mov -4(%ebp), %eax 		# On met r dans eax
		
		xor %edx, %edx			#On s'assure que edx est bien à 0
		mul %esi				#On met r * matorder dans eax (matorder est deja dans esi)
		mov -8(%ebp), %edx		#On met c dans edx
		add %edx, %eax 			#On met c + r * matorder dans eax
		
		mov 16(%ebp),%ecx 		# On met outmatdata dans ecx
		mov -16(%ebp), %edx		# On met elem dans edx
		mov %edx, (%ecx, %eax, 4) # outmatdata[c + r * matorder] = elem
		jmp increment_c

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

increment_i:
		mov -12(%ebp), %ebx
		inc %ebx
		mov %ebx, -12(%ebp) #++i
		jmp for3
		
end :
        leave          /* restore ebp and esp */
        ret
        
