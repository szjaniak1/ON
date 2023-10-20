#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 5
=#

function forward64(x, y)::Float64
	S::Float64 = 0.0
	for i in 1:5
		S = S + x[i] * y[i]
	end
	S
end

function backward64(x, y)::Float64
	S::Float64 = 0.0
	for i in 5:-1:1
		S = S + x[i] * y[i]
	end
	S
end

function c64(x, y)::Float64
	S::Float64 = 0.0
	S_negative = Float64[]
	S_positive = Float64[]

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

function contrary_c64(x, y)::Float64
	S::Float64 = 0.0
	S_negative = Float64[]
	S_positive = Float64[]

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

function forward32(x, y)::Float32
	S::Float32 = 0.0
	for i in 1:5
		S = S + x[i] * y[i]
	end
	S
end

function backward32(x, y)::Float32
	S::Float32 = 0.0
	for i in 5:-1:1
		S = S + x[i] * y[i]
	end
	S
end

function c32(x, y)::Float32
	S::Float32 = 0.0
	S_negative = Float32[]
	S_positive = Float32[]

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

function contrary_c32(x, y)::Float32
	S::Float32 = 0.0
	S_negative = Float32[]
	S_positive = Float32[]

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

println(forward64(x, y))
println(backward64(x, y))
println(c64(x, y))
println(contrary_c64(x, y))

println(forward32(x, y))
println(backward32(x, y))
println(c32(x, y))
println(contrary_c32(x, y))