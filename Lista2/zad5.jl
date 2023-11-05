#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 2, zadanie 5
=#

using Plots

function p1(p::Float32, r::Float32)
	result = Float32[]
	val::Float32 = 0.0

	push!(result, p)
	for i in 2:10
		val = result[i - 1] + r * result[i - 1] * (1 - result[i - 1])
		push!(result, val)
	end

	result[10] = round(result[10], digits=3)

	for i in 11:40
		val = result[i - 1] + r * result[i - 1] * (1 - result[i - 1])
		push!(result, val)
	end

	return result
end

function p2(p, r, type)
	result = type[]
	val::type = 0.0

	push!(result, p)
	for i in 2:40
		val = result[i - 1] + r * result[i - 1] * (1 - result[i - 1])
		push!(result, val)
	end

	return result
end

x_values = range(1, 40, length=40)
a2 = p2(Float32(0.01), Float32(3), Float32)
a1 = p1(Float32(0.01), Float32(3))
plot(x_values, [a1, a2], marker=(:circle,5), label=["1" "2"])
savefig("graphs/5.1.png")

b1 = p2(Float64(0.01), Float64(3), Float64)
b2 = p2(Float32(0.01), Float32(3), Float32)
plot(x_values, [b1, b2], marker=(:circle,5), label=["Float64" "Float32"])
savefig("graphs/5.2.png")