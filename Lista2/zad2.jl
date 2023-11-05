#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 2, zadanie 2
=#

using Plots
using LaTeXStrings

function f(x)
	return exp(x) * log(1 + exp(-x))
end

x = range(-30, 100, length=1000)
y = f.(x)
plot(x, y, legend=false)
savefig("graphs/2.1.png")