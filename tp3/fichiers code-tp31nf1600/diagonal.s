.global matrix_diagonal_asm

matrix_diagonal_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

       	mov 16(%ebp), %esi 	#On met matorder dans %esi
        sub $4, %esp 		#espace pour r
        sub $4, %esp 		#espace pour c
        #mov $0, -4(%ebp)	#On met r a 0, modif
		push $0				#ajout Paul
		push $0				#ajout Paul
        
        jmp for1
        

for1 :
		mov $0, %ebx		#ajout Paul
		cmp -4(%ebp), %esi	#On verifie si r < matorder
        ja temp
        jmp end
		
temp :
		#mov $0, -8(%ebp)	#On met c a 0
		jmp for2
		
for2 :
		cmp -8(%ebp), %esi	#On verifie si c < matorder
		ja if				#On rentre dans la condition du if
		jmp increment_r		#On va incrementer r

if:
		mov -4(%ebp), %edx
		mov -8(%ebp), %ebx	
		cmp %edx, %ebx		#Vérification de la condition, modif Paul, avant cmp %edx, $ebx
		je do
		jmp else			#modif Paul, avant jump else

do :
		mov -4(%ebp), %eax 		# On met r dans eax
		
		xor %edx, %edx			#On met edx à 0 pour s'assurer de la multiplication
		mul %esi				# On met r * matorder dans eax (matorder est deja dans esi)
		mov -8(%ebp), %ebx		# On met c dans ebx
		add %ebx, %eax 			# On met c + r * matorder dans eax
		
		mov 8(%ebp),%ecx 		# On met inmatdata dans ecx
		mov (%ecx, %eax, 4), %edx #On met inmatdata[c + r*matorder] dans %edx
		
		mov 12(%ebp),%ecx 		# On met outmatdata dans ecx
		mov %edx, (%ecx, %eax, 4) #On met inmatdata[c + r*matorder] dans outmatdata[c + r*matorder]
		
		jmp increment_c

else:
		mov -4(%ebp), %eax 		# On met r dans eax
		
		mul %esi				# On met r * matorder dans eax (matorder est deja dans esi)
		mov -8(%ebp), %ebx		# On met c dans ebx
		add %ebx, %eax 			# On met c + r * matorder dans eax
		
		mov 12(%ebp),%ecx 		# On met outmatdata dans ecx
		mov $0, %ebx			# ajout Paul
		mov %ebx, (%ecx, %eax, 4) #On met 0 dans outmatdata[c + r*matorder], modif paul, avant mov $0, (%ecx, %eax, 4)
		
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


end :
        leave          /* restore ebp and esp */
        ret
		

