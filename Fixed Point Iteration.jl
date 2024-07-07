using Plots

# Define the function g(x)
g(x) = (x + 2)^(1/3)

# Set the initial guess
x0 = 1.0

# Set the tolerance and maximum number of iterations
tol = 1e-6
maxiter = 100

# Implement fixed point iteration
function fixed_point_iteration(x0, tol, maxiter)
  x = x0
  for i in 1:maxiter
      x_new = g(x)
      if abs(x_new - x) < tol
          break
      end
      x = x_new
  end
  return x
end

# Print the root
root = fixed_point_iteration(x0, tol, maxiter)
println("The root of the equation is: ", root)

# Plot g(x) and the root x
x_range = -2:0.1:2
g_range = g.(x_range)

plot(x_range, g_range, label="g(x)")
scatter!([root], [g(root)], label="root x")
title!("Fixed Point Iteration")
xlabel!("x")
ylabel!("g(x)")


