function bisection_method(f, a, b, tol, maxiter)
    c = (a + b)/2
    for i in 1:maxiter
        if f(c) == 0 || (b - a)/2 < tol
            return c
        end
        if sign(f(c)) == sign(f(a))
            a = c
        else
            b = c
        end
        c = (a + b)/2
    end
    return c
end