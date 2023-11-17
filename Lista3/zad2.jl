#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 3, zadanie 2
=#
include("./methods_module.jl")
using .methods

function func(x::Float64)
	return x^2 - 2
end

function func_prime(x::Float64)
	return 2 * x
end

c, val, it, err = mstycznych(func, func_prime, 0.0, 30.0, 0.00001, UInt64(100))
println(c)
println(val)
println(it)
println(err)