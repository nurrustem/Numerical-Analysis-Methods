function midpoint(f, a1, b1, c, d, n)
    Δx1 = (b1 - a1) / n
    integral = 0.0
    
    for i in 1:n
        x1 = a1 + (i - 0.5) * Δx1
        a2 = c(x1)
        b2 = d(x1)
        Δx2 = (b2 - a2) / n
        for j in 1:n
            x2 = a2 + (j - 0.5) * Δx2
            integral += f(x1, x2) * Δx1 * Δx2
        end
    end
    
    return integral
end

f = (x, y) -> x^2 + y^2
c = x -> 0
d = x -> 1

display(midpoint(f, 0, 1, c, d, 100))

