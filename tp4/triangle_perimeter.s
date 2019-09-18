.globl _ZNK9CTriangle12PerimeterAsmEv

_ZNK9CTriangle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        # A 8(%ebp) on a l'adresse du triangle 
        mov 8(%ebp), %eax
        # A (%eax) on a la vTable, a 4(%eax) on a le tableau de float avec les cotes du triangle mSides[3]
        fld 4(%eax) # On met le premier cote dans st[0]
        fld 8(%eax) # On met le deuxieme cote dans st [0] 2ieme est dans st [1]
        faddp # On additionne les deux premiers cotes
        fld 12(%eax) # On met le troisieme cote dans st [0] 2 + 1 est dans st [1]
        faddp
        
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
