class Generator(BaseGenerator):
    def data(self):
        import re
        ps = ['RetroHoods', 'Hip Hoops', 'Tiki Nails', 'Penny Socks', 'GemJeans', 'Brotherly Gloves', 'ImagineHat!', 'SuperstArmor']
        cs = ['Gucci Goose', 'La Moda Fina, LLC', 'Trend Empire', 'LUVLOGIQ', 'Hutt and Hoof, Inc.', 'All Access Associates', 'ShoppeCulture', 'Styleocalypse', 'Glow West']
        ss = ['21st-century sweatshirts with 19th-century style',
              'the world\'s first snag-proof hoop earrings',
              'acrylic nail covers with a Polynesian flair',
              'fashionable socks infused with a copper weave',
              'sapphire denim that\'s diamond strong',
              'the world\'s first four-way reversible gloves',
              'the first wool hat with fine copper weave that stimulates brain activity',
              'athletic base layers proven to improve muscle tone after only one week'
             ]

        i = randrange(0,8) # Which product/slogan
        j = randrange(0,9) # Which company
        var('x')
        # Pick a quadratic model with negative A,C, two positive roots in (1,9), and maximum value less than 10.
        faker = [randrange(1,4), randrange(5,8)]
        fakea = randrange(8,33)/(faker[0]-faker[1])^2 # LC to ensure max is between 2 and 8    
        fakep(x) = -1*fakea*(x-faker[0])*(x-faker[1])

        # Pick {5..7} data points in [0,10]^2 that are fuzzed perturbations of this model

        xdata = list(range(1,9))
        l = randrange(2,4) # How many data points to remove
        for k in range(0,l):
            xdata.remove(xdata[randrange(0,len(xdata))])

        data = []
        datalist = []
        ggb = ''
        for t in xdata:
            ty = round(fakep(t) + 0.6*normalvariate(0,1),2)
            data.append({
                    'x': t,
                    'y': ty
                })
            datalist.append([t,ty])
            ggb += "("+str(t)+","+str(ty)+");"

        var('A B C')
        model(x) = A*x*x + B*x + C
        fit = find_fit(datalist, model)
        [a,b,c] = [round(coef,2) for coef in [fit[0].rhs(), fit[1].rhs(), fit[2].rhs()]]
        p(x) = a*x^2 + b*x + c
        ptext = re.sub(r'\^',r'**',re.sub(r'\+','--',re.sub(r'\s','',str(p(x)))))
        ggb += "P(x)="+ptext+";"

        [r1,r2] = [round(u,2) for u in sorted([(-b + sqrt(b*b-4*a*c))/2/a, (-b - sqrt(b*b-4*a*c))/2/a])]

        return {
            "product": ps[i],
            "slogan": ss[i],
            "company": cs[j],
            "data": data,
            "n": len(xdata),
            "ggb": ggb,
            "pfunc": p(x),
            "absc": abs(c),
            "r1": r1,
            "r2": r2,
            "vx": round(-b/2/a,2),
            "vy": round(p(-b/2/a),2),
            "xdata": xdata,
            "FIT": [a,b,c],
            "xmin": 1.25*max(abs(k['x']) for k in data),
            "ymin": min(k['y'] for k in data)-5,
            "ymax": 1.25*max(k['y'] for k in data),
            "ptplot": [(k['x'],k['y']) for k in data]
        }
    
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "parabola": plot(data['pfunc'], (x,0,data['xmin']),axes_labels=[r"price per unit $x$, in \$",r"net profit $y$, in \$ thousands"],ymin=data['ymin'],ymax=data['ymax'])+point(data['ptplot'], size=48, color='black') 
            }
    