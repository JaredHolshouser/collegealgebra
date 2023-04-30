class Generator(BaseGenerator):
    def data(self):
        a,b,c,d,h,j,k,L,n,p,q,r,s,t,u,v,w,x,y,z = var("a b c d h j k L n p q r s t u v w x y z")

        # Variable name choices, 20 total
        vars = [a, b, c, d, h, j, k, L, n, p, q, r, s, t, u, v, w, x, y, z]

        # Interps, 9 total
        meanings = ['outside temperature', 'balance in your checking account', 'previous day\'s change in the Dow Jones', 'net approval rating for the president of the United States', 'temperature of the water in your fish tank', 'your distance south of Boston', 'the Patriots\' margin of victory in their last game', 'the Red Sox\'s margin of victory in their last game', 'how much taller you are than your tallest parent']
        uni = ['degrees F', 'dollars', 'points', 'percentage points', 'degrees above 70', 'miles', 'points', 'runs', 'inches']

        # Pick variable names
        i0=0; i1=0; i2=0; i3=0; 
        while( (i0-i1)*(i0-i2)*(i0-i3)*(i1-i2)*(i1-i3)*(i2-i3) == 0):
            i0=randrange(0,20)
            i1=randrange(0,20)
            i2=randrange(0,20)
            i3=randrange(0,20)

        dv = vars[i0]; iv1=vars[i1]; iv2=vars[i2]; iv3=vars[i3]; 

        # Pick interpretations
        j0=0; j1=0; j2=0; j3=0;
        while( (j0-j1)*(j0-j2)*(j0-j3)*(j1-j2)*(j1-j3)*(j2-j3)==0 ):
            j0=randrange(0,9)
            j1=randrange(0,9)
            j2=randrange(0,9)
            j3=randrange(0,9)

        # Pick single-digit values for ivs
        v1 = randrange(1,6)*choice([-1,1])
        v2 = -1*randrange(2,8)
        v3 = randrange(2,5)


        ivh1 = {
            'iv': iv1,
            'desc': meanings[j1],
            'units': uni[j1],
            'val': v1
        }
        ivh2 = {
            'iv': iv2,
            'desc': meanings[j2],
            'units': uni[j2],
            'val': v2
        }
        ivh3 = {
            'iv': iv3,
            'desc': meanings[j3],
            'units': uni[j3],
            'val': v3
        }

        # Pick from among 3 formulas
        forms = [
            '2'+str(iv1)+' - \\frac12'+str(iv2)+'^2'+str(iv3),
            '('+str(iv1)+' - 2'+str(iv2)+')^2 + \\frac{7}{'+str(iv3)+'}',
            '\\frac{2'+str(iv1)+str(iv2)+'}{'+str(iv1)+'-'+str(iv2)+'+2'+str(iv3)+'}'
        ]

        exprs = [
            2*x - y^2/2 *z,
            (x -2*y)^2 + 7/z,
            (2*x*y)/(x-y+2*z)
        ]

        zz = randrange(0,3)
        f = exprs[zz]

        # Prompt options lol

        prompts = [
            'Desperate to come up with a mathematical model to understand the '+meanings[j0]+', you use a supercomputer to analyze millions of data points and discover there is a perfect formula to explain it:',
            'You find a dubious internet site that claims the following formula can predict the '+meanings[j0]+' in terms of the other quantities shown below:',
            'An algebraic formula comes to you in a dream one night, and you write it down the instant you wake up. Wondering what it means, you show your professor of ancient religious studies.</br></br> "Ah!" she exclaims. "I\'ve seen this formula before. It\'s said that it can predict the '+meanings[j0]+', but I thought it was an old legend."',
            'Walking to Dunkin\' Donuts one day, you come across a torn sheet of paper on the sidewalk that appears to have an algebraic formula on it. It also looks like someone has written next to the formula the meanings of its variables:'
        ]


        return {
            "dv": dv,
            "dvm": meanings[j0],
            "dvu": uni[j0],
            "ivs": [ivh1, ivh2, ivh3],
            "expr": forms[zz],
            "exprval": f.subs({x:v1, y:v2, z:v3}),
            "prompt": prompts[randrange(0,4)]
        }
