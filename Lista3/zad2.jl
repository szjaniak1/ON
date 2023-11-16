#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 3, zadanie 2
=#

using .mstycznych

function func(x::Float64)
	return x^2 - 2
end

function func_prime(x::Float64)
	return 2 * x
end