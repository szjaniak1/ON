#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 1.4
=#

function max16()::Float16
	step = nextfloat(Float16(0.0))
	res::Float16 = 0.0
	while (!isinf(res))
		res = res + step
	end
	res
end

println(string(floatmax(Float16)) * " -- " * string(Float16(max16())))