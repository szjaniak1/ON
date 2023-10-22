#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 5
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
		val = x[i] * y[i]
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

	for i in size_positive:-1:1
		S = S + S_positive[i]
	end

	for i in 1:size_negative
		S = S + S_negative[i]
	end
	S
end

function contrary_c(x, y, type)::type
	S::type = 0.0
	S_negative = type[]
	S_positive = type[]

	for i in 1:5
		val = x[i] * y[i]
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

	for i in 1:size_positive
		S = S + S_positive[i]
	end

	for i in size_negative:-1:1
		S = S + S_negative[i]
	end
	S
end

x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

println(forward(x, y, Float64))
println(backward(x, y, Float64))
println(c(x, y, Float64))
println(contrary_c(x, y, Float64))

println(forward(x, y, Float32))
println(backward(x, y, Float32))
println(c(x, y, Float32))
println(contrary_c(x, y, Float32))