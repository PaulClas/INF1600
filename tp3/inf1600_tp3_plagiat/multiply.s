.globl matrix_multiply_asm

matrix_multiply_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        BEG:
                mov 20(%ebp),%esi               #mettre matorder dans %esi
                push $0                         #initialiser r à 0 sur la pile -4(%ebp)
                push $0                         #initialiser c à 0 sur la pile -8(%ebp)
                push $0                         #initialiser i à 0 sur la pile -12(%ebp)
                push $0                         #initialiser elem à 0 sur la pile -16(%ebp)

        FOR1:
                mov $0,%ebx                     #Remmettre c à 0                
                mov %ebx,-8(%ebp) 

                mov -4(%ebp),%ebx               #Comparer r à matorder <
                cmp %ebx,%esi
                jg FOR2                         #if: entrer dans le for2
                
                jmp END                         #else: sauter à la fin
        
        FOR2:
                mov $0,%ebx                     #Remmettre i à 0                
                mov %ebx,-12(%ebp) 

                mov -8(%ebp),%ebx               #Comparer c à matorder <   
                cmp %ebx,%esi
                jle END_FOR1                    

                mov $0,%ebx                     #Remmettre elem à 0                
                mov %ebx,-16(%ebp) 
                jmp FOR3

        FOR3:
                mov -12(%ebp),%ebx               #Comparer i à matorder <   
                cmp %ebx,%esi
                jle END_FOR2  
                
                mov 12(%ebp),%ebx               #push inmatdata2[c + r * matorder]
                mov -4(%ebp),%eax               
                mov 20(%ebp),%ecx
                mul %ecx
                mov -8(%ebp),%ecx
                add %ecx,%eax
                push (%ebx,%eax,4)

                mov 8(%ebp),%ebx                #ecx <- inmatdata1[i + r * matorder]
                mov -4(%ebp),%eax               
                mov 20(%ebp),%ecx
                mul %ecx
                mov -12(%ebp),%ecx
                add %ecx,%eax
                mov (%ebx,%eax,4),%ecx

                pop %eax                        #%eax <- inmatdata1[i + r * matorder] * inmatdata2[c + i * matorder]
                mul %ecx
                
                add %eax,-16(%ebp)              #elem += eax
                
                             
                mov -4(%ebp),%eax               #ecx <- c + r * matorder            
                mov 20(%ebp),%ecx
                mul %ecx

                mov -8(%ebp),%ecx               #outmatdata[c + r * matorder] = elem
                add %ecx,%eax                  
                mov 16(%ebp),%ebx
                mov -16(%ebp),%ecx
                mov %ecx,(%ebx,%eax,4)  

                jmp END_FOR3


        END_FOR3:

                mov -12(%ebp),%ebx               #++i
                inc %ebx
                mov %ebx,-12(%ebp)
                
                jmp FOR3                        #Revenir en haut de la boucle for3



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
                leave          /* restore ebp and esp */
                ret            /* return to the caller */
