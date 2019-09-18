.globl matrix_equals_asm

matrix_equals_asm:
        push %ebp      /* Save old base pointer */
        mov %esp, %ebp /* Set ebp to current esp */

        #Revenir ici pour les types
        
        

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
                jg IF                           #if: entrer dans if
                jmp END_FOR1                    #else: sauter à la fin du for1

        IF:
                mov 8(%ebp),%ebx                #ecx <- inmatdata1[c + r * matorder]
                mov -4(%ebp),%eax               
                mov 16(%ebp),%ecx
                mul %ecx
                mov -8(%ebp),%ecx
                add %ecx,%eax
                mov (%ebx,%eax,4),%ecx

                mov 12(%ebp),%edx               #edi <- inmatdata2[c + r * matorder]
                mov (%edx,%eax,4),%edi
                
                cmp %edi,%ecx                   #inmatdata1[c + r * matorder] != inmatdata2[c + r * matorder]
                
                je END_FOR2                     #jump si =
             
                mov $0,%eax                     #return 0
                jmp END                         
        

        END_FOR2:
                mov -8(%ebp),%ebx               #++c
                inc %ebx
                mov %ebx,-8(%ebp)
                
                jmp FOR2                        #Revenir en haut de la boucle for2

        END_FOR1:
                mov $1,%eax                     #valeure de retour à 1

                mov -4(%ebp),%ebx               #++r
                inc %ebx
                mov %ebx,-4(%ebp)
                
                jmp FOR1                        #Revenir en haut de la boucle for1

        END:
                leave          /* Restore ebp and esp */
                ret            /* Return to the caller */
