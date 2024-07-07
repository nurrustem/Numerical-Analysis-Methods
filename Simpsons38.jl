function simpson3_8_double(f, a, b, c, d, m, n)
    if m % 3 != 0 || n % 3 != 0  # Check if m and n are divisible by 3
        println("m and n must be divisible by 3 for Simpson's 3/8 rule.")
        return nothing
    end
    
    h1 = (b - a) / n
    total = 0.0

    for i = 0:n
        x = a + i * h1
        h2 = (d(x) - c(x)) / m
        integral = 0.0

        for j = 0:m
            y = c(x) + j * h2
            
            multiplier = 2.0
            if j == 0 || j == m
                multiplier = 1.0
            elseif j % 3 != 0
                multiplier = 3.0
            end
            
            integral += multiplier * f(x, y)
        end

        integral *= 3 * h2 / 8.0

        if i == 0 || i == n
            total += integral
        elseif i % 3 == 0
            total += 2 * integral
        else
            total += 3 * integral
        end
    end

    total *= 3 * h1 / 8.0
    return total
end

p = (x, y) -> x^2 + y^2
c = x -> 0
d = x -> 1

println(simpson3_8_double(p, 0, 1, c, d, 200, 200))
