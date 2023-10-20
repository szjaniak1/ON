#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 4
=#

function find()
	x::Float64 = 0.0
	δ::Float64 = 2^-52
	for k in 1:2^52-1
		x = 1 + k * δ
		if (Float64(x) * Float64(1/x) != 1)
			println(string(Float64(x) * Float64(1/x)) * " -- " * string(Float64(x)))
			break
		end
	end
end

find()