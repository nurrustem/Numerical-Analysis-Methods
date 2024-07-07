using LinearAlgebra
using Plots

function periodic_spline(x::Vector{Float64}, y::Vector{Float64})
    n = length(x)
    if n < 4
        error("Input vectors must have at least 4 elements")
    end
    if x[1] != x[end]
        error("Input vectors must have the same first and last elements")
    end
    h = x[2:end] .- x[1:end-1]
    alpha = 3*(y[2:end] .- y[1:end-1])./h - 3*(y[1] .- y[n])/h[n]
    l = zeros(n)
    mu = zeros(n)
    z = zeros(n)
    l[2] = 2*(x[3] - x[1])
    mu[2] = h[2]
    z[2] = alpha[1] / l[2]
    for i in 3:n-1
        l[i] = 2*(x[i+1] - x[i-1]) - h[i-1]*mu[i-1]
        mu[i] = h[i] / l[i]
        z[i] = (alpha[i-1] - h[i-1]*z[i-1])/l[i]
    end
    l[n] = h[n-1]*(2 - mu[n-1])
    z[n] = (alpha[n-1] - h[n-1]*z[n-1])/l[n]
    c = zeros(n)
    b = zeros(n-1)
    d = zeros(n-1)
    h = x[2:end] .- x[1:end-1]
    for i in 1:n-1
        c[i] = y[i]
        b[i] = (y[i+1] - y[i])/h[i] - h[i]*(z[i+1] + 2*z[i])/3
        d[i] = (z[i+1] - z[i])/(3*h[i])
    end
    c[n] = y[n]
    return (c=c, b=b, d=d)
end


x = [0, 1, 2, 3, 4, 5]
y = [1, 3, 2, 1, 2, 0]

knots = collect(range(minimum(x), maximum(x), length=length(x)+1))

# convert x and y to Float64 type
x_float = convert(Vector{Float64}, x)
y_float = convert(Vector{Float64}, y)

c, b, d = periodic_spline(x_float, y_float)

println("Coefficients of the cubic spline:")
println("c = ", c)
println("b = ", b)
println("d = ", d)

using Plots
scatter(x, y, label="Data points")
plot!(c, knots, label="Periodic Spline")
