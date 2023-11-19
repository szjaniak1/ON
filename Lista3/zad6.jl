#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 3, zadanie 6
=#

include("./methods_module.jl")
using .methods

function func1(x::Float64)
	return exp(1.0 - x) - 1.0
end

function func1_prime(x::Float64)
	return -1.0 * exp(1.0 - x)
end

function func2(x::Float64)
	return 3.0 * x - exp(x)
end

function func2_prime(x::Float64)
	return -1.0 * exp(-1.0 * x) * (x - 1)
end

epsilon::Float64 = 10^(-5)
delta::Float64 = 10^(-5)
r1, val1, it1, err1 = bisection_method(func1, fl(0.5), fl(1.5), delta, epsilon)
println("----bisection_func1----\n",
		"r = ", r1, "\n",
		"f(r) = ", val1, "\n",
		"it = ", it1, "\n",
		bisection_error_codes[err1 + 1])

r1, val1, it1, err1 = bisection_method(func2, fl(-0.5), fl(0.5), delta, epsilon)
println("----bisection_func2----\n",
		"r = ", r1, "\n",
		"f(r) = ", val1, "\n",
		"it = ", it1, "\n",
		bisection_error_codes[err1 + 1])

maxit::UInt64 = 100
r1, val1, it1, err1 = newton_method(func1, func1_prime, fl(1.0), delta, epsilon, maxit)
println("----newton_func1----\n",
		"r = ", r1, "\n",
		"f(r) = ", val1, "\n",
		"it = ", it1, "\n",
		bisection_error_codes[err1 + 1])

r1, val1, it1, err1 = newton_method(func2, func2_prime, fl(0.0), delta, epsilon, maxit)
println("----newton_func2----\n",
		"r = ", r1, "\n",
		"f(r) = ", val1, "\n",
		"it = ", it1, "\n",
		newton_error_codes[err1 + 1])

r1, val1, it1, err1 = secant_method(func1, fl(0.0), fl(1.0), delta, epsilon, maxit)
println("----secant_func1----\n",
		"r = ", r1, "\n",
		"f(r) = ", val1, "\n",
		"it = ", it1, "\n",
		secant_error_codes[err1 + 1])

r1, val1, it1, err1 = secant_method(func2, fl(-1.0), fl(0.0), delta, epsilon, maxit)
println("----secant_func2----\n",
		"r = ", r1, "\n",
		"f(r) = ", val1, "\n",
		"it = ", it1, "\n",
		secant_error_codes[err1 + 1])

println("\n----edge_cases----\n")

r1, val1, it1, err1 = newton_method(func1, func1_prime, fl(10.0), delta, epsilon, maxit)
println("----newton_func1_edge_case----\n",
		"r = ", r1, "\n",
		"f(r) = ", val1, "\n",
		"it = ", it1, "\n",
		newton_error_codes[err1 + 1])

r1, val1, it1, err1 = newton_method(func2, func2_prime, fl(1000.0), delta, epsilon, maxit)
println("----newton_func2_edge_case----\n",
		"r = ", r1, "\n",
		"f(r) = ", val1, "\n",
		"it = ", it1, "\n",
		newton_error_codes[err1 + 1])