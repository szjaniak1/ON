#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 6
=#

function f(x::Float64)::Float64
	Float64(sqrt(Float64(x^2) + one(Float64)) - one(Float64))
end

function g(x::Float64)::Float64
	Float64(Float64(x^2) / (Float64(sqrt(Float64(x^2) + one(Float64))) + one(Float64)))
end

for i in 1:10
	println(f(Float64(8.0^(-i))))
	println(g(Float64(8.0^(-i))))
end