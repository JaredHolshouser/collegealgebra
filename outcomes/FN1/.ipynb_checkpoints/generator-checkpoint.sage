class Generator(BaseGenerator):
    def data(self):
        names =['Abigail','Brian','Carlos','Desiree','Ethan','Federico','Grant','Hailey','Indira','Jillian','Kai','Lucas','Maria','Natasha','Owen','Piero','Quinn','Riley','Santiago','Tucker','Ursula','Vincent','Werner','Xaviera','Yasmin','Zaya']
        pronouns =['she','he','he','she','he','he','he','she','she','she','they','he','she','she','he','he','they','she','he','they','she','she','he','she','she','they']
        possessives = ['her','his','his','her','his','his','his','her','her','her','their','his','her','her','his','his','their','her','his','their','her','her','his','her','her','their']
        ii = randrange(0,26)
        suffix = 's'
        if(pronouns[ii] == 'they'):
            suffix = ''

        # Interps, 9 total
        meanings = ['outside temperature', 'balance in your checking account', 'previous day\'s change in the Dow Jones', 'net approval rating for the president of the United States', 'temperature of the water in your fish tank', 'your distance south of Boston', 'the Patriots\' margin of victory in their last game', 'the Red Sox\'s margin of victory in their last game', 'how much taller you are than your tallest parent']
        uni = ['degrees F', 'dollars', 'points', 'percentage points', 'degrees above 70', 'miles', 'points', 'runs', 'inches']

        while True:
            [i,j] = [randrange(0,9),randrange(0,9)]
            if( i!=j ):
                break

        vars = ['a','b', 'c', 'h', 'j', 'k', 'm', 'n', 'p', 'q', 'r', 's', 't', 'u', 'w', 'x', 'y', 'z']
        shuffle(vars)
        [x,y] = [var(vars[0]),var(vars[1])]
        
        
        i = choice([1,2])  #1: y^2 = x^3... and 2: x^2 = y^3...
        
        P = [randint(1,9)*choice([-1,1]),randint(1,9)*choice([-1,1])]
        Q = [P[0],-1*P[1]] if i==1 else [-1*P[0],P[1]]
        R = [P[0],P[1]]
        [A,B] = [-1,0]
        E = EllipticCurve([A,B])
        htang = choice([True,False])
        has_ht = (A < 0 and B > 0)
        while(E.discriminant()>=0):
            R = [randint(1,9)*choice([-1,1]),randint(1,9)*choice([-1,1])]
            if(abs(R[0])==abs(P[0]) or abs(R[1])==abs(P[1])):
                continue
            if (i==2): # Find elliptic curve in x^2=y^3+Ay+B form
                M = matrix(2,2,[P[1],1,R[1],1])
                b = vector([P[0]^2-P[1]^3,R[0]^2-R[1]^3])
                J = M.solve_right(b)
                A = J[0]
                B = J[1]
                E = EllipticCurve([A,B])
                delta = E.discriminant()
                equ = x^2 - y^3 - A*y - B
                has_ht = (A < 0 and B > 0)
            if (i==1):
                M = matrix(2,2,[P[0],1,R[0],1])
                b = vector([P[1]^2-P[0]^3,R[1]^2-R[0]^3])
                J = M.solve_right(b)
                A = J[0]
                B = J[1]
                E = EllipticCurve([A,B])
                delta = E.discriminant()
                equ = y^2 - x^3 - A*x - B
                has_ht = (A < 0 and B > 0)

        if (A < 0 and B > 0):  # Zoom out to see horizontal tangents
            zmx = sqrt(-1*A/3)
            zm = max(sqrt(zmx^3 + A*zmx + B), sqrt(-zmx^3 - A*zmx + B))
        else:
            zm = 0
            

        iv = {
            "var": x,
            "desc": meanings[i],
            "units": uni[i]
        }
        dv = {
            "var": y,
            "desc": meanings[j],
            "units": uni[j]
        }    


        return {
            "iv": iv,
            "dv": dv,
            "A": A,
            "zm": N(sqrt(zm^3+A*zm+B)),
            "Px": P[0],
            "Py": P[1],
            "Qx": Q[0],
            "Qy": Q[1],
            "Rx": R[0],
            "Ry": R[1],
            "stu": names[ii],
            "pn": pronouns[ii],
            "pos": possessives[ii],
            "suf": suffix,
            "graph_y_f_of_x": 'is not' if (i==1 or (A<0 and B>0)) else 'is',
            "graph_x_f_of_y": 'is not' if (i==2 or (A<0 and B>0)) else 'is',
            "equ": equ,
            "xmin": 1.5*max(5*zm/6,abs(P[0]),abs(P[1]),abs(Q[0]),abs(Q[1]),abs(R[0]),abs(R[1])),
            "x": x,
            "y": y,
            "data_y_f_of_x": 'is' if i==2 else 'is not',
            "data_x_f_of_y": 'is' if i==1 else 'is not'
            
        }
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "thegraph": point([(data['Px'],data['Py']),(data['Qx'],data['Qy']),(data['Rx'],data['Ry'])],size=48,color='black',xmin=-1*data['xmin'],xmax=data['xmin'],ymin=-1*data['xmin'],ymax=data['xmin'])+implicit_plot(data['equ']==0,(data['x'],-1*data['xmin'],data['xmin']),(data['y'],-1*data['xmin'],data['xmin']),xmin=-1*data['xmin'],xmax=data['xmin'],ymin=-1*data['xmin'],ymax=data['xmin'],axes_labels=[data['x'],data['y']])
            }