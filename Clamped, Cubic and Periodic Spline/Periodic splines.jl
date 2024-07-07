include("Construct cubic equation.jl");
include("Find y value.jl");

using Plots

function periodic_spline(x, y)
    n = length(x)
    A = zeros(n-1, n-1)
    h = [x[i+1] - x[i] for i in 1:n-1]

    b = 6*[((y[i+2] - y[i+1])/h[i+1]) - ((y[i+1] - y[i])/h[i]) for i in 1:1:n-2]
    b = [b; 6*((y[2] - y[1])/h[1]) - ((y[n] - y[n-1])/h[n-1])]

    for i in 1:n-1
        A[i, i] = 2 * (h[i] + (i < n-1 ? h[i+1] : h[1]))
        if i < n-1
            A[i, i+1] = h[i+1]
            A[i+1, i] = h[i+1]
        end
    end
    A[1, n-1] = h[1]
    A[n-1, 1] = h[1]

    z = inv(A) * b
    z = [z; z[1]]

    a = y[1:end-1]
    b = [(y[i+1]-y[i])/(x[i+1] - x[i]) - (x[i+1] - x[i])*(2*z[i] + z[i+1])/6 for i in 1:length(z)- 1]
    c = z[1:end-1] / 2
    d = [(z[i+1] - z[i]) / (6*(x[i+1] - x[i])) for i in 1:length(z)-1]

    # Print coefficients
    println("Coefficients a: ", a)
    println("Coefficients b: ", b)
    println("Coefficients c: ", c)
    println("Coefficients d: ", d)

    plot_range = collect(range(x[1], stop=x[end], length=1000))
    plot_values = [construct_equation(x_val, x, a, b, c, d) for x_val in plot_range]

    plot(x, y, st=:scatter, label="Data Points", title="Periodic Spline Interpolation")
    plot!(plot_range, plot_values, label="Interpolated Spline")

    #dumy = 0:0.1:2pi
    #fff(zzzz) = sin(zzzz)

    #plot!(dumy, fff.(dumy), label="Org.")

    return a, b, c, d
end

# Input data points
x = [0.0, 120.0, 240.0, 360.0]
y = [0.0, 0.866, -0.866, 0.0]

# Sort the input data points by their x values
sorted_indices = sortperm(x)
x_sorted = x[sorted_indices]
y_sorted = y[sorted_indices]

# Calculate and plot the periodic spline interpolation
a, b, c, d = periodic_spline(x_sorted, y_sorted)

# Find a y-value for a specific x-value and plot it
x_value = 3.2
find_y_value(x_value, x_sorted, a, b, c, d)

