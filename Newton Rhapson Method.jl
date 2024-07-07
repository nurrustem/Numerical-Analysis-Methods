using Plots
using LinearAlgebra

function newton(f, f′, x₀; tol = 1e-8, maxiter = 100)
    x = x₀
    for i in 1:maxiter
        fx = f(x)
        if abs(fx) < tol
            break
        end
        dfx = f′(x)
        Δx = -fx/dfx
        x += Δx
    end
    return x
end

function plot_function_and_root(f, root, a, b)
    x_values = LinRange(a, b, 1000)
    y_values = f.(x_values)
    plot(x_values, y_values, label = "Function")
    display(plot!([root], [0], marker = :circle, markersize = 5, color = :red, label = "Root"))
    xlabel!("x")
    ylabel!("f(x)")
    title!("Function and Root")
end

# Define the function and its derivative
f(x) = x^3 - 2x - 5
f′(x) = 3x^2 - 2

# Initial guess
x₀ = 2.0

# Find the root using Newton-Raphson method
root = newton(f, f′, x₀)

# Print the root
println("One root of the function is: x = ", root)

# Plot the function and root
plot_function_and_root(f, root, -5, 5)

f(x) = x^3 - 2x - 5
f′(x) = 3x^2 - 2
x₀ = 2.0