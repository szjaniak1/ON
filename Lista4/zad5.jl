#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 4, zadanie 5
=#

include("./methods.jl")
using .methods

function func_a(x::Float64)::Float64
	return exp(x)
end

function func_b(x::Float64)::Float64
	return sin(x) * x^2
end

n_values::Vector{UInt8} = [5, 10, 15]
func_a_a::Float64 = 0.0
func_a_b::Float64 = 1.0
func_b_a::Float64 = -1.0
func_b_b::Float64 = 1.0

for n in n_values
	draw_Nnfx(func_a, func_a_a, func_a_b, n, "zad5.a." * string(n))
	draw_Nnfx(func_b, func_b_a, func_b_b, n, "zad5.b." * string(n))
end