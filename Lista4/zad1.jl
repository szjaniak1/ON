#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 4, zadanie 1
=#

include("./methods.jl")
using .methods

x = Vector{Float64}([3, 1, 5, 6])
f = Vector{Float64}([1, -3, 2, 4])

fx = difference_quotients(x, f)

println(fx)