.data
        factor: .float 2.0 /* use this to multiply by two */

.text

.globl _ZNK9CTriangle7AreaAsmEv

_ZNK9CTriangle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        # A 8(%ebp) on a l'adresse du triangle 
        mov 8(%ebp), %eax
        # A (%eax) on a la vTable, a 4(%eax) on a le tableau de float avec les cotes du triangle mSides[3]
        mov (%eax), %ebx
        
        push %eax #On met this sur la pile pour pouvoir utiliser CTriangle::PerimeterAsm 
        # On va chercher la methode CTriangle::PerimeterAsm qui est a 12 (%ebx)
        call *12(%ebx) #Le perimetre du triangle est maintenant dans st[0]
        add $4, %esp # On recupere l'espace alloue sur la pile
        
        #On a maintenant le perimetre dans st[0]
        
        fld factor
        fdivrp
        
        sub $16, %esp # On cree l'espace sur la pile pour la variable p (perimetre), ainsi que pour les autres variables tampon p-mSides[0] , p-mSides[1] , p-mSides[2]
        fstp -4(%ebp) # On place la variable p = perimetre/2 dans -4(%ebp)
        
        # sqrt(p*(p-mSides[0])*(p-mSides[1])*(p-mSides[2]))
        
        fld -4(%ebp) # p dans st[0]
        fld 4(%eax) #On place le premier cote dans st[0]
        fsubrp
        fstp -8(%ebp) # p-mSides[0]
        
        fld -4(%ebp) # p dans st[0]
        fld 8(%eax) #On place le deuxieme cote dans st[0]
        fsubrp
        fstp -12(%ebp) #p-mSides[1]
        
        fld -4(%ebp) # p dans st[0]
        fld 12(%eax) #On place le troisieme cote dans st[0]
        fsubrp
        fstp -16(%ebp) #p-mSides[2]
        
        fld -4(%ebp) #p dans st[0]
        fld -8(%ebp) #p-mSides[0] dans st[0]
        fmulp
        fld -12(%ebp) # p - mSides[1] dans st[0]
        fmulp
        fld -16(%ebp) # p - mSides[2] dans st[0]
        fmulp
        # On a a ce point-ci dans st[0] et st[1] p*(p-mSides[0])*(p-mSides[1])*(p-mSides[2])
        # On peut desallouer l'espace memoire
        add $16, %esp
       
        fsqrt
        
        #Methode terminee, on a maintenant dans st[0] p*(p-mSides[0])*(p-mSides[1])*(p-mSides[2])
        
        
        
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
