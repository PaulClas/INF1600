.global matrix_diagonal_asm

matrix_diagonal_asm:
        
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

		BEG:
                mov 16(%ebp),%esi               #mettre matorder dans %esi
                push $0                         #initialiser r à 0 sur la pile -4(%ebp)
                push $0                         #initialiser c à 0 sur la pile -8(%ebp)
		
        FOR1:
                
                mov $0,%ebx                     #Remmettre c à 0                
                mov %ebx,-8(%ebp) 

                mov -4(%ebp),%ebx               #Comparer r à matorder <
                cmp %ebx,%esi
                jg FOR2                         #if: entrer dans le for2
                
                jmp END                         #else: sauter à la fin

        FOR2:
                mov -8(%ebp),%ebx               #Comparer c à matorder <   
                cmp %ebx,%esi
                jle END_FOR1                   

                mov -8(%ebp),%ebx                #Si c != r aller au ELSE
                mov -4(%ebp),%ecx
                cmp %ebx,%ecx
                jne ELSE

                mov 8(%ebp),%ebx                #ecx <- inmatdata[c + r * matorder]
                mov -4(%ebp),%eax               
                mov 16(%ebp),%ecx
                mul %ecx
                mov -8(%ebp),%ecx
                add %ecx,%eax
                mov (%ebx,%eax,4),%ecx
                
                mov 12(%ebp),%ebx               #outmatdata[c + r * matorder] <- inmatdata[c + r * matorder]
                mov %ecx,(%ebx,%eax,4)

               

                jmp END_FOR2  
        ELSE:                                  
                mov 12(%ebp),%ebx               #ecx <- c + r * matorder
                mov -4(%ebp),%eax               
                mov 16(%ebp),%ecx
                mul %ecx
                mov -8(%ebp),%ecx
                
                add %ecx,%eax                   #outmatdata[ecx] <- 0
                mov $0, %ecx
                mov %ecx,(%ebx,%eax,4)              
                jmp END_FOR2


        END_FOR2:

                mov -8(%ebp),%ebx               #++c
                inc %ebx
                mov %ebx,-8(%ebp)
                
                jmp FOR2                        #Revenir en haut de la boucle for2


        END_FOR1:

                mov -4(%ebp),%ebx               #++r
                inc %ebx
                mov %ebx,-4(%ebp)
                
                jmp FOR1                        #Revenir en haut de la boucle for1


        END:
                leave          /* Restore ebp and esp */
                ret            /* Return to the caller */

