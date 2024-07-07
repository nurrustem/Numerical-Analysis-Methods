include("Construct cubic equation.jl");
include("Find y value.jl");

using Plots

function clamped_spline(x, y, dy1, dyn)
    n = length(x)
    A = zeros(n, n)
    h = [x[i+1] - x[i] for i in 1:n-1]
    b = 6 * [((y[i+2] - y[i+1]) / h[i+1]) - ((y[i+1] - y[i]) / h[i]) for i in 1:n-2]
    b1 = 6 * (((y[2] - y[1]) / h[1]) - dy1)
    bend = 6 * (dyn - ((y[end] - y[end-1]) / h[end-1]))

    A[1, 1] = 2 * h[1]
A[1, 2] = h[1]
A[n, n-1] = h[n-1]
A[n, n] = 2 * h[n-1]

for i in 2:n-1
    A[i, i-1] = h[i-1]
    A[i, i] = 2 * (h[i-1] + h[i])
    A[i, i+1] = h[i]
end
b = [b1; b; bend]

z = A \ b

    a = y[1:end-1]
    b = [(y[i+1] - y[i]) / h[i] - h[i] * (z[i+1] + 2 * z[i]) / 6 for i in 1:length(z) - 1]
    c = z[1:end-1] / 2
    d = [(z[i+1] - z[i]) / (6 * h[i]) for i in 1:length(z) - 1]

    # Print coefficients
    println("Coefficients:")
    for i in 1:length(x)-1
        println([a[i], b[i], c[i], d[i]])
    end

    plot_range = collect(range(x[1], stop=x[end], length=1000))
    plot_values = [construct_equation(x_val, x, a, b, c, d) for x_val in plot_range]

    plot(x, y, st=:scatter, label="Data Points", title="Clamped Spline Interpolation")
    plot!(plot_range, plot_values, label="Interpolated Spline")

    return a, b, c, d
end

# Input data points
x = [1.0, 3.0, 4.0, 4.5, 5.0]
y = [1.0, 9.0, 16.0, 20.0, 25.0]

# Define the first and last boundary conditions 
dy1 = 4
dyn = 9.5

# Calculate and plot the clamped spline interpolation
a, b, c, d = clamped_spline(x, y, dy1, dyn)

# Find a y-value for a specific x-value and plot it
x_value = 3.2
find_y_value(x_value, x, a, b, c, d)