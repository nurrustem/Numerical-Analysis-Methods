function simpson_double(f,a,b,c,d,m,n)
    h = (b-a)/n
    j_1 = 0 
    j_2 = 0
    j_3 = 0 

    for i=0:n
        x = a + i*h 
        hx = (d(x)-c(x))/m
        k_1 = f(x,c(x)) + f(x,d(x)) 
        k_2 = 0 
        k_3 = 0 

        for j=1:m-1
            y = c(x)+j*hx
            Q = f(x,y)
            if (j%2 == 0)
                k_2 = k_2 + Q
            else
                k_3 = k_3 + Q
            end
        end
        L = ((k_1 + 2*k_2 + 4*k_3)hx)/3
        if (i==0 || i==n)
            j_1 = j_1 + L
        elseif (i%2==0)
            j_2 = j_2 + L
        else
            j_3 = j_3 + L
        end
    end
    j = (h*(j_1 + 2*j_2 + 4*j_3))/3
    return j
end


f = (x, y) -> x^2 + y^2
c = x -> 0
d = x -> 1

display(simpson_double(f, 0, 1, c, d, 100, 100))