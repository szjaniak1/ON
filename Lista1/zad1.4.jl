#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 1, zadanie 1.4
=#

function max(type)::type
    machmax::type = prevfloat(one(type))
    while !isinf(type(machmax * 2))
        machmax *= 2
    end
    machmax
end

println("[Float16] wynik otrzymany funkcja floatmax: {" * string(floatmax(Float16)) * "}; wynik obliczany zaimplementowana funkcja: {" * string((max(Float16))) * "}")
println("[Float32] wynik otrzymany funkcja floatmax: {" * string(floatmax(Float32)) * "}; wynik obliczany zaimplementowana funkcja: {" * string((max(Float32))) * "}")
println("[Float64] wynik otrzymany funkcja floatmax: {" * string(floatmax(Float64)) * "}; wynik obliczany zaimplementowana funkcja: {" * string((max(Float64))) * "}")