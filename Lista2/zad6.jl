#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 2, zadanie 6
=#

using Plots
using LaTeXStrings

function plotting(x::Float64, c::Int8, file_name::String)
	x_values = range(1, 40, length=40)
	y_values = func(Float64(x), Int8(c))
	plot(x_values, y_values, marker=(:circle,5), legend=false)
	title!(L"x_0 = %$x, c = %$c")
	savefig("graphs/" * file_name * ".png")  
end

function func(x::Float64, c::Int8)
	k::Int8 = 40
	result = Float64[]
	val::Float64 = 0.0

	push!(result, x)
	for i in 2:k
		val = result[i - 1]^2 + c
		push!(result, val)
	end

	return result
end


plotting(Float64(1.0), Int8(-2), "1")
plotting(Float64(2.0), Int8(-2), "2")
plotting(Float64(1.99999999999999), Int8(-2), "3")
plotting(Float64(1.0), Int8(-1), "4")
plotting(Float64(-1.0), Int8(-1), "5")
plotting(Float64(0.75), Int8(-1), "6")
plotting(Float64(0.25), Int8(-1), "7")