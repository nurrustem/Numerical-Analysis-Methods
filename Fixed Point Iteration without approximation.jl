function divided_diff(x,y)
    n = length(x)
    c = copy(y)
    for j=2:n
        for i=n:-1:j
            c[i] = (c[i]-c[i-1])/(x[i]-x[i-j+1])
        end
    end
    return c
end

function poly_interp(x,y,z)
    c = divided_diff(x,y)
    n = length(c)
    p = c[n]*ones(length(z))
    for j=n-1:-1:1
        p .= c[j] .+ (z.-x[j]).*p
    end
    return p
end

x = [0.0, 2.0, 4.0, 6.0, 8.0, 12.0]
y = [0.0, 4.0, 16.0, 36.0, 64.0, 120.0]
z = range(x[1], stop=x[end], length=100)

p = poly_interp(x,y,z)

scatter(x,y,label="Data Points")
plot!(z,p,label="Interpolating Polynomial")
title!("Polynomial Interpolation using Divided Differences")
xlabel!("x")
ylabel!("y")