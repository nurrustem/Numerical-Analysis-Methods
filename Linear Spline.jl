using Plots

function first_degree_splines(x, y, z)
    n = length(x)
    a = similar(y)
    b = similar(y)
    
    # Compute spline segment coefficients
    for i = 1:n-1
        a[i] = y[i]
        b[i] = (y[i+1] - y[i]) / (x[i+1] - x[i])
    end
    
    # Find index of spline segment containing z
    i = 1
    while i < n && x[i+1] <= z
        i += 1
    end
    
    # Evaluate spline at z
    if i == n
        s = a[n-1] + b[n-1] * (z - x[n-1])
    else
        s = a[i] + b[i] * (z - x[i])
    end
    
    # Evaluate spline at each x value
    s_vec = similar(y)
    s_vec[1] = a[1] + b[1] * x[1]
    for i = 2:n
        s_vec[i] = a[i-1] + b[i-1] * (x[i] - x[i-1])
    end
    
    # Plot data and interpolated function
    p = plot(x, y, label = "Data", marker = :circle)
    plot!(p, x[1:end-1], s_vec[1:end-1], label = "Interpolated function")
    plot!(p, [x[n-1], x[n]], [s_vec[n-1], s_vec[n]], label = "")
    scatter!(p, [z], [s], label = "Interpolated value at z", marker = :square)
    
    return s_vec, s, p
end

x = [0, 10, 15, 20, 22.5, 30]
y = [0, 227.04, 362.78, 517.35, 602.97, 901.67]
z = 6

s_vec, s, p = first_degree_splines(x, y, z)
@show s_vec
@show s

display(p) # Display the plot