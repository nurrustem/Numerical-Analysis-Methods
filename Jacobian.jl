function jacobian(constraints, x, y, z, λ)
    h = 1e-8
    J = zeros(4, 4)
    for i in 1:4
        u = [x, y, z, λ]
        u[i] += h
        J[:, i] = (constraints(u[1], u[2], u[3], u[4]) - constraints(x, y, z, λ))/h
    end
    return J
end

#calculating exact jacobian matrix
function exact_jacobian(vec)
    n = length(vec)
    h = 1 / (n + 1)
    jacobian = zeros(n, n)
    jacobian[1,1] = -2 / (h^2) + exp(vec[1])  
    jacobian[1,2] = 1 / h^2  
    for i in 2:n-1
        jacobian[i, i-1] = 1 / h^2
        jacobian[i, i] = -2 / (h^2) + exp(vec[i])
        jacobian[i, i+1] = 1 / h^2
    end
    jacobian[n,n-1] = 1 / h^2
    jacobian[n,n] = -2 / (h^2) + exp(vec[n])
    return jacobian
end

#calculating jacobian matrix
function my_jacobian(F, u, tol)
    n = length(u)
    jacobian = zeros(n, n)
    for j = 1:n
        u_plus_tol = copy(u)
        u_plus_tol[j] += tol
        jacobian[ :, j] = (F(u_plus_tol) - F(u)) / tol
    end
    return jacobian
end