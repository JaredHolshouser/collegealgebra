class Generator(BaseGenerator):
    def data(self):

        while True:
            X = [randrange(-9,9),randrange(-9,9)  ,randrange(-9,9)  ,randrange(-9,9) ]
            Y = [randrange(-9,9),randrange(-9,9)  ,randrange(-9,9)  ,randrange(-9,9) ]
            if( (abs(X[1]-X[2])>1) and (Y[1] != Y[2]) ):
                break
        while True:
            m0 = QQ(randrange(-9,9)/randrange(1,9))
            m2 = QQ(randrange(-9,9)/randrange(1,9))
            if( m0 != 0 and m2 != 0 and (m0.denominator()>=2 ^^ m2.denominator()>=2)):
                break

        lhs0 = ''
        rhs0 = ''
        lhs1 = ''
        rhs1 = ''
        lhs2 = ''
        rhs2 = ''

        var('x y m b A B C x_0 y_0')
        forms = ['slope-intercept form', 'point-slope form', 'standard form']
        eql = [y, y-y_0, A*x+B*y]
        eqr = [m*x+b, m*(x-x_0), C]    
        guid = ['','without simplifying','where A,B,C are all integers']

        i = [0,1,2]
        j = [0,1,2]
        shuffle(i)

        [x0,x1,x2,x3] = X
        [y0,y1,y2,y3] = Y

        # Build all three solutions for each line
        [p0,q0] = [m0.numerator(), m0.denominator()]
        lhs0 = [y, y-y0, -p0*x+q0*y]
        rhs0 = [m0*x+y0-x0*m0, str(m0)+'('+str(x-x0)+')', q0*y0-p0*x0]

        m1 = QQ((y2-y1)/(x2-x1))
        [p1,q1] = [m1.numerator(), m1.denominator()]
        lhs1 = [y,y-y1,-p1*x+q1*y]
        rhs1 = [m1*x+y1-x1*m1, str(m1)+'('+str(x-x1)+')', q1*y1-p1*x1]
        lhs1a = y-y2
        rhs1a = str(m1)+'('+str(x-x2)+')'
        alt=''
        if(i[1]==1):
            alt = 'Alternatively, we may also have '+str(lhs1a)+' = '+str(rhs1a)+'.'

        [p2,q2] = [m2.numerator(), m2.denominator()]
        lhs2 = [y, y, -p2*x+q2*y]
        rhs2 = [m2*x-x3*m2, str(m2)+'('+str(x-x3)+')', -p2*x3]


        return {
            "x0": X[0],
            "y0": Y[0],
            "x1": X[1],
            "y1": Y[1],
            "x2": X[2],
            "y2": Y[2],
            "x3": X[3],
            "m0": m0,
            "m2": m2,
            "form0": forms[i[0]],
            "form1": forms[i[1]],
            "form2": forms[i[2]],
            "lhs0": lhs0[i[0]],
            "rhs0": rhs0[i[0]],
            "lhs1": lhs1[i[1]],
            "rhs1": rhs1[i[1]],
            "lhs2": lhs2[i[2]],
            "rhs2": rhs2[i[2]],
            "eql0": eql[i[0]],
            "eqr0": eqr[i[0]],
            "eql1": eql[i[1]],
            "eqr1": eqr[i[1]],
            "eql2": eql[i[2]],
            "eqr2": eqr[i[2]],
            "guid0": guid[i[0]],
            "guid1": guid[i[1]],
            "guid2": guid[i[2]],
            "alt": alt
        }