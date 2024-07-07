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

# New input data
x = [0, 10, 15, 20, 22.5, 30]
y = [0, 227.04, 362.78, 517.35, 602.97, 901.67]
z = 0:0.1:30

yX = y
yZ = map(t -> q_spline_function(x, y, [t])[2][1], z)

scatter(x, yX)
plot!(z, yZ)

qSpline2 = q_spline_function(x, yX, z)
qSpline2z = qSpline2[1]
qSpline2q = qSpline2[2]

function find_point(x_value)
    y_value = q_spline_function(x, y, [x_value])[2][1]
    scatter!([x_value], [y_value], markersize=5, markercolor=:black)
    annotate!([(x_value, y_value + 50, text("($x_value, $y_value)", :left))])
end

find_point(10.5)