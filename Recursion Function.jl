using Plots

function q_spline_function(t, y, x)
    len_of_t = length(t)
    z = []
    Q = []
    push!(z, 0)

    for i in 1:len_of_t - 1
        sol = -z[i] + 2 * ((y[i + 1] - y[i]) / (t[i + 1] - t[i]))
        push!(z, sol)
    end

    for k in x
        for i in 1:len_of_t - 1
            if k <= t[i + 1] && k >= t[i]
                res = ((z[i + 1] - z[i]) / (2 * (t[i + 1] - t[i])) * (k - t[i])^2 + z[i] * (k - t[i]) + y[i])
                push!(Q, res)
                break
            end
        end
    end
    return [z, Q]
end

# Example usage:
x = -10:10
y = x -> 1 / (1 + x^2)
z = -5:0.1:5
yX = map(j -> y(j), x)
yZ = map(t -> y(t), z)

scatter(x, yX)
plot!(z, yZ)

qSpline2 = q_spline_function(x, yX, z)
qSpline2z = qSpline2[1]
qSpline2q = qSpline2[2]

display(qSpline2q)
display(plot!(z, qSpline2q))