#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 4, zadanie 1, 2, 3, 4
=#

module methods
using Plots
export difference_quotients
export natural
export draw_Nnfx

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

    w = (z,k) -> (k == n ?
              fx[n]
            : fx[k] + (z - x[k]) * w(z,k+1))

    return w(t, 1)
end

function natural(x::Vector{Float64}, fx::Vector{Float64})

end

function draw_Nnfx(f::Function, a::Float64, b::Float64, n::UInt8, plot_name::String)
	h::Float64 = (b - a) / n
	res = h / 10
	x = vec([i for i in a:h:b])

	fx = difference_quotients(x, vec([f(i) for i in x]))
	XA = a:res:b

	YA_f = [f(Float64(i)) for i in XA]
	YA_N = [newton_value(x, fx, i) for i in x]

	plot(XA, YA_N)
    plot(XA, YA_f)
    savefig("graphs/" * plot_name * ".png")
end

end 