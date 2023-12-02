#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 4, zadanie 1, 2, 3, 4
=#

module methods

export difference_quotients
export natural
export draw_Nnfx

using Plots

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

function newton_value(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)::Float64
	len::UInt16 = length(x)

	n_value::Float64 = fx[len]
	for k in (len - 1):-1:1
	    n_value = n_value * (t - x[k]) + fx[k]
	end

	return n_value
end

function natural(x::Vector{Float64}, fx::Vector{Float64})

end

function draw_Nnfx(f::Function, a::Float64, b::Float64, n::UInt8, plot_name::String)
	h::Float64 = (b - a) / n
	res::Float64 = h / 10
	x::Vector{Float64} = vec([i for i in a:h:b])

	fx::Vector{Float64} = difference_quotients(x, vec([f(i) for i in x]))
	XA::Vector{Float64} = a:res:b

	YA_f::Vector{Float64} = [f(Float64(i)) for i in XA]
	YA_N::Vector{Float64} = [newton_value(x, fx, i) for i in x]

	plot(XA, YA_N)
  plot(XA, YA_f)
  savefig("graphs/" * plot_name * ".png")
end

end 