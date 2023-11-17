#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 3, zadanie 4
=#

include("./methods_module.jl")
using .methods

function func(x::Float64)
	return sin(x) - (1/2 * x)^2
end

function func_prime(x::Float64)
	return cos(x) - x/2
end

epsilon::Float64 = (10^(-5)) / 2
delta::Float64 = (10^(-5)) / 2
r, val, it, err = bisection_method(func, fl(1.5), fl(2.0), delta, epsilon)
println("----biscetion_method----\n",
		"r = ", r, "\n",
		"f(r) = ", val, "\n",
		"it = ", it, "\n",
		bisection_error_codes[err + 1])

maxit::UInt64 = 200
r, val, it, err = newton_method(func, func_prime, fl(1.5), delta, epsilon, maxit)
println("----newton_method----\n",
		"r = ", r, "\n",
		"f(r) = ", val, "\n",
		"it = ", it, "\n",
		newton_error_codes[err + 1])

r, val, it, err = secant_method(func, fl(1.0), fl(2.0), delta, epsilon, maxit)
println("----secant_method----\n",
		"r = ", r, "\n",
		"f(r) = ", val, "\n",
		"it = ", it, "\n",
		secant_error_codes[err + 1])
