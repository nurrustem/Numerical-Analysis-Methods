include("jacobian.jl");

function my_newton_method(f, u0, maxiter, tol)
    for i = 1:maxiter
        jacobian = my_jacobian(f, u0, tol)
        jacobian_inv = inv(copy(jacobian))
        y = jacobian_inv * (-f(u0))
        un = u0 + y
        if(norm(y)) < tol
            return un
        end
        u0 = un
    end
end

function newton_method(constraints, jacobian, x0, y0, z0, λ0, tol=1e-8, max_iter=100)
    x = x0
    y = y0
    z = z0
    λ = λ0
    for i in 1:max_iter
        f = constraints(x, y, z, λ)
        if norm(f) < tol
            break
        end
        Jf = jacobian(constraints, x, y, z, λ)
        Δu = -Jf\f
        x += Δu[1]
        y += Δu[2]
        z += Δu[3]
        λ += Δu[4]
    end
    return (x, y, z, λ)
end

function my_newton_method_exact(f, u0, maxiter, tol)
    for i = 1:maxiter
        jacobian = exact_jacobian(u0)
        jacobian_inv = inv(copy(jacobian))
        y = jacobian_inv * (-f(u0))
        un = u0 + y
        if(norm(f(un)) < tol)
            return un
        end
        u0 = un
    end
end