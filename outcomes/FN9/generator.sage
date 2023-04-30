class Generator(BaseGenerator):
    def data(self):
        from sage.matrix.constructor import random_unimodular_matrix
        slz = sage.matrix.matrix_space.MatrixSpace(ZZ,2)
        names =['Abigail','Brian','Carlos','Desiree','Ethan','Federico','Grant','Hailey','Indira','Jillian','Kai','Lucas','Maria','Natasha','Owen','Piero','Quinn','Riley','Santiago','Tucker','Ursula','Vincent','Werner','Xaviera','Yasmin','Zaya']
        pronouns =['she','he','he','she','he','he','he','she','she','she','they','he','she','she','he','he','they','she','he','they','she','she','he','she','she','they']
        possessives = ['her','his','his','her','his','his','his','her','her','her','their','his','her','her','his','his','their','her','his','their','her','her','his','her','her','their']
        i = randrange(0,26)
        suffix = 's'
        if(pronouns[i] == 'they'):
            suffix = ''
        vars = ['t', 'u', 'w', 'x', 'y', 'z']
        k = randrange(0,6)


        # Verify inverse of Mobius transform, find inverse of something 
        # General Mobius transformation is too much work... use [1,0,k,1] or [-1,0,k,-1] only.
    #    while True:
    #        A = random_unimodular_matrix(slz, upper_bound=12)
    #        if( A[1,0] != 0 ): # Want an x in denominator, too easy otherwise!
    #            break

        while True:
            [p,q,r] = [randrange(1,5), randrange(2,5), randrange(1,5)*choice([-1,1])]
            if( abs(p) != abs(r) ):
                if(q > 2):
                    noo = str(p)+'-\\sqrt['+str(q)+']{'+str(x + r)+'}'
                else:
                    noo = str(p)+'-\\sqrt{'+str(x + r)+'}'
                break

        j = choice([1,-1])
        A = matrix(ZZ,2,2,[j,0,randrange(2,9)*choice([-1,1]),j])

        fexpr(x) = ( A[0,0]*x + A[0,1] )/( A[1,0]*x + A[1,1] )

        if(choice([True,False])): # Correct answer or incorrect?
            Ai = A.inverse()
            cor = "correct"
            ffexpr = noo
            sr = '+'
            if(r > 0): # Subtracting r in inverse
                sr = '-'
            ffi = '('+str(p)+'-x)^'+str(q)+sr+str(abs(r))
        else:
            Ai = A.inverse()*matrix(ZZ,2,2,[0,1,1,0])
            cor = "incorrect"
            ffexpr = fexpr(x) # They'll have to solve the original
            ffi = ( Ai[0,1]*x + Ai[0,0] )/( Ai[1,1]*x + Ai[1,0] ) # Corrected inverse of original - columnswapped

        fi(x) = ( Ai[0,0]*x + Ai[0,1] )/( Ai[1,0]*x + Ai[1,1] )


        return {
            "stu": names[i],
            "pn": pronouns[i],
            "pos": possessives[i],
            "suf": suffix,
            "A": A,
            "Ai": Ai,
            "f": fexpr(x), # Stu's original function
            "fi": fi(x), # Stu's purported inverse
            "ff": noo, # Your next problem to do out, if original was correct
            "fog": fexpr(fi(x)).simplify_full(),
            "gof": fi(fexpr(x)).simplify_full(),
            "cor": cor,
            "guidance": "The",
            "ffexpr": ffexpr,
            "ffi": ffi
        }