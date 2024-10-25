#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 5
=#

using Printf

function forward(x, y, type)::type
    S::type = 0.0
    for i in 1:5
        S = S + type(x[i] * y[i])
    end
    S
end

function backward(x, y, type)::type
    S::type = 0.0
    for i in 5:-1:1
        S = S + type(x[i] * y[i])
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

methods = Dict(
    "Forward" => forward,
    "Backward" => backward,
    "C" => c,
    "Contrary C" => contrary_c
)

x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

function calc_and_print(fl)
    for (name, calc) in methods
        res::fl = calc(Array{fl}(x), Array{fl}(y), fl)

        println(name * " result: ", res)
    end
end


println("Float32")
calc_and_print(Float32)
println("Float64")
calc_and_print(Float64)