#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 3, zadanie 1
=#
include("./mbisekcji.jl")
using .bisekcji

function func(x::Float64)
	return 2 * x - 10
end

c, val, it, err = mbisekcji(func, 0.0, 30.0, 0.00001, 0.00001)
println(c)
println(val)
println(it)
println(err)