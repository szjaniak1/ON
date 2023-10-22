#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 1.4
=#

function max(type)::type
	machmax::type = prevfloat(one(type))
	while (!isinf(type(machmax*2)))
		machmax *= 2
	end
	machmax
end

println(string(floatmax(Float16)) * " -- " * string((max(Float16))))
println(string(floatmax(Float32)) * " -- " * string((max(Float32))))
println(string(floatmax(Float64)) * " -- " * string((max(Float64))))