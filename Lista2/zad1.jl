#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 2, zadanie 1
=#

function forward(x, y, type)::type
	S::type = 0.0
	for i in 1:5
		S = S + x[i] * y[i]
	end
	S
end

function backward(x, y, type)::type
	S::type = 0.0
	for i in 5:-1:1
		S = S + x[i] * y[i]
	end
	S
end

function c(x, y, type)::type
	S::type = 0.0
	S_negative = type[]
	S_positive = type[]

	for i in 1:5
		val::type = x[i] * y[i]
		if val < 0
			push!(S_negative, val)
		else
			push!(S_positive, val)
		end
	end

	sort!(S_negative)
	sort!(S_positive)

	size_negative = size(S_negative, 1)
	size_positive = size(S_positive, 1)

	result_positive::type = 0.0
	for i in size_positive:-1:1
		result_positive = result_positive + S_positive[i]
	end

	result_negative::type = 0.0
	for i in 1:size_negative
		result_negative = result_negative + S_negative[i]
	end
	S = result_positive + result_negative
end

function contrary_c(x, y, type)::type
	S::type = 0.0
	S_negative = type[]
	S_positive = type[]

	for i in 1:5
		val::type = x[i] * y[i]
		if val < 0
			push!(S_negative, val)
		else
			push!(S_positive, val)
		end
	end

	sort!(S_negative)
	sort!(S_positive)

	size_negative = size(S_negative, 1)
	size_positive = size(S_positive, 1)

	result_positive::type = 0.0
	for i in 1:size_positive
		result_positive = result_positive + S_positive[i]
	end

	result_negative::type = 0.0
	for i in size_negative:-1:1
		result_negative = result_negative + S_negative[i]
	end
	S = result_positive + result_negative
end

x = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

println(forward(Array{Float64}(x), Array{Float64}(y), Float64))
println(backward(Array{Float64}(x), Array{Float64}(y), Float64))
println(c(Array{Float64}(x), Array{Float64}(y), Float64))
println(contrary_c(Array{Float64}(x), Array{Float64}(y), Float64))

println(forward(Array{Float32}(x), Array{Float32}(y), Float32))
println(backward(Array{Float32}(x), Array{Float32}(y), Float32))
println(c(Array{Float32}(x), Array{Float32}(y), Float32))
println(contrary_c(Array{Float32}(x), Array{Float32}(y), Float32))