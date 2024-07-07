function find_y_value(x_value, x, a, b, c, d)
    y_value = construct_equation(x_value, x, a, b, c, d)
    println("For x = ", x_value, ", y = ", y_value)

    scatter!([x_value], [y_value], label="x-value", markersize=6, markercolor=:red)
end