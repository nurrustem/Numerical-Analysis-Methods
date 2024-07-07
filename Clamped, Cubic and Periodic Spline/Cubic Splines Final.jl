include("Construct cubic equation.jl");
include("Find y value.jl");

using Plots

function cubic_spline(x, y)
    n = length(x)
    A = zeros(n-2, n-2)
    h = [x[i+1] - x[i] for i in 1:n-1]
    b = 6*[((y[i+2] - y[i+1])/h[i+1]) - ((y[i+1] - y[i])/h[i]) for i in 1:1:n-2]
    b[1] = b[1] - h[1]*2
    b[end] = b[end] - h[n-1]*2 

    for i in 2:n-3
        A[i, i-1] = h[i]
        A[i, i] = 2 * (h[i] + h[i+1])
        A[i, i+1] = h[i+1]
    end

    A[1, 1] = 2 * (h[1] + h[2])
    A[1, 2] = h[2]
    A[n-2, n-3] = h[n-2]
    A[n-2, n-2] = 2 * (h[n-2] + h[n-1])

    z = inv(A) * b
    z = [2;z;2]

    a = y[1:end-1]
    b = [(y[i+1]-y[i])/(x[i+1] - x[i]) - (x[i+1] - x[i])*(2*z[i] + z[i+1])/6 for i in 1:length(z)- 1]
    c = z[1:end-1] / 2
    d = [(z[i+1] - z[i]) / (6*(x[i+1] - x[i])) for i in 1:length(z)-1]

    # Print coefficients
    println("Coefficients:")
    for i in 1:length(x)-1
        println([a[i], b[i], c[i], d[i]])
    end

    plot_range = collect(range(x[1], stop=x[end], length=1000))
    plot_values = [construct_equation(x_val, x, a, b, c, d) for x_val in plot_range]

    plot(x, y, st=:scatter, label="Data Points", title="Cubic Spline Interpolation")
    plot!(plot_range, plot_values, label="Interpolated Spline")

    return a, b, c, d
end

# Input data points
x = [1.0, 3.0, 4.0, 4.5, 5.0]
y = [1.0, 9.0, 16.0, 20.0, 25.0]

# Calculate and plot the cubic spline interpolation
a, b, c, d = cubic_spline(x, y)

# Find a y-value for a specific x-value and plot it
x_value = 3.2
find_y_value(x_value, x, a, b, c, d)

