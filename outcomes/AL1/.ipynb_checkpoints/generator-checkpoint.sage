class Generator(BaseGenerator):
    def data(self):
        u=0; v=0; w=0; x=0; s=0;
        names = ['Abigail','Brian','Carlos','Desiree','Ethan','Federico','Grant','Hailey','Indira','Jillian','Kai','Lucas','Maria','Natasha','Owen','Piero','Quinn','Riley','Santiago','Tucker','Ursula','Vincent','Werner','Xaviera','Yadier','Zaya']
        pronouns = ['she','he','he','she','he','he','he','she','she','she','they','he','she','she','he','he','they','she','he','they','she','she','he','she','she','they']
        while( (u-s)*(w-s)*(v-s)*(x-s)==0 ):

            a = randrange(2,6)
            b = randrange(2,7)
            c = randrange(3,6)
            d = c + randrange(1,4)
            s = a + b*(c-d)*(c-d)
            st = str(a)+'+'+str(b)+'(\\, '+str(c)+'-'+str(d)+'\\,)^2'

            u = a + b*(c*c-d*d)
            v = a - b*(c-d)*(c-d)
            w = a + b*b*(c-d)*(c-d)
            x = (a+b)*(c-d)*(c-d)

        wrongs = [u,v,w,x]
        j = randrange(0,4)
        k=randrange(0,26)
        reasons = ['distributing the square across the subtraction on step 1','making a sign error when squaring the negative quantity','multiplying before squaring in violation of PEMDAS','adding before multiplying in violation of PEMDAS']
        badsteps = [str(a)+'+'+str(b)+'('+str(c)+'^2 -'+str(d)+'^2)',
                    str(a)+'-'+str(b)+'(\\, '+str(c)+'-'+str(d)+'\\,)^2',
                    str(a)+'+\\left['+str(b)+'(\\, '+str(c)+'-'+str(d)+'\\,)\\right]^2',
                    '('+str(a)+'+'+str(b)+')(\\, '+str(c)+'-'+str(d)+'\\,)^2'
                   ]

        return {
            "st": st,
            "incor": wrongs[j],
            "cor": s,
            "erred": reasons[j],
            "wrongstep": badsteps[j],
            "stu": names[k],
            "pn": pronouns[k]
        }
