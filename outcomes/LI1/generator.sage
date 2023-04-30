class Generator(BaseGenerator):
    def data(self):
        meanings = ['outside temperature', 'balance in your checking account', 'previous day\'s change in the Dow Jones', 'net approval rating for the president of the United States', 'temperature of the water in your fish tank', 'your distance south of Boston', 'the Patriots\' margin of victory in their last game', 'the Red Sox\'s margin of victory in their last game', 'how much taller you are than your tallest parent']
        uni = ['degrees F', 'dollars', 'points', 'percentage points', 'degrees above 70', 'miles', 'points', 'runs', 'inches']
        while True:
            [i,j] = [randrange(0,9),randrange(0,9)]
            if( i!=j ):
                break



        while True:
            m = QQ( randrange(3,10)*choice([-1,1])/randrange(2,5) )
            if(m.denominator() >= 2):
                break
        gaps = [1,2,3,4,5]
        shuffle(gaps)
        while True:
            xmin = randrange(-12,-5)
            if(Mod(xmin,m.denominator())==0):
                break
        ymin = randrange(2,12)*choice([-1,1])
        xdata = [{'x': xmin}]
        ydata = [{'y': ymin}]
        xx = xmin
        yy = ymin    
        for a in range(0,4):
            xx += gaps[a]*m.denominator()
            xdata.append({'x': xx})    
            yy += gaps[a]*m.numerator()
            ydata.append({'y': yy})    

        p = randrange(0,4)
        if( p<4 and gaps[p+1]==1 ):
            ydata[p]['y'] -= m.numerator()
        else:
            ydata[p]['y'] += m.numerator()

        while True:  # Select two of the "real" data points to find the model equation
            [ii,jj] = [randrange(0,4),randrange(0,4)]
            if(ii!=p and jj!=p):
                [x1,y1,x2,y2] = [xdata[ii]['x'], ydata[ii]['y'],xdata[jj]['x'],ydata[jj]['y']]
                break
        b = y1 - m*x1

        var('x y')


        return {
            "x": 'x', # IV
            "y": 'y', # DV
            "xinterp": meanings[i], # IVD
            "yinterp": meanings[j], # DVD
            "xuni": uni[i],
            "yuni": uni[j],
            "xdata": xdata, # xdata
            "ydata": ydata,
            "p": p,
            "px": xdata[p]['x'],
            "py": ydata[p]['y'],
            "rhs": m*x + b,
            "mnum": m.numerator(),
            "mden": m.denominator(),
            "b": b,
            "m": m
        }