class Generator(BaseGenerator):
    def data(self):
        import re
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
        X = var('x')
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

        vertices = [
            b,
            a/2/(b-1),
            -c
        ]
        exprtext = [
            str(a)+"("+str(fac1)+")^2 "+sgnc+str(abs(c)),
            "-"+str(b)+str('x')+"^2 + "+str('x')+"("+str(fac2)+")",
            str(a)+" - "+str(b)+"("+str(fac5)+")^2"
        ]
        l = randrange(0,3)

        # Pick the AROC points, one on either side of vertex
        while True:
            [x1,x2] = [Integer(round(vertices[l])) - randrange(1,5), Integer(round(vertices[l])) + randrange(1,5)]
            P = [x1, exprs[l].subs({X:x1})]
            Q = [x2, exprs[l].subs({X:x2})]

            aroc = QQ( (P[1]-Q[1])/(P[0]-Q[0]) )
            if( abs(aroc) != abs(a) and abs(aroc) != abs(b) and aroc != 0 ):  #Don't want zero AROC
                break



        if( aroc > 0 ):
            change = 'increases'
        else:
            change = 'decreases'

        ex = re.sub(r'\s+', '', exprtext[l])
        ex = re.sub(r'\^', '**', ex)
        ex = re.sub(r'\+', '--', ex) # GGB query strings don't like plus signs, lol

        xmin = -max(abs(x1),abs(x2)) - 3
        xmax = -xmin

        ymin = -max(abs(P[1]), abs(Q[1])) - randrange(3,6)
        ymax = -ymin

        # This doesn't seem to work on command line...
        # "exprtext": ex+';ZoomIn('+str(xmin)+','+str(ymin)+','+str(xmax)+','+str(ymax)+');',

        return {
            "expr": exprtext[l],
            "exprtext": ex+';',
            "Px": P[0],
            "Py": P[1],
            "Qx": Q[0],
            "Qy": Q[1],
            "aroc": aroc,
            "aaroc": abs(aroc),
            "ivd": meanings[n],
            "ivu": uni[n],
            "dvd": meanings[m],
            "dvu": uni[m],
            "dvdelta": change,
            "expres": exprs[l],
            "xmin": max(abs(r) for r in [xmin,xmax]),
            "P": P,
            "Q": Q,
            "sline": aroc*(x-P[0]) + P[1],
            "sign": "positive" if aroc > 0 else ("negative" if aroc < 0 else "zero"),
            "direction": "increasing" if aroc > 0 else ("decreasing" if aroc < 0 else "horizontal")
        }
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "graph": plot(data['expres'],x,-1*data['xmin'],data['xmin'],axes_labels=["x","y"]),
            "answer": plot(data['expres'],x,-1*data['xmin'],data['xmin'],axes_labels=["x","y"])+point([data['P'],data['Q']],color='black',size=48)+plot(data['sline'],x,-1*data['xmin'],data['xmin'],color='orange')
            }
    