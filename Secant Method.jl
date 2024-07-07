using Plots
using LinearAlgebra

function secant_method(f, x0, x1; tol=1e-8, max_iter=100)
    for i in 1:max_iter
        Δx = x1 - x0
        f0 = f(x0)
        f1 = f(x1)
        if abs(f1) < tol
            return x1, i
        end
        if abs(Δx) < tol
            error("Error: the method is stuck!")
        end
        x2 = x1 - f1*(x1 - x0)/(f1 - f0)
        x0 = x1
        x1 = x2
    end
    error("Error: maximum number of iterations exceeded!")
end

function plot_function_and_root(f, root, a, b)
    xx = range(a, b, length=1000)
    yy = f.(xx)
    plot(xx, yy, label="f(x)")
    plot!([root], [0], marker=:circle, markersize=5, label="root")
end

# define the function and initial points
f(x) = x^3 - 3x + 1
x0 = 0.0
x1 = 1.0

# find the root using secant method and plot the function and root
root, iter = secant_method(f, x0, x1)
println("One root of the function is: x = ", root)
println("Converged after ", iter, " iterations.")
plot_function_and_root(f, root, -2, 2)


