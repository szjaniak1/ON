#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 3
=#

function f1()
	δ::Float64 = 2^-52
	result::Float64 = 0.0
	for k in range(1, 2^52 - 1)
		result = Float64(1 + k*δ)
		println(bitstring(result) * " -- " * string(result))
	end
end

function f2()
	δ::Float64 = 2^-52 / 2
	result::Float64 = 0.0
	for k in range(1, 2^52 - 1)
		result = Float64(1/2 + k*δ)
		println(bitstring(result) * " -- " * string(result))
	end
end

function f3()
	δ::Float64 = 2^-52 * 2
	result::Float64 = 0.0
	for k in range(1, 2^52 - 1)
		result = Float64(2 + k*δ)
		println(bitstring(result) * " -- " * string(result))
	end
end

f3()