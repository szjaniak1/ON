#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 6
=#

function f(x)
	sqrt(x^2 + 1) - 1
end

function g(x)
	x^2 / (sqrt(x^2 + 1) + 1)
end

for i in 1:10
	println(f(8.0^(-i)))
	println(g(8.0^(-i)))
end