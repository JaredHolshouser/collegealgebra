class Generator(BaseGenerator):
    def data(self):

        # Variable name choices, 12 total
        vars = ['b', 'j', 'k', 'n', 's', 't', 'u', 'w', 'x', 'y', 'z']
        # Function name choices, 10 total
        funs = ['A', 'C', 'f', 'g', 'h', 'L', 'M', 'P', 'Q', 'R', 'V']

        while True:
            i = randrange(0,11)
            j = randrange(0,11)
            k = randrange(0,10)
            m = randrange(0,9) # dv interp
            n = randrange(0,9) # iv interp

            if( j > i and m != n ):
                break



        # Interps, 9 total
        meanings = ['outside temperature', 'balance in your checking account', 'previous day\'s change in the Dow Jones', 'net approval rating for the president of the United States', 'temperature of the water in your fish tank', 'your distance south of Boston', 'the Patriots\' margin of victory in their last game', 'the Red Sox\'s margin of victory in their last game', 'how much taller you are than your tallest parent']
        uni = ['degrees F', 'dollars', 'points', 'percentage points', 'degrees above 70', 'miles', 'points', 'runs', 'inches']

        # Prompt options lol

        prompts = [
            'Desperate to come up with a mathematical model to understand the '+meanings[m]+', you use a supercomputer to analyze millions of data points and discover it can be predicted by a single quantity:',
            'You find a dubious internet site that claims the following formula can predict the '+meanings[m]+' in terms of a single quantity:',
            'An algebraic formula comes to you in a dream one night, and you write it down the instant you wake up. Wondering what it means, you show your professor of ancient religious studies. "Ah!" she exclaims. "I\'ve seen this formula before. It\'s said that it can predict the '+meanings[m]+', but I thought it was an old legend."',
            'Walking to Dunkin\' Donuts one day, you come across a torn sheet of paper on the sidewalk that appears to have an algebraic formula on it. It also looks like someone has written next to the formula the meanings of its variables:'
        ]    

        # Select some parameter values
        while True:
            a = randrange(2,8)*choice([-1,1])
            b = randrange(2,8)
            c = randrange(1,8)*choice([-1,1])
            if( abs(a)!=abs(b) and a!=c and b!=c ):
                break
        X = var(vars[i])
        fac1 = X - b
        fac2 = X + a
        fac3 = X + 1
        fac4 = X - c
        fac5 = X + c
        sgnc = ''
        if(c > 0):
            sgnc = '+'
        if(c < 0):
            sgnc = '-'

        # Select an expression
        exprs = [
            a*fac1^2 + c,
            -b*X^2 + X*fac2,
            a - b*fac5^2
        ]
        exprtext = [
            str(a)+"("+str(fac1)+")^2 "+sgnc+str(abs(c)),
            "-"+str(b)+str(vars[i])+"^2 + "+str(vars[i])+"("+str(fac2)+")",
            str(a)+" - "+str(b)+"("+str(fac5)+")^2"
        ]
        l = randrange(0,3)

        # Choose random iv, dv values
        while True:
            iv0 = randrange(2,10)*choice([-1,1])
            iv1 = randrange(2,10)*choice([-1,1])
            iv2 = randrange(2,10)*choice([-1,1])
            if( iv1 < b and iv0 != c and iv1 != c and iv2 != c and iv0 != iv1 and iv1 != iv2 and iv0 != iv2):
                dv0 = exprs[l].subs({X: iv0})
                dv1 = exprs[l].subs({X: iv1})
                dv2 = exprs[l].subs({X: iv2})
                if( dv0 == iv0 or dv1 == iv1 or dv2==iv2 ):
                    continue
                break

        return {
            "prompt": prompts[randrange(0,4)],
            "dv": vars[k],
            "dvd": meanings[m],
            "dvu": uni[m],
            "iv": vars[i],
            "ivd": meanings[n],
            "ivu": uni[n],
            "f": funs[k],
            "dv0": dv0,
            "iv0": iv0,
            "iv1": iv1,
            "iv2": iv2,
            "dv1": dv1,
            "dv2": dv2,
            "expr": exprtext[l]

        }