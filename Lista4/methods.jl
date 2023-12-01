#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 4, zadanie 1, 2, 3, 4
=#

# using Plots

module methods

export difference_quotients

function difference_quotients(x::Vector{Float64}, f::Vector{Float64})::Vector{Float64}
	fx::Vector{Float64} = []
	f_copy::Vector{Float64} = copy(f)
	len::UInt16 = length(x)

	for i in 1:(len)
		for k in (i - 1):-1:1
			a = f_copy[k + 1] - f_copy[k]
			b = (x[i] - x[k])
            f_copy[k] = a/b
        end
        push!(fx, f_copy[1])
    end

	return fx
end

function newton_value(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
	n = length(x)

end

function natural(x::Vector{Float64}, fx::Vector{Float64})

end

function draw_Nnfx(f::Function, a::Float64, b::Float64, n::UInt8)

end

end 