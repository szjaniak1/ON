#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 7
=#

function f(x::Float64)::Float64
	Float64(sin(x)) + Float64(cos(Float64(3*x)))
end

function derivative(x::Float64)::Float64
	Float64(cos(x)) - Float64(3 * Float64(sin(Float64(3 * x))))
end

function approx(x::Float64, h::Float64)::Float64
	(f(x + h) - f(x)) / h
end

x::Float64 = 1.0
res::Float64 = 0.0;
for n in 0:54
	res = approx(x, Float64(2.0^-n))
	println(string(n) * " -- " * string(res) * " -- " * string(abs(derivative(x) - res)))
	println(string(Float64(1.0 + 2.0^-n)))
end