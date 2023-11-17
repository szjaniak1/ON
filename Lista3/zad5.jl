#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 3, zadanie 5
=#

include("./methods_module.jl")
using .methods

function func(x::Float64)
	return 3*x - exp(x)
end

epsilon::Float64 = 10^(-4)
delta::Float64 = 10^(-4)
r, val, it, err = bisection_method(func, fl(0.0), fl(1.0), delta, epsilon)
println("----first_root----\n",
		"r = ", r, "\n",
		"f(r) = ", val, "\n",
		"it = ", it, "\n",
		bisection_error_codes[err + 1])

r, val, it, err = bisection_method(func, fl(1.0), fl(2.0), delta, epsilon)
println("----second_root----\n",
		"r = ", r, "\n",
		"f(r) = ", val, "\n",
		"it = ", it, "\n",
		bisection_error_codes[err + 1])