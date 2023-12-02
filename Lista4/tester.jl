#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 4, zadanie 1
=#

include("./methods.jl")
using .methods

using Test

x = Vector{Float64}([3, 1, 5, 6])
f = Vector{Float64}([1, -3, 2, 4])

fx = difference_quotients(x, f)
ft = newton_value(x, fx, 1.0)
n = natural(x, fx)

@test fx == [1.0, 2.0, -0.375, 0.17500000000000002]
@test ft == -3.0
@test n == [-8.75, 7.525, -1.9500000000000002, 0.17500000000000002]

println("TEST PASSED")