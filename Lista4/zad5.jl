#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 4, zadanie 5
=#

include("./methods.jl")
using .methods

function func(x::Float64)::Float64
	return exp(x)
end

a::Float64 = 0.0
b::Float64 = 1.0
n::UInt8 = 5

draw_Nnfx(func, a, b, n, "zad5")