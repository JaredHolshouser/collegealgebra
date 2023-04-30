class Generator(BaseGenerator):
    def data(self):
        ix = randrange(1,3)-1
        b = randrange(2,5)^2
        e = randrange(3,8)*choice([-1,1])/2
        p = b^e
        ee = e
        while(ee==e):
            ee = randrange(2,4)
        bb = sqrt(b)
        pp = b^(ee/2)
        types = ['exponential', 'radical', 'logarithmic']
        [eform,rform,lform] = [
            r"\square^\square = \square",
            r"\sqrt[\square]{ \square } = \square",
            r"\log_{\square} \square = \square"
        ]
        if(ix==0):
            preql = str(b)+'^{'+str(e)+'}'
            preqr = p
            pr = 'exponential'
            qr1 = 'radical'
            qr2 = 'logarithmic'
            f1 = rform
            f2 = lform
        if(ix==1):
            preql = '\\sqrt['+str(e)+']{'+str(p)+'}'
            preqr = b
            pr = 'radical'
            qr1 = 'exponential'
            qr2 = 'logarithmic'
            f1 = eform
            f2 = lform
        if(ix==2):
            preql = '\\log_{'+str(b)+'}\\, '+str(p)
            preqr = e
            pr = 'logarithmic'
            qr1 = 'exponential'
            qr2 = 'radical'
            f1 = eform
            f2 = rform
        a1 = str(b)+'^{'+str(e)+'} = '+str(p)
        a2 = '\\sqrt['+str(e)+']{'+str(p)+'} = '+str(b)
        a3 = '\\log_{'+str(b)+'}\\, \\bigl('+str(p)+'\\bigr) = '+str(e)
        a4 = ee

        while True:
            y = randrange(2,8) #base
            z = 1+randrange(2,4)*choice([-1,1]) #exponent
            x = QQ(y^z) #power
            if( y != z and (y!=2 and z!=4) and (y!=4 and z!=2)):
                break

        fin = [x,y,z]
        shuffle(fin)


        
        return {
            "preql": preql,
            "preqr": preqr,
            "pr": pr,
            "qr1": qr1,
            "qr2": qr2,
            "b": b,
            "bb": bb,
            "p": pp,
            "a1": a1,
            "a2": a2,
            "a3": a3,
            "a4": a4,
            "x": x,
            "y": y,
            "z": z,
            "xd": fin[0],
            "yd": fin[1],
            "zd": fin[2],
            "form1": f1,
            "form2": f2
        }