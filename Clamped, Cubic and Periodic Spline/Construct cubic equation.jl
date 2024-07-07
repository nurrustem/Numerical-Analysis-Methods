function construct_equation(x, x_vals, a, b, c, d)
    n = length(x_vals)
    for i in 1:n-1
        if x >= x_vals[i] && x <= x_vals[i+1]
            return a[i] + b[i] * (x - x_vals[i]) + c[i] * (x - x_vals[i])^2 + d[i] * (x - x_vals[i])^3
        end
    end
end